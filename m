Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03B606A32D
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kZOOCDew;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jr5IWimk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KgjaECvS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YrckBOhe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1S78HlGWNw6w0mQJqBy+Tp3jQLPqUG+hP7vahW8Ks8Q=; b=kZOOCDeww5apP8e6WDLH9efi/Z
	L/D+ZDllsKv3JiRkAPMKhUz8SWQdprzqioh00xD45EG+JG87xAeAokNOEwcwvWfW4AB3CZdv+xoa0
	O7Q7zqUCGqju1P68LiweLzT8s04mr30gybQihMWmvuGHX5wGyvUKTny6915OOxALSZuk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLB-000000005EZ-49WY;
	Thu, 12 Nov 2026 17:12:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYL6-000000005E1-1vnd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q5J69apSC/Yoxd2JGdeuWCMne/LKaKGFOoO8Jn2xhDQ=; b=jr5IWimkgFR7OseUFyyiZnLsc0
 aQyW9Wrs13YFPqcx+UerSlgMRPjn6iGPWZMp7P0CnSQBRbBeDVWb/dzB+Y9WJBryqHDczPrTKXZGb
 msON6utKFc5g/zfQjpLdPIj+PtyU0nlykELa2hYkD/Co+CxY451ohgyqsuaq4oomHqpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q5J69apSC/Yoxd2JGdeuWCMne/LKaKGFOoO8Jn2xhDQ=; b=KgjaECvSSv7L+ZKsWOogx/oq6E
 l3+yDPxVPv7uvwkcaXUtasN/W1LwH+MwctLROl9sZ29cRFW1X5WPFPA3Sj2DKVYtYNbJufh4Z5KqQ
 b2E57L9vmC25fpy2fn+cvpuGMIdzRMuqufSTte97nrCeSDXnyJLSh6g3TBd7KMcMV8XM=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYKv-000000002wM-30tE for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so433825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503499; x=1795108299; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q5J69apSC/Yoxd2JGdeuWCMne/LKaKGFOoO8Jn2xhDQ=;
 b=YrckBOheZkVwL6cx0gUjPzWKj59ltSITVsZdPElxMoq2Z27O/FLG0tNLsoQP8mttSp
 ycUbmUXpMHJW35cV1XUS9YvCyL+IFL/VAgGGxBTtYMiFIY4cLQvX+D65XuRIo4Pi5iFq
 TNN0RweBYSs66O5/puchKkZEmnnORY6b9FCQ+kZY0hT6POtrJTPjS0zjVHgmNuK4/biM
 uSUWxTY2HsAQqXhFFGyf6kDdTXQtW1ZiHEJsbRvzZCuw2174RANMRelotItOf93daor9
 MNFHCWGae5RKVoCMGvSuulWgPFkdDAh6nZKnGWrhSfjyx6wgB7MUBM+TK3WrxSfTxMEN
 MYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503499; x=1795108299;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q5J69apSC/Yoxd2JGdeuWCMne/LKaKGFOoO8Jn2xhDQ=;
 b=dk84lAognv5/OL8hkVVjfVqhiOjnV8udnm2hQfhLrJU+YHCRl3xq276ZFw0tfoVS8h
 zLCCu2RfJCvwZEGJ5EIpeNGATRgBsYjcH/THdwNjfmVXEsk7kdMtvj8b51jzXH/p+sGk
 d9gsM6COvPaE+rztPBpdvWFKb3+CvKrWd4oOOUTlWp2IpBKy7l9Lf29h8GuUlBDD7GrS
 Wd5RdD36yIR8mA1QvYDTu6YgSbfAcMo46EBu5yeTjMk630CnU5GVX5N7O/2lOu5qyCni
 dpouwQXOqTDtcj7KGJQYJB4iWVBJ/HKFU8yQVVNSRKJq3Y+fvpnjkTwUzfao7XDQTtGf
 +Ezg==
X-Gm-Message-State: APuU4Z8NBXU6r66rxiXXDZLQBhXgYx6rvqw1NbxA000QMLnpvTBNGf6S
 7COYpQhrXeccaSPYyTi0qYXP6B/a/SJECUcNHQkW66OT7gBUVpvz2vLI4AIkhkdomudeIEau8ys
 MUKLg6ujxH6E2Oa5XhSqDuFnvZJP6pR5kmeAfNbYWA+O5sYzo6484/tz5tCq4RwM7gwOP
X-Gm-Gg: AYBFou3IVYnUD3e8hmsO0MzCYWKehH9QiDWy+nrq/6F81wWKLD6J80vt2gnVHzp+4cC
 39FprEnEggQ6154YUndWjD86rRfL0aDLl2ztKzfuyJgnaiYLtPcylxurJw6W9OBkRlf3nvkXxHO
 7EwcZER76JCh8L3zNXajrWXeFaUcvNf3l0g+WWEeY+UO9pSSpDivAnxQCqy1aJd7AM5UCTKxAai
 wFtMOVymcnj7F7wbRz8wmQ+URqh8pPKY9hcS/O1ycW05O5xLOq45Yv4IRcRnFrL7UI01VlqvBpd
 eCMMQ3cw51e3ZOIzRLWBX+k0XvrFcFT7WR7ATE6KBBVdc2sVsofDNM4f8zvJBEmCb1enh5JWsyf
 SbrPvPheL52Z0A0N3CyGB2KZ2q30XzPZJ++PlCwqLAznb9gjZELzlC+UCOlspUp8W1yjigV+iou
 L/OvacHwWM2g+5H+AENYtbdFDptKDtDjxWvG0oul/hrx63WJqwmSszh7COgCL/utg0uDO30Flq2
 4Amtv4WxBssB0d2HHHtjCKJfK55+dp8Qm37xmmTzAdqcW6LdwaQ5ynnbmO5wVwRpavjpVZVNFCz
 yJ4tNzdiayiexqjXosFlsiryjH3qU0eHZqqF3gONu0RX8dX3DZ6ZWVqwkbtZl2LwyYaLQ/3Nl8r
 3itdBSyueh75n2f18EP7LEtoYuMv7qd7z1nmEi6TWZ5YZfmWLcm9tfRGJr4whyHg5TiAEhILbbY
 TlKT/1bt12coBZSkw=
X-Received: by 2002:a05:600c:a311:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4ba2bfcca58mr79958035e9.10.1794503496911; 
 Thu, 12 Nov 2026 09:11:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29daa5sm88586625e9.12.2026.11.12.09.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:11:36 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:11:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
X-Gerrit-Change-Number: 1186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1186?usp=email>
X-Gerrit-Commit: 08b1138c60a189639ecbb7b4700c5e60c4ce2e2f
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU3OTM3OTA1MDAwLkllY2Y1MDJlYzgxMWU5OWM1NjY0N2IyZDQ1Mjk4ZmEwZmI2Njk2MGZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2da51a17ba8656c3535eda4c8b8df714c05209bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYKv-000000002wM-30tE
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3992784510260860158=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3992784510260860158==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LK/DbW1Zkak="; charset=UTF-8

--LK/DbW1Zkak=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1186?usp=3Demail

to look at the new patch set (#20)=2E

The =
following approvals got outdated and were removed:
Code-Review-1 by R=C4=83=
zvan Cojocaru


Change subject: Enable -Wsign-conversion
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Enable -Wsign-conversion

As be=
fore with -Wconversion override all the known issues
to be able to address =
them one by one=2E

Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
Si=
gned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M CMakeLists=
=2Etxt
M configure=2Eac
M src/openvpn/acc=2Ec
M src/openvpn/argv=2Ec
M src/=
openvpn/auth_token=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M =
src/openvpn/comp-lz4=2Ec
M src/openvpn/console_builtin=2Ec
M src/openvpn/co=
nsole_systemd=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M=
 src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/open=
vpn/cryptoapi=2Ec
M src/openvpn/dco=2Ec
M src/openvpn/dco_freebsd=2Ec
M src=
/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/dhcp=2Ec
M s=
rc/openvpn/dns=2Ec
M src/openvpn/env_set=2Ec
M src/openvpn/error=2Ec
M src/=
openvpn/error=2Eh
M src/openvpn/event=2Ec
M src/openvpn/fdmisc=2Ec
M src/op=
envpn/fdmisc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/fragment=2Ec
M src=
/openvpn/helper=2Ec
M src/openvpn/init=2Ec
M src/openvpn/lzo=2Ec
M src/open=
vpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/mss=2Ec
M src/openvpn/m=
tcp=2Ec
M src/openvpn/mtu=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi_i=
o=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/occ=2Ec
M src/openvp=
n/openvpn=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options_parse=2Ec
M s=
rc/openvpn/options_show=2Ec
M src/openvpn/options_string=2Ec
M src/openvpn/=
options_util=2Ec
M src/openvpn/packet_id=2Ec
M src/openvpn/ping=2Ec
M src/o=
penvpn/pkcs11=2Ec
M src/openvpn/pkcs11_openssl=2Ec
M src/openvpn/platform=
=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/proxy=2E=
c
M src/openvpn/ps=2Ec
M src/openvpn/push=2Ec
M src/openvpn/reliable=2Ec
M =
src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M s=
rc/openvpn/socket_util=2Ec
M src/openvpn/socks=2Ec
M src/openvpn/ssl=2Ec
M =
src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_ope=
nssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn=
/ssl_verify=2Ec
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_veri=
fy_openssl=2Ec
M src/openvpn/status=2Ec
M src/openvpn/tls_crypt=2Ec
M src/o=
penvpn/tun=2Ec
M src/openvpn/tun_afunix=2Ec
M src/openvpn/vlan=2Ec
M src/op=
envpn/wfp_block=2Ec
M src/openvpn/win32-util=2Ec
M src/openvpn/win32=2Ec
M =
src/openvpn/xkey_helper=2Ec
M src/openvpn/xkey_provider=2Ec
M src/openvpnms=
ica/dllmain=2Ec
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=
=2Ec
M src/plugins/auth-pam/auth-pam=2Ec
M src/tapctl/tap=2Ec
M tests/unit_=
tests/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M =
tests/unit_tests/openvpn/test_cryptoapi=2Ec
M tests/unit_tests/openvpn/test=
_dhcp=2Ec
M tests/unit_tests/openvpn/test_networking=2Ec
M tests/unit_tests=
/openvpn/test_pkt=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
M tests/unit_=
tests/openvpn/test_tls_crypt=2Ec
M tests/unit_tests/openvpn/test_user_pass=
=2Ec
96 files changed, 1,116 insertions(+), 11 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1186/20

diff --gi=
t a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 5cf1a30=2E=2Ea90eb1a 100644
-=
-- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -117,7 +117,7 @@
     check=
_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
     =
check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     chec=
k_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
-    add=
_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_option=
s(-Wconversion)
     add_compile_options(-Wextra -Wno-unused-parameter)
   =
  # clang doesn't have the different levels but also doesn't include it in =
-Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImpl=
icitFallthrough)
diff --git a/configure=2Eac b/configure=2Eac
index 5f18798=
=2E=2Eea338d8 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -1249,7 +=
1249,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
 ACL_CHE=
CK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-=
Wold-style-definition])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sig=
n-conversion])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion])
 ACL_CHECK_ADD_=
COMPILE_FLAGS([-Wall])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-unused-pa=
rameter])
 # clang doesn't have the different levels but also doesn't inclu=
de it in -Wextra
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
ind=
ex 455f56d=2E=2Ee21891d 100644
--- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/=
acc=2Ec
@@ -148,6 +148,11 @@
     return parse_acc_message_flags(flags, err=
_reason, gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#end=
if
+
 void
 receive_acc_message(struct context *c, const struct buffer *buf=
fer)
 {
@@ -236,6 +241,10 @@
 }
 
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 send_acc_message(struct =
context *c,
                  struct tls_multi *multi,
diff --git a/src/ope=
nvpn/argv=2Ec b/src/openvpn/argv=2Ec
index 028671d=2E=2Ec716e5b0 100644
---=
 a/src/openvpn/argv=2Ec
+++ b/src/openvpn/argv=2Ec
@@ -323,6 +323,11 @@
   =
  return f;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif=

+
 /**
  *  Create a struct argv based on a format string
  *
@@ -418,6 +4=
23,10 @@
     return res;
 }
 
+#if defined(__GNUC__) || defined(__clang__)=

+#pragma GCC diagnostic pop
+#endif
+
 /**
  *  printf() variant which pop=
ulates a struct argv=2E  It processes the
  *  format string with the provi=
ded arguments=2E  For each space separator found
diff --git a/src/openvpn/a=
uth_token=2Ec b/src/openvpn/auth_token=2Ec
index 84558af=2E=2E211af90 10064=
4
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -36,=
6 +36,11 @@
  * padding */
 static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOK=
EN_DATA_LEN is not a multiple of 3");
 
+#if defined(__GNUC__) || defined(_=
_clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Ws=
ign-conversion"
+#endif
+
 bool
 is_auth_token(const char *password)
 {
@@ =
-291,6 +296,9 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 static bool
 check_hmac_t=
oken(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *username)
diff=
 --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 8813fa5=2E=
=2E7f142c4f 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2E=
c
@@ -92,6 +92,11 @@
     return buf;
 }
 
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "=
-Wsign-conversion"
+#endif
+
 struct buffer
 #ifdef BUF_INIT_TRACKING
 clon=
e_buf_debug(const struct buffer *buf, const char *file, int line)
@@ -305,6=
 +310,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang=
__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Garbage collection
  */
@=
@ -439,6 +448,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__=
)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conv=
ersion"
+#endif
+
 /*
  * Hex dump -- Output a binary buffer to a hex strin=
g and return it=2E
  */
@@ -538,6 +552,10 @@
     buf_null_terminate(buf);
=
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic p=
op
+#endif
+
 const char *
 skip_leading_whitespace(const char *str)
 {
@@ =
-717,6 +735,11 @@
     return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push=

+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 buf_s=
tring_compare_advance(struct buffer *src, const char *match)
 {
@@ -731,6 +=
754,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma=
 GCC diagnostic pop
+#endif
+
 int
 buf_substring_len(const struct buffer *=
buf, int delim)
 {
@@ -957,6 +984,11 @@
     return false;
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline bool
 char=
_inc_exc(const char c, const unsigned int inclusive, const unsigned int exc=
lusive)
 {
@@ -964,6 +996,10 @@
            && !char_class((unsigned char)c=
, exclusive);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 bool
 string_class(const char *str, const unsig=
ned int inclusive, const unsigned int exclusive)
 {
@@ -1241,6 +1277,11 @@
=
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 v=
oid
 buffer_list_aggregate_separator(struct buffer_list *bl, const size_t m=
ax_len, const char *sep)
 {
@@ -1286,6 +1327,10 @@
     }
 }
 
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 voi=
d
 buffer_list_aggregate(struct buffer_list *bl, const size_t max)
 {
@@ -1=
323,6 +1368,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
=
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conver=
sion"
+#endif
+
 struct buffer_list *
 buffer_list_file(const char *fn, int=
 max_line_len)
 {
@@ -1402,3 +1452,7 @@
     buf_advance(buf, field_len + 1=
);
     return field;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/buffer=2Eh b/src/=
openvpn/buffer=2Eh
index 7af4444=2E=2Eede3066 100644
--- a/src/openvpn/buff=
er=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -643,6 +643,11 @@
     return true;
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
Initialise a buffer with an externally provided writable memory region=2E
 =
 *
@@ -1619,6 +1624,10 @@
     return memcmp(CBPTR(src), match, size) =3D=
=3D 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic pop
+#endif
+
 /**
  * Return true if the head of \c src matches the =
string \c match=2E
  *
diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/=
comp-lz4=2Ec
index 57c6bb3=2E=2E0c5f22f 100644
--- a/src/openvpn/comp-lz4=
=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -89,6 +89,11 @@
     compv2_escape_d=
ata_ifneeded(buf);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#prag=
ma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
=
+#endif
+
 static void
 do_lz4_decompress(int zlen_max, struct buffer *work=
, struct buffer *buf,
                   struct compress_context *compctx)
=
@@ -198,6 +203,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang_=
_)
+#pragma GCC diagnostic pop
+#endif
+
 const struct compress_alg lz4_alg=
 =3D { "lz4", lz4_compress_init, lz4_compress_uninit, lz4_compress,
       =
                                lz4_decompress };
 
diff --git a/src/openvp=
n/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index 4737677=2E=2E=
dc71d12 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/cons=
ole_builtin=2Ec
@@ -41,6 +41,11 @@
 #include <termios=2Eh>
 #endif
 
+#if d=
efined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragm=
a GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #ifdef _WIN32
 
 #i=
nclude "win32=2Eh"
@@ -289,3 +294,7 @@
 
     return ret;
 }
+
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff -=
-git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec
in=
dex eaed24e=2E=2E8fc7f72 100644
--- a/src/openvpn/console_systemd=2Ec
+++ b=
/src/openvpn/console_systemd=2Ec
@@ -53,6 +53,11 @@
     return (sd_booted(=
) > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) =3D=3D 0);
 }
 
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC =
diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 get_console_=
input_systemd(const char *prompt, const bool echo, char *input, const int c=
apacity)
 {
@@ -86,6 +91,10 @@
     return ret;
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  *  Syst=
emd aware implementation of query_user_exec()=2E  If systemd is not running=

  *  it will fall back to use query_user_exec_builtin() instead=2E
diff --=
git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index a8ad7f0=2E=2E33=
e0376 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -=
62,6 +62,11 @@
  * happen unless the frame parameters are wrong=2E
  */
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#=
pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 o=
penvpn_encrypt_aead(struct buffer *buf, struct buffer work, struct crypto_o=
ptions *opt)
 {
@@ -1577,6 +1582,10 @@
     return nbits;
 }
 
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 voi=
d
 must_have_n_keys(const char *filename, const char *option, const struct =
key2 *key2, int n)
 {
diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openv=
pn/crypto_epoch=2Ec
index 35f9b55=2E=2E312cf6f 100644
--- a/src/openvpn/cry=
pto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -38,6 +38,11 @@
 #inclu=
de "buffer=2Eh"
 #include "integer=2Eh"
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 void
 ovpn_hkdf_expand(const uint8_t *secret, =
const uint8_t *info, size_t info_len,
                  uint8_t *out, size_=
t out_len)
@@ -458,3 +463,7 @@
         epoch_iterate_send_key(opt);
     }=

 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic =
pop
+#endif
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypt=
o_mbedtls=2Ec
index 3a2a8c6=2E=2Eceaaad4 100644
--- a/src/openvpn/crypto_mb=
edtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -821,6 +821,11 @@
     AS=
SERT(hmac_length =3D=3D dst_size);
 }
 
+#if defined(__GNUC__) || defined(_=
_clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Ws=
ign-conversion"
+#endif
+
 /*
  * Generate the hash required by for the \c =
tls1_PRF function=2E
  *
@@ -1149,4 +1154,8 @@
     return ret;
 }
 
+#if d=
efined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
=
+
 #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/cry=
pto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index b7f2ef3=2E=2E0a1d00c=
 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_opens=
sl=2Ec
@@ -487,6 +487,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) ||=
 defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ig=
nored "-Wsign-conversion"
+#endif
+
 bool
 crypto_pem_decode(const char *na=
me, struct buffer *dst, const struct buffer *src)
 {
@@ -1306,6 +1311,10 @@=

 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 m=
emcmp_constant_time(const void *a, const void *b, size_t size)
 {
diff --gi=
t a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec
index ef3c94c=2E=
=2E30a5144 100644
--- a/src/openvpn/cryptoapi=2Ec
+++ b/src/openvpn/cryptoa=
pi=2Ec
@@ -62,7 +62,7 @@
     return 0;
 }
 
-#else  /* HAVE_XKEY_PROVIDER =
*/
+#else /* HAVE_XKEY_PROVIDER */
 
 static XKEY_EXTERNAL_SIGN_fn xkey_cng=
_sign;
 
@@ -260,6 +260,11 @@
     return false;
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
+#endif
+
 static const CERT_CONTEXT *
 find_=
certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -5=
98,6 +603,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 SSL_CTX_use_CryptoAPI_cer=
tificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 {
diff --git a/src/openv=
pn/dco=2Ec b/src/openvpn/dco=2Ec
index f3b5d44=2E=2E236be93 100644
--- a/sr=
c/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -50,6 +50,11 @@
 #include <c=
ap-ng=2Eh>
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#e=
ndif
+
 static int
 dco_install_key(struct tls_multi *multi, struct key_sta=
te *ks, const uint8_t *encrypt_key,
                 const uint8_t *encrypt=
_iv, const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
@@ -807,4 +812,=
8 @@
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defi=
ned(_WIN32) */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic pop
+#endif
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/=
src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 3148f10=2E=
=2E11b8dff 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_f=
reebsd=2Ec
@@ -577,6 +577,11 @@
         __func__, peerid, mi->context=2Ec2=
=2Edco_read_bytes, mi->context=2Ec2=2Edco_write_bytes);
 }
 
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC di=
agnostic ignored "-Wsign-conversion"
+#endif
+
 int
 dco_read_and_process(d=
co_context_t *dco)
 {
@@ -762,6 +767,10 @@
     return available;
 }
 
+#if=
 defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endi=
f
+
 const char *
 dco_version_string(struct gc_arena *gc)
 {
diff --git a/=
src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index a84e310=2E=2E60=
107c4 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2E=
c
@@ -220,6 +220,11 @@
     return sock;
 }
 
+#if defined(__GNUC__) || def=
ined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignore=
d "-Wsign-conversion"
+#endif
+
 int
 dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, int sd, struct sockaddr *localaddr,
              struct s=
ockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
@@ -1257,6 +1262,10 @@=

     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragm=
a GCC diagnostic pop
+#endif
+
 int
 dco_get_peer_stats(struct context *c, =
const bool raise_sigusr1_on_err)
 {
diff --git a/src/openvpn/dco_win=2Ec b/=
src/openvpn/dco_win=2Ec
index 12b0666=2E=2Ea854045 100644
--- a/src/openvpn=
/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -220,6 +220,11 @@
     return=
 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 stat=
ic void
 dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struc=
t signal_info *sig_info)
 {
@@ -1091,6 +1096,10 @@
     gc_free(&gc);
 }
 
=
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#=
endif
+
 bool
 dco_supports_epoch_data(const struct context *c)
 {
diff --g=
it a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index 19e9e2d=2E=2E525d567=
 100644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -72,6 +72,=
11 @@
     return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversio=
n"
+#endif
+
 static in_addr_t
 do_extract(struct dhcp *dhcp, int optlen)
 =
{
@@ -186,6 +191,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #if defined(_WIN32) || =
defined(DHCP_UNIT_TEST)
 
 /*
@@ -327,6 +336,11 @@
     buf_write(buf, tmp_=
buf, len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC d=
iagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
=
+
 bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_=
options *o)
 {
@@ -375,4 +389,8 @@
     return !error;
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif=
 /* defined(_WIN32) */
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=
=2Ec
index abe30ed=2E=2Ee2cb981 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/=
openvpn/dns=2Ec
@@ -58,6 +58,11 @@
     return true;
 }
 
+#if defined(__GN=
UC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
+#endif
+
 bool
 dns_server_addr_parse(st=
ruct dns_server *server, const char *addr)
 {
@@ -144,6 +149,10 @@
     ret=
urn true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic pop
+#endif
+
 bool
 dns_domain_list_append(struct dns_domain **en=
try, char **domains, struct gc_arena *gc)
 {
@@ -402,6 +411,11 @@
     }
 }=

 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pus=
h
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static voi=
d
 run_up_down_service(bool add, const struct options *o, const struct tunt=
ap *tt)
 {
@@ -476,7 +490,11 @@
     send_msg_iservice(o->msg_channel, &nrp=
t, sizeof(nrpt), &ack, "DNS");
 }
 
-#else  /* ifdef _WIN32 */
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
+#el=
se /* ifdef _WIN32 */
 
 static void
 setenv_dns_option(struct env_set *es,=
 const char *format, size_t i, size_t j, const char *value)
@@ -702,6 +720,=
11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+=
#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
+#endif
+
 static void
 run_up_down_command(bool up, struct options *o=
, const struct tuntap *tt,
                     struct dns_updown_runner_in=
fo *updown_runner)
@@ -780,6 +803,10 @@
     msg(M_INFO, "dns %s command ex=
ited with status %d", up ? "up" : "down", status);
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* =
_WIN32 */
 
 void
diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_se=
t=2Ec
index 67a5bf5=2E=2Ed59115a 100644
--- a/src/openvpn/env_set=2Ec
+++ b=
/src/openvpn/env_set=2Ec
@@ -432,6 +432,11 @@
     return (script_security(=
) >=3D SSEC_PW_ENV || !is_password_env_var(str));
 }
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnost=
ic ignored "-Wsign-conversion"
+#endif
+
 /* Make arrays of strings */
 
 c=
onst char **
@@ -470,3 +475,7 @@
     ret[i] =3D NULL;
     return (const c=
har **)ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic pop
+#endif
diff --git a/src/openvpn/error=2Ec b/src/openvpn/err=
or=2Ec
index 32d819d=2E=2Ea3f7990 100644
--- a/src/openvpn/error=2Ec
+++ b/=
src/openvpn/error=2Ec
@@ -219,6 +219,11 @@
     va_end(arglist);
 }
 
+#if =
defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC d=
iagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
=
+
 static const char *
 openvpn_strerror(int err, bool crt_error, struct gc=
_arena *gc)
 {
@@ -689,6 +694,10 @@
     }
 }
 
+#if defined(_WIN32) && (de=
fined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
=
+
 /*
  * In multiclient mode, put a client-specific prefix
  * before each=
 message=2E
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
inde=
x 373cbc1=2E=2E0056d05 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn=
/error=2Eh
@@ -406,6 +406,11 @@
 }
 #endif
 
+#if defined(_WIN32) && (defin=
ed(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma G=
CC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline int
 ope=
nvpn_errno_maybe_crt(bool *crt_error)
 {
@@ -426,6 +431,10 @@
     return e=
rr;
 }
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
=
+#pragma GCC diagnostic pop
+#endif
+
 #include "errlevel=2Eh"
 
 #endif /*=
 ifndef ERROR_H */
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=
=2Ec
index 5e17ea1=2E=2Ec4a856d 100644
--- a/src/openvpn/event=2Ec
+++ b/sr=
c/openvpn/event=2Ec
@@ -486,6 +486,11 @@
 #endif
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
+#endif
+
 static struct event_set *
 we_init=
(int *maxevents, unsigned int flags)
 {
@@ -524,8 +529,17 @@
     return (s=
truct event_set *)wes;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic pop
+#endif
+
 #endif /* _WIN32 */
 
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diag=
nostic ignored "-Wsign-conversion"
+#endif
+
 #if EPOLL
 
 struct ep_set
@@=
 -1122,6 +1136,10 @@
 }
 #endif /* SELECT */
 
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static struct event=
_set *
 event_set_init_simple(int *maxevents, unsigned int flags)
 {
diff -=
-git a/src/openvpn/fdmisc=2Ec b/src/openvpn/fdmisc=2Ec
index 6910f81=2E=2Ee=
715964 100644
--- a/src/openvpn/fdmisc=2Ec
+++ b/src/openvpn/fdmisc=2Ec
@@ =
-31,6 +31,11 @@
 
 #include "memdbg=2Eh"
 
+#if defined(_WIN32) && (defined=
(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* Set a file descriptor=
 to non-blocking */
 bool
 set_nonblock_action(socket_descriptor_t fd)
@@ -=
50,6 +55,10 @@
     return true;
 }
 
+#if defined(_WIN32) && (defined(__GN=
UC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+
 /* Set =
a file descriptor to not be passed across execs */
 bool
 set_cloexec_actio=
n(socket_descriptor_t fd)
diff --git a/src/openvpn/fdmisc=2Eh b/src/openvpn=
/fdmisc=2Eh
index eac8075=2E=2E15ee3cd 100644
--- a/src/openvpn/fdmisc=2Eh
=
+++ b/src/openvpn/fdmisc=2Eh
@@ -35,6 +35,11 @@
 
 void set_cloexec(socket_=
descriptor_t fd);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#en=
dif
+
 static inline void
 openvpn_fd_set(socket_descriptor_t fd, fd_set *s=
etp)
 {
@@ -45,4 +50,8 @@
 }
 #undef FD_SET /* prevent direct use of FD_SET=
() */
 
-#endif        /* FD_MISC_H */
+#if defined(__GNUC__) || defined(__=
clang__)
+#pragma GCC diagnostic pop
+#endif
+
+#endif /* FD_MISC_H */
diff=
 --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 82cb6c9=2E=
=2Ebcad559 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=
=2Ec
@@ -286,6 +286,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
+#endif
+
 /*
  * Handle incoming configuration
  * messages =
on the control channel=2E
@@ -2033,6 +2038,10 @@
     check_timeout_random_=
component(c);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 void
 multi_io_process_flags(struct context *c,=
 struct event_set *es, struct link_socket *sock, const unsigned int flags)
=
 {
diff --git a/src/openvpn/fragment=2Ec b/src/openvpn/fragment=2Ec
index c=
454434=2E=2E55f2a08 100644
--- a/src/openvpn/fragment=2Ec
+++ b/src/openvpn=
/fragment=2Ec
@@ -40,6 +40,11 @@
         goto error; \
     }
 
+#if defin=
ed(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GC=
C diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 fragment_l=
ist_buf_init(struct fragment_list *list, const struct frame *frame)
 {
@@ -=
284,6 +289,10 @@
     ASSERT(buf_write_prepend(buf, &flags, sizeof(flags)))=
;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic=
 pop
+#endif
+
 /*
  * Without changing the number of fragments, return a p=
ossibly smaller
  * max fragment size that will allow for the last fragment=
 to be of
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec
inde=
x 6b5fcee6=2E=2Ed9ddf6a 100644
--- a/src/openvpn/helper=2Ec
+++ b/src/openv=
pn/helper=2Ec
@@ -148,6 +148,11 @@
 }
 
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 /*
  * Process server, server-bridge, and clie=
nt helper
  * directives after the parameters themselves have been
@@ -507,=
6 +512,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__cl=
ang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  *
  * HELPER DIRECTIVE:
=
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 29c24f2=2E=
=2E5235c4f 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ =
-103,6 +103,11 @@
     c->persist =3D cpsave;
 }
 
+#if defined(__GNUC__) |=
| defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic i=
gnored "-Wsign-conversion"
+#endif
+
 /*
  * Pass tunnel endpoint and MTU p=
arms to a user-supplied script=2E
  * Used to execute the up/down script/pl=
ugins=2E
@@ -3687,6 +3692,10 @@
     c->c2=2Elink_socket_owned =3D true;
 }=

 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop=

+#endif
+
 /*
  * bind TCP/UDP sockets
  */
diff --git a/src/openvpn/lzo=
=2Ec b/src/openvpn/lzo=2Ec
index 51cf5e8=2E=2E2b0691b 100644
--- a/src/open=
vpn/lzo=2Ec
+++ b/src/openvpn/lzo=2Ec
@@ -40,6 +40,11 @@
 #include "memdbg=
=2Eh"
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnos=
tic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 sta=
tic void
 lzo_compress_init(struct compress_context *compctx)
 {
@@ -120,6 =
+125,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragm=
a GCC diagnostic pop
+#endif
+
 const struct compress_alg lzo_alg =3D { "lz=
o", lzo_compress_init, lzo_compress_uninit, lzo_compress,
                 =
                      lzo_decompress };
 #endif /* ENABLE_LZO */
diff --git=
 a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 581e7be=2E=2E48095=
32 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -779=
,6 +779,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion=
"
+#endif
+
 static void
 man_query_user_pass(struct management *man, const=
 char *type, const char *string, const bool needed,
                     co=
nst char *prompt, char *dest, int len)
@@ -804,6 +809,10 @@
     }
 }
 
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#end=
if
+
 static void
 man_query_username(struct management *man, const char *t=
ype, const char *string)
 {
@@ -2473,6 +2482,11 @@
 
 #endif /* ifdef TARGE=
T_ANDROID */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+=

 static ssize_t
 man_read(struct management *man)
 {
@@ -2611,6 +2625,10 @=
@
     return sent;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pra=
gma GCC diagnostic pop
+#endif
+
 static void
 man_connection_clear(struct =
man_connection *mc)
 {
@@ -2682,6 +2700,11 @@
     CLEAR(*mp);
 }
 
+#if de=
fined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma=
 GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 man_set=
tings_init(struct man_settings *ms, const char *addr, const char *port,
   =
                const char *pass_file, const char *client_user, const char =
*client_group,
@@ -3297,6 +3320,10 @@
     return true;
 }
 
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifde=
f _WIN32
 
 void
@@ -3606,6 +3633,11 @@
     }
 }
 
+#if defined(__GNUC__) =
|| defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic =
ignored "-Wsign-conversion"
+#endif
+
 /*
  * Process the management event =
loop for sec seconds
  */
@@ -4341,6 +4373,10 @@
     }
 }
 
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
=
 management_check_bytecount_client(struct context *c, struct management *ma=
n, struct timeval *timeval)
 {
@@ -4475,6 +4511,12 @@
 #else /* ifdef ENABL=
E_MANAGEMENT */
 
 #include "win32=2Eh"
+
+#if !defined(_WIN32) && (defined=
(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 management_sleep(c=
onst int n)
 {
@@ -4488,4 +4530,8 @@
 #endif /* ifdef _WIN32 */
 }
 
+#if !=
defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC d=
iagnostic pop
+#endif
+
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/op=
envpn/misc=2Ec b/src/openvpn/misc=2Ec
index 8c9ad08=2E=2E9a307a2 100644
---=
 a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -72,6 +72,11 @@
 #end=
if
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnosti=
c push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #ifde=
f ENABLE_MANAGEMENT
 /* Get username/password from the management interface=
 */
 static bool
@@ -762,6 +767,10 @@
     return (state =3D=3D 2);
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#en=
dif
+
 void
 output_peer_info_env(struct env_set *es, const char *peer_info=
)
 {
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 0cfa272d=
=2E=2E5bc94d9 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@=
 -194,6 +194,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)=

+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conve=
rsion"
+#endif
+
 static inline size_t
 adjust_payload_max_cbc(const struct=
 key_type *kt, size_t target)
 {
@@ -313,6 +318,10 @@
     frame->mss_fix =
=3D (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);
 }
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+=
#endif
+
 void
 frame_calculate_dynamic(struct frame *frame, const struct k=
ey_type *kt, const struct options *options,
                         const =
struct link_socket_info *lsi)
diff --git a/src/openvpn/mtcp=2Ec b/src/openv=
pn/mtcp=2Ec
index 2d0af06=2E=2Efc5b657 100644
--- a/src/openvpn/mtcp=2Ec
++=
+ b/src/openvpn/mtcp=2Ec
@@ -37,6 +37,11 @@
 #include <sys/inotify=2Eh>
 #e=
ndif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic=
 push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct=
 multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struc=
t link_socket *sock)
 {
@@ -88,6 +93,10 @@
     return true;
 }
 
+#if defi=
ned(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 =
void
 multi_tcp_instance_specific_free(struct multi_instance *mi)
 {
diff -=
-git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index 5ce40c8=2E=2E7892935=
 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -37,6 +37,11=
 @@
 #include "memdbg=2Eh"
 #include "ssl_common=2Eh"
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnos=
tic ignored "-Wsign-conversion"
+#endif
+
 /* allocate a buffer for socket =
or tun layer */
 void
 alloc_buf_sock_tun(struct buffer *buf, const struct =
frame *frame)
@@ -383,6 +388,10 @@
     return BSTR(&out);
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 vo=
id
 set_sock_extended_error_passing(int sd, sa_family_t proto_af)
 {
diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index bcaa012=2E=2E089=
0480 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -247=
,6 +247,11 @@
 
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion=
"
+#endif
+
 #ifdef ENABLE_ASYNC_PUSH
 static uint64_t
 /*
@@ -4555,3 +4560=
,7 @@
     return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv=
6_netbits,
                                     dest));
 }
+
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --g=
it a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index fb4810b=2E=
=2Ee07b691 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=
=2Ec
@@ -104,6 +104,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
+#endif
+
 struct multi_io *
 multi_io_init(const int maxclie=
nts)
 {
@@ -121,6 +126,10 @@
     return multi_io;
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 mult=
i_io_free(struct multi_io *multi_io)
 {
diff --git a/src/openvpn/networking=
_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 97ff7bd=2E=2E501c635 10=
0644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_si=
tnl=2Ec
@@ -243,6 +243,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || =
defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
+#endif
+
 /**
  * Send Netlink message and run ca=
llback on reply (if specified)
  */
@@ -1485,6 +1490,10 @@
     return sitn=
l_send(&req=2En, 0, 0, NULL, NULL);
 }
 
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* !ENABLE_SITNL *=
/
 
 #endif /* TARGET_LINUX */
diff --git a/src/openvpn/occ=2Ec b/src/openv=
pn/occ=2Ec
index f25ae19=2E=2E38685f5 100644
--- a/src/openvpn/occ=2Ec
+++ =
b/src/openvpn/occ=2Ec
@@ -177,6 +177,7 @@
 #if defined(__GNUC__) || defined=
(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-=
Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif
 
=
 void
@@ -352,10 +353,6 @@
     c->c2=2Eocc_op =3D -1;
 }
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 =
process_received_occ_msg(struct context *c)
 {
@@ -426,3 +423,7 @@
     }
 =
    c->c2=2Ebuf=2Elen =3D 0; /* don't pass packet on */
 }
+
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --g=
it a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index b32f009=2E=2E9=
f0f50c 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@=
@ -351,6 +351,12 @@
 }
 
 #ifdef _WIN32
+
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 int
 wmain(int argc, wchar_t *wargv[])
 {
@@ -=
394,6 +400,11 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #else  /* ifdef _WIN32 */=

 int
 main(int argc, char *argv[])
diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec
index 454d2d6=2E=2Edbbeb00 100644
--- a/src/openvpn=
/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -947,6 +947,11 @@
     setenv=
_str_i(es, "local_port", e->port, i);
 }
 
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "=
-Wsign-conversion"
+#endif
+
 void
 setenv_settings(struct env_set *es, con=
st struct options *o)
 {
@@ -7874,6 +7879,7 @@
 
 #if defined(__GNUC__) || =
defined(__clang__)
 #pragma GCC diagnostic pop
+#pragma GCC diagnostic pop
=
 #endif
 
 bool
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/op=
tions_parse=2Ec
index 5d6f93e=2E=2E0a5eae5 100644
--- a/src/openvpn/options=
_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -234,6 +234,11 @@
     } =
u;
 };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 stat=
ic bool
 in_src_get(const struct in_src *is, char *line, const int size)
 {=

@@ -298,6 +303,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defin=
ed(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 check_inli=
ne_file(const struct in_src *is, char *p[], struct gc_arena *gc)
 {
diff --=
git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec
index 321=
a37b=2E=2E88422e0 100644
--- a/src/openvpn/options_show=2Ec
+++ b/src/openv=
pn/options_show=2Ec
@@ -341,6 +341,11 @@
     }
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic=
 ignored "-Wsign-conversion"
+#endif
+
 void
 show_settings(const struct op=
tions *o)
 {
@@ -629,4 +634,8 @@
 #endif
 }
 
+#if defined(__GNUC__) || def=
ined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifndef ENA=
BLE_SMALL */
diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/opti=
ons_string=2Ec
index 4a43fce4=2E=2E4fe34bf 100644
--- a/src/openvpn/options=
_string=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -380,6 +380,7 @@
 #if d=
efined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragm=
a GCC diagnostic ignored "-Wsign-compare"
+#pragma GCC diagnostic ignored "=
-Wsign-conversion"
 #endif
 
 char *
diff --git a/src/openvpn/options_util=
=2Ec b/src/openvpn/options_util=2Ec
index d25d85c=2E=2E23fdac7 100644
--- a=
/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -211,6 =
+211,11 @@
                                            "route-metric", "top=
ology",
                                            "tun-mtu", "keepalive" =
};
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic p=
ush
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 ch=
eck_push_update_option_flags(char *line, int *i, uint64_t *flags)
 {
@@ -27=
3,6 +278,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 apply_pull_filter(cons=
t struct options *o, char *line)
 {
diff --git a/src/openvpn/packet_id=2Ec =
b/src/openvpn/packet_id=2Ec
index 9dd6ce3=2E=2E881df5d 100644
--- a/src/ope=
nvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -71,6 +71,11 @@
 #end=
if
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnosti=
c push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 stati=
c void
 packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, i=
nt time_backtrack,
                     const char *name, int unit)
@@ -175=
,6 +180,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic pop
+#endif
+
 /*
  * Expire sequence numbers which can=
 no longer
  * be accepted because they would violate
diff --git a/src/open=
vpn/ping=2Ec b/src/openvpn/ping=2Ec
index 526e64c=2E=2Ebbacd20 100644
--- a=
/src/openvpn/ping=2Ec
+++ b/src/openvpn/ping=2Ec
@@ -64,6 +64,11 @@
     gc=
_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif=

+
 /*
  * Should we ping the remote?
  */
@@ -84,3 +89,7 @@
     c->c2=2Eb=
uf=2Elen =3D 0;
     dmsg(D_PING, "SENT PING");
 }
+
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src=
/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index f00ba9b=2E=2Eb4bed12 100=
644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -54,6 +54,=
11 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#end=
if
+
 static void
 __mysleep(unsigned long usec)
 {
@@ -812,4 +817,9 @@
   =
  pkcs11h_terminate();
     gc_free(&gc);
 }
+
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE_PK=
CS11 */
diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_op=
enssl=2Ec
index 8abd60a=2E=2Ec5974fce 100644
--- a/src/openvpn/pkcs11_opens=
sl=2Ec
+++ b/src/openvpn/pkcs11_openssl=2Ec
@@ -130,6 +130,11 @@
     retur=
n ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /=
**
  * Sign op called from xkey provider
  *
@@ -230,6 +235,10 @@
     retu=
rn 1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic pop
+#endif
+
 /* wrapper for handle free */
 static void
 xkey_handle=
_free(void *handle)
diff --git a/src/openvpn/platform=2Ec b/src/openvpn/pla=
tform=2Ec
index 9412eeb=2E=2Ee10161f 100644
--- a/src/openvpn/platform=2Ec
=
+++ b/src/openvpn/platform=2Ec
@@ -76,6 +76,11 @@
 
 /* Get/Set UID of proc=
ess */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool=

 platform_user_get(const char *username, struct platform_state_user *state=
)
 {
@@ -658,6 +663,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 platform_absolute_path=
name(const char *pathname)
 {
diff --git a/src/openvpn/plugin=2Ec b/src/ope=
nvpn/plugin=2Ec
index d1f228e=2E=2E2872265 100644
--- a/src/openvpn/plugin=
=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -463,6 +463,11 @@
 #define _OPENVPN_PA=
TCH_LEVEL "git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FLAGS
 #endif
 
+#if =
defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#prag=
ma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 plugi=
n_open_item(struct plugin *p, const struct plugin_option *o,
              =
    struct openvpn_plugin_string_list **retlist, const char **envp,
@@ -545=
,6 +550,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic pop
+#endif
+
 static int
 plugin_call_item(const struc=
t plugin *p, void *per_client_context, const int type,
                  co=
nst struct argv *av, struct openvpn_plugin_string_list **retlist,
diff --gi=
t a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index fff0e3f=2E=2E016f3a8 =
100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -137,6 +137=
,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+=
#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
+#endif
+
 struct ifconfig_pool *
 ifconfig_pool_init(const bool ipv4_=
pool, enum pool_type type, in_addr_t start, in_addr_t end,
                =
    const bool duplicate_cn, const bool ipv6_pool, const struct in6_addr ip=
v6_base,
@@ -708,6 +713,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 ifconfig_pool_writ=
e(struct ifconfig_pool_persist *persist, const struct ifconfig_pool *pool)
=
 {
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 7b5a289=
=2E=2Ecd9f3b2 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2E=
c
@@ -53,6 +53,11 @@
 }
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
+#endif
+
 /* cached proxy username/password */
 static struct user_pas=
s static_proxy_user_pass;
 
@@ -288,6 +293,10 @@
     p->up =3D static_prox=
y_user_pass; /* this is a copy of protected memory */
 }
 
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #if 0
 =
/* function only used in #if 0 debug statement */
 static void
diff --git a=
/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index f8cfe1c5=2E=2E86b4fc9 100644=

--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -165,6 +165,11 @@
   =
  return CMSG_SPACE(sizeof(socket_descriptor_t));
 }
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnost=
ic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Send a command (char), dat=
a (head), and a file descriptor (sd_send) to a local process
  * over unix =
socket sd=2E  Unfortunately, there's no portable way to send file descripto=
rs
@@ -618,6 +623,10 @@
     return IOSTAT_GOOD;
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Forwa=
rd data from pc to pc->counterpart=2E
  */
diff --git a/src/openvpn/push=2E=
c b/src/openvpn/push=2Ec
index a18f33b=2E=2E6f628b8 100644
--- a/src/openvp=
n/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -389,6 +389,11 @@
     }
 }
 
+#if=
 defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pra=
gma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 receive_aut=
h_pending(struct context *c, const struct buffer *buffer)
 {
@@ -795,6 +800=
,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 static bool
 send_push_options(struct context *=
c, struct buffer *buf, struct push_list *push_list, int safe_cap,
         =
          bool *push_sent, bool *multi_push)
diff --git a/src/openvpn/relia=
ble=2Ec b/src/openvpn/reliable=2Ec
index 7b5b17c=2E=2Eb045b1f 100644
--- a/=
src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -311,6 +311,11 @=
@
  * struct reliable member functions=2E
  */
 
+#if defined(__GNUC__) || =
defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
+#endif
+
 void
 reliable_init(struct reliable *re=
l, int buf_size, int offset, int array_size, bool hold)
 {
@@ -780,6 +785,1=
0 @@
     ASSERT(0); /* buf not found in rel */
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Enable=
 an outgoing buffer previously returned by a get function as active=2E
  */=

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index d0d26c6=
=2E=2Ee8e1f60 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -582,6 +582,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clan=
g__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-c=
onversion"
+#endif
+
 bool
 block_local_needed(const struct route_list *rl)=

 {
@@ -3217,6 +3222,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__=
clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* IPv6 implementation usin=
g netlink
  * https://www=2Elinuxjournal=2Ecom/article/7356 - "Kernel Korne=
r - Why and How to Use Netlink Socket"
  * netlink(3), netlink(7), rtnetlin=
k(7)
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 1fb=
d07b=2E=2Ec07ef60 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/soc=
ket=2Ec
@@ -422,6 +422,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic=
 ignored "-Wsign-conversion"
+#endif
+
 socket_descriptor_t
 socket_do_acce=
pt(socket_descriptor_t sd, struct link_socket_actual *act, const bool nowai=
t)
 {
@@ -2084,6 +2089,10 @@
     return buf->len;
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* =
ifndef _WIN32 */
 
 /*
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/so=
cket=2Eh
index 52e09c9=2E=2E2210bfe 100644
--- a/src/openvpn/socket=2Eh
+++=
 b/src/openvpn/socket=2Eh
@@ -288,12 +288,21 @@
     return sh=2Eis_handle =
? (int)GetLastError() : WSAGetLastError();
 }
 
+#if defined(__GNUC__) || d=
efined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic igno=
red "-Wsign-conversion"
+#endif
+
 inline static void
 SocketHandleSetLastE=
rror(sockethandle_t sh, DWORD err)
 {
     sh=2Eis_handle ? SetLastError(er=
r) : WSASetLastError(err);
 }
 
+#if defined(__GNUC__) || defined(__clang__=
)
+#pragma GCC diagnostic pop
+#endif
+
 static inline void
 SocketHandleSe=
tInvalError(sockethandle_t sh)
 {
@@ -459,6 +468,11 @@
 
 #endif /* if PORT=
_SHARE */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 s=
tatic inline bool
 socket_connection_reset(const struct link_socket *sock, =
ssize_t status)
 {
@@ -482,6 +496,10 @@
     return false;
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 st=
atic inline bool
 link_socket_verify_incoming_addr(const struct buffer *buf=
, const struct link_socket_info *info,
                                  co=
nst struct link_socket_actual *from_addr)
@@ -649,6 +667,11 @@
 ssize_t lin=
k_socket_write_tcp(struct link_socket *sock, struct buffer *buf,
          =
                     struct link_socket_actual *to);
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnost=
ic ignored "-Wsign-conversion"
+#endif
+
 #ifdef _WIN32
 
 static inline in=
t
@@ -721,6 +744,10 @@
 
 #endif /* ifdef _WIN32 */
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static inlin=
e ssize_t
 link_socket_write_udp(struct link_socket *sock, struct buffer *b=
uf, struct link_socket_actual *to)
 {
diff --git a/src/openvpn/socket_util=
=2Ec b/src/openvpn/socket_util=2Ec
index 879be73=2E=2Ea049f33 100644
--- a/=
src/openvpn/socket_util=2Ec
+++ b/src/openvpn/socket_util=2Ec
@@ -123,6 +12=
3,11 @@
 #define IF_NAMESIZE 16
 #endif
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 const char *
 print_link_socket_actual_ex(cons=
t struct link_socket_actual *act, const char *separator,
                  =
           const unsigned int flags, struct gc_arena *gc)
@@ -188,6 +193,10=
 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC d=
iagnostic pop
+#endif
+
 /*
  * Convert an in_addr_t in host byte order
  *=
 to an ascii dotted quad=2E
diff --git a/src/openvpn/socks=2Ec b/src/openvp=
n/socks=2Ec
index a8c9fd3=2E=2E51e3a1e 100644
--- a/src/openvpn/socks=2Ec
+=
++ b/src/openvpn/socks=2Ec
@@ -226,6 +226,11 @@
     return true;
 }
 
+#if=
 defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pra=
gma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 recv=
_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
       =
           const struct event_timeout *server_poll_timeout, volatile int *s=
ignal_received)
@@ -310,6 +315,10 @@
     return true;
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static=
 int
 port_from_servname(const char *servname)
 {
diff --git a/src/openvpn/=
ssl=2Ec b/src/openvpn/ssl=2Ec
index a538b52=2E=2Ee253242 100644
--- a/src/o=
penvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -152,6 +152,11 @@
     return l=
imit;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 vo=
id
 tls_init_control_channel_frame_parameters(struct frame *frame, int tls_=
mtu)
 {
@@ -236,6 +241,10 @@
     return overhead;
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 init=
_ssl_lib(void)
 {
@@ -797,6 +806,11 @@
     return false;
 }
 
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC =
diagnostic ignored "-Wsign-conversion"
+#endif
+
 /** @addtogroup control_p=
rocessor
  *  @{ */
 
@@ -1048,6 +1062,10 @@
     gc_free(&gc);
 }
 
+#if d=
efined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
=
+
 /**
  * Clean up a \c tls_session structure=2E
  * @ingroup control_proc=
essor
@@ -1330,6 +1348,11 @@
     key_source_print(&k->server, "Server");
 =
}
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pu=
sh
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bo=
ol
 openvpn_PRF(const uint8_t *secret, size_t secret_len, const char *label=
, const uint8_t *client_seed,
             size_t client_seed_len, const ui=
nt8_t *server_seed, size_t server_seed_len,
@@ -4482,3 +4505,7 @@
 done:
  =
   return BSTR(&out);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/ssl_mbedtls=2Ec b=
/src/openvpn/ssl_mbedtls=2Ec
index 45d7715=2E=2Ecbc3118 100644
--- a/src/op=
envpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -199,6 +199,11 @=
@
         ciphers);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion=
"
+#endif
+
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const=
 char *ciphers)
 {
@@ -1187,6 +1192,10 @@
     return 1;
 }
 
+#if defined(=
__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* *=
*************************************
  *
  * Information functions
diff --=
git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index f13f507=2E=2E=
df9e42c 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
=
@@ -393,6 +393,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "=
-Wsign-conversion"
+#endif
+
 static void
 p2p_ncp_set_options(struct tls_m=
ulti *multi, struct tls_session *session, const char *common_cipher)
 {
@@ =
-576,6 +581,10 @@
     o->ncp_ciphers =3D (char *)ncp_ciphers;
 }
 
+#if de=
fined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+=

 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp=
_cipher to either AES-256-GCM:AES-128-GCM or
diff --git a/src/openvpn/ssl_o=
penssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index fe2bfda=2E=2E035cfb8 100644
=
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -277=
,7 +277,14 @@
     sslopt |=3D SSL_OP_NO_RENEGOTIATION;
 #endif
 
+#if defi=
ned(LIBRESSL_VERSION_NUMBER) && (defined(__GNUC__) || defined(__clang__))
+=
#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
+#endif
     SSL_CTX_set_options(ctx->ctx, sslopt);
+#if defined(LIBRE=
SSL_VERSION_NUMBER) && (defined(__GNUC__) || defined(__clang__))
+#pragma G=
CC diagnostic pop
+#endif
 
     if (!tls_ctx_set_tls_versions(ctx, ssl_fla=
gs))
     {
@@ -511,6 +518,11 @@
 {
     ASSERT(ctx);
 #if OPENSSL_VERSION_=
NUMBER < 0x30000000L && !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnos=
tic ignored "-Wsign-conversion"
+#endif
+
     struct gc_arena gc =3D gc_ne=
w();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_l=
ist(ctx->ctx, groups)
@@ -556,6 +568,10 @@
         crypto_msg(M_FATAL, "Fa=
iled to set allowed TLS group list: %s", groups);
     }
     gc_free(&gc);=

+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop=

+#endif
 #else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     if (!SS=
L_CTX_set1_groups_list(ctx->ctx, groups))
     {
@@ -1466,6 +1482,11 @@
   =
  }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
=
  * Pass the input hash in 'dgst' to management and get the signature back=
=2E
  *
@@ -1710,6 +1731,11 @@
     return 0;
 }
 #endif /* !defined(OPENSS=
L_NO_EC) */
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC dia=
gnostic pop
+#endif
+
 #endif /* ENABLE_MANAGEMENT && !HAVE_XKEY_PROVIDER *=
/
 
 #ifdef ENABLE_MANAGEMENT
@@ -2099,6 +2125,11 @@
  * to BIOs=2E
  */
 
=
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+=
#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 =
bio_write_post(const int status, struct buffer *buf)
 {
@@ -2110,6 +2141,10=
 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC d=
iagnostic pop
+#endif
+
 /*
  * Read from an OpenSSL BIO in non-blocking mo=
de=2E
  */
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
i=
ndex f78782f=2E=2E60573ee 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/op=
envpn/ssl_pkt=2Ec
@@ -40,6 +40,11 @@
  */
 #define SWAP_BUF_SIZE 256
 
+#if=
 defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pra=
gma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Move a pa=
cket authentication HMAC + related fields to or from the front
  * of the b=
uffer so it can be processed by encrypt/decrypt=2E
@@ -591,3 +596,7 @@
    =
 buf_advance(buf, cmdlen);
     return cmdbuf;
 }
+
+#if defined(__GNUC__) =
|| defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/=
openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index ba185c1=2E=2E337faed =
100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -86=
,6 +86,10 @@
     return var_value;
 }
 
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-W=
sign-conversion"
+#endif
 
 unsigned int
 peer_info_extract_int(const char =
*peer_info, const char *field, const char *format, unsigned int default_val=
ue)
@@ -166,6 +170,10 @@
     return BSTR(&buf);
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * SSL/=
TLS Cipher suite name translation table
  */
diff --git a/src/openvpn/ssl_v=
erify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec1e=2E=2Ebf0267d 100644
--=
- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -400,6 +=
400,11 @@
     return SUCCESS;
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-=
conversion"
+#endif
+
 /*
  * Export the subject, common_name, and raw cert=
ificate fields to the
  * environment for later verification by scripts and=
 plugins=2E
@@ -803,6 +808,10 @@
     return ret;
 }
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* ********=
*******************************************************************
  * Fun=
ctions for the management of deferred authentication when using
  * user/pa=
ssword authentication=2E
@@ -884,6 +893,11 @@
     return supported;
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#=
pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  *  Check=
s if the deferred state should also send auth pending
  *  request to the c=
lient=2E Also removes the auth_pending control file
@@ -958,6 +972,10 @@
  =
   return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic pop
+#endif
+
 /**
  *  Removes auth_pending and auth_control=
 files from file system
  *  and key_state structure
diff --git a/src/openv=
pn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index a132f1=
2=2E=2Ebba2f2f 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/op=
envpn/ssl_verify_mbedtls=2Ec
@@ -222,6 +222,11 @@
     return true;
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 result_t
 backe=
nd_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, mb=
edtls_x509_crt *cert)
 {
@@ -786,6 +791,10 @@
     }
 }
 
+#if defined(__GN=
UC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Dummy=
 function because Netscape certificate types are not supported in OpenVPN w=
ith mbedtls=2E
  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE =
otherwise=2E */
 result_t
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b=
/src/openvpn/ssl_verify_openssl=2Ec
index 0c36cf2=2E=2E19339ad 100644
--- a=
/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2E=
c
@@ -317,6 +317,11 @@
     return serial;
 }
 
+#if defined(__GNUC__) || d=
efined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic igno=
red "-Wsign-conversion"
+#endif
+
 char *
 backend_x509_get_serial_hex(open=
vpn_x509_cert_t *cert, struct gc_arena *gc)
 {
@@ -573,6 +578,10 @@
     gc=
_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic pop
+#endif
+
 /*
  * Save X509 fields to environment, using the=
 naming convention:
  *
diff --git a/src/openvpn/status=2Ec b/src/openvpn/s=
tatus=2Ec
index 1036536=2E=2E533619f 100644
--- a/src/openvpn/status=2Ec
++=
+ b/src/openvpn/status=2Ec
@@ -55,6 +55,11 @@
     }
 }
 
+#if defined(__GN=
UC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
+#endif
+
 struct status_output *
 status=
_open(const char *filename, const int refresh_freq, const int msglevel,
   =
          const struct virtual_output *vout, const unsigned int flags)
@@ -=
119,6 +124,10 @@
     return so;
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 status_trigger(struct =
status_output *so)
 {
@@ -206,6 +215,11 @@
     return ret;
 }
 
+#if defin=
ed(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GC=
C diagnostic ignored "-Wsign-conversion"
+#endif
+
 #define STATUS_PRINTF_M=
AXLEN 512
 
 void
@@ -297,3 +311,7 @@
 
     return ret;
 }
+
+#if defined(=
__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --=
git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index d66b96d=
=2E=2E2dadc4f 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_=
crypt=2Ec
@@ -93,6 +93,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-W=
sign-conversion"
+#endif
+
 bool
 tls_session_generate_dynamic_tls_crypt_ke=
y(struct tls_session *session)
 {
@@ -518,6 +523,10 @@
     return ret;
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
=
+#endif
+
 static bool
 tls_crypt_v2_check_client_key_age(const struct buff=
er *tls_crypt_v2_metadata, int max_days)
 {
@@ -698,6 +707,11 @@
     write=
_pem_key_file(filename, tls_crypt_v2_srv_pem_name);
 }
 
+#if defined(__GNU=
C__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagno=
stic ignored "-Wsign-conversion"
+#endif
+
 void
 tls_crypt_v2_write_client=
_key_file(const char *filename, const char *b64_metadata,
                 =
                   const char *server_key_file, bool server_key_inline)
@@ =
-801,3 +815,7 @@
 
     gc_free(&gc);
 }
+
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/t=
un=2Ec b/src/openvpn/tun=2Ec
index bcea331=2E=2E07e036e 100644
--- a/src/op=
envpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -112,6 +112,11 @@
 
 static cons=
t char *netsh_get_id(const char *dev_node, struct gc_arena *gc);
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 do_addre=
ss_service(const bool add, const short family, const struct tuntap *tt)
 {
=
@@ -479,6 +484,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifdef _WIN32 =
*/
 
 #ifdef TARGET_SOLARIS
@@ -815,6 +824,11 @@
     gc_free(&gc);
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Init tun=
/tap object=2E
  *
@@ -1556,6 +1570,10 @@
 #endif
 }
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* execute =
the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap =
*tt, const char *ifname, int tun_mtu, const struct env_set *es,
@@ -1701,6 =
+1719,11 @@
 #include <netinet/ip=2Eh>
 #include <sys/uio=2Eh>
 
+#if defin=
ed(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GC=
C diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline ssize_t
 =
header_modify_read_write_return(ssize_t len)
 {
@@ -1786,6 +1809,10 @@
 }
 =
#endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic pop
+#endif
+
 #endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DR=
AGONFLY) || defined(TARGET_NETBSD) || defined (TARGET_OPENBSD) || defined(T=
ARGET_DARWIN) */
 
 bool
@@ -2043,6 +2070,11 @@
     free(tt);
 }
 
+#if de=
fined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma=
 GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 ssize_t
 write_tun(c=
onst struct tuntap *tt, const uint8_t *buf, int len)
 {
@@ -2055,6 +2087,10=
 @@
     return read(tt->fd, buf, len);
 }
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_=
LINUX)
 
 #if !PEDANTIC
@@ -2252,6 +2288,11 @@
     free(tt);
 }
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 ssize_t
 write_tun(co=
nst struct tuntap *tt, const uint8_t *buf, int len)
 {
@@ -2264,6 +2305,10 =
@@
     return read(tt->fd, buf, len);
 }
 
+#if defined(__GNUC__) || defin=
ed(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_S=
OLARIS)
 
 #ifndef TUNNEWPPA
@@ -2881,6 +2926,11 @@
 
 #elif defined(TARGET=
_DARWIN)
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*=
 Darwin (MacOS X) is mostly "just use the generic stuff", but there
  * is =
always one caveat=2E=2E=2E:
  *
@@ -2946,6 +2996,10 @@
     return fd;
 }
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+=
#endif
+
 void
 open_darwin_utun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tuntap *tt)
 {
@@ -3095,6 +3149,11 @@
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
ssize_t
 write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {=

@@ -3121,6 +3180,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_AIX)
 
 v=
oid
@@ -3257,6 +3320,11 @@
 
 #elif defined(_WIN32)
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
+#endif
+
 int
 tun_read_queue(struct tuntap =
*tt, int maxsize)
 {
@@ -6101,6 +6169,10 @@
     argv_free(&argv);
 }
 
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#end=
if
+
 void
 close_tun_handle(struct tuntap *tt)
 {
@@ -6280,7 +6352,7 @@
  =
   return BSTR(&out);
 }
 
-#else                        /* generic */
+#el=
se  /* generic */
 
 void
 open_tun(const char *dev, const char *dev_type, =
const char *dev_node, struct tuntap *tt,
@@ -6310,4 +6382,4 @@
     return =
read(tt->fd, buf, len);
 }
 
-#endif                       /* if defined (T=
ARGET_ANDROID) */
+#endif /* if defined (TARGET_ANDROID) */
diff --git a/sr=
c/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index 79d706a=2E=2E15=
5bf8d 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tun_afunix=
=2Ec
@@ -48,6 +48,11 @@
 #include <stdlib=2Eh>
 
 
+#if defined(__GNUC__) |=
| defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic i=
gnored "-Wsign-conversion"
+#endif
+
 static void
 tun_afunix_exec_child(co=
nst char *dev_node, struct tuntap *tt, const struct env_set *env)
 {
@@ -17=
1,6 +176,11 @@
      * with error messages */
     return read(tt->fd, buf,=
 len);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic pop
+#endif
+
 #else  /* ifndef WIN32 */
 
 // cppcheck-suppress-begi=
n constParameterPointer ; stubs
diff --git a/src/openvpn/vlan=2Ec b/src/ope=
nvpn/vlan=2Ec
index 04e18d6=2E=2Ed44dac1 100644
--- a/src/openvpn/vlan=2Ec
=
+++ b/src/openvpn/vlan=2Ec
@@ -56,6 +56,11 @@
         (hdr->pcp_cfi_vid & =
~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENVPN_8021Q_MASK_VID);
 }
 
+#if=
 defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pra=
gma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * vlan_decap=
sulate - remove 802=2E1q header and return VID
  *
@@ -170,6 +175,10 @@
   =
  return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic pop
+#endif
+
 /*
  * vlan_encapsulate - add 802=2E1q header an=
d set the context related VID
  *
diff --git a/src/openvpn/wfp_block=2Ec b/=
src/openvpn/wfp_block=2Ec
index 4d38fdb=2E=2Eb576899 100644
--- a/src/openv=
pn/wfp_block=2Ec
+++ b/src/openvpn/wfp_block=2Ec
@@ -131,6 +131,11 @@
     =
return err;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif=

+
 /*
  * Block outgoing local traffic, possibly DNS only, except for
  * =
(i) adapter with the specified index (and loopback, if all is blocked)
@@ -=
340,6 +345,10 @@
     return err;
 }
 
+#if defined(__GNUC__) || defined(__=
clang__)
+#pragma GCC diagnostic pop
+#endif
+
 DWORD
 delete_wfp_block_fil=
ters(HANDLE engine_handle)
 {
diff --git a/src/openvpn/win32-util=2Ec b/src=
/openvpn/win32-util=2Ec
index e2c8810=2E=2E5f99e2b 100644
--- a/src/openvpn=
/win32-util=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -36,6 +36,11 @@
 #inclu=
de "buffer=2Eh"
 #include "win32-util=2Eh"
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
+#endif
+
 WCHAR *
 wide_string(const char *utf8, stru=
ct gc_arena *gc)
 {
@@ -131,6 +136,10 @@
     return utf8;
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*=

  * Return true if filename is safe to be used on Windows,
  * by avoiding=
 the following reserved names:
diff --git a/src/openvpn/win32=2Ec b/src/ope=
nvpn/win32=2Ec
index 3af58ed=2E=2E079869f 100644
--- a/src/openvpn/win32=2E=
c
+++ b/src/openvpn/win32=2Ec
@@ -545,6 +545,11 @@
     CLEAR(*ws);
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 win32_sig=
nal_open(struct win32_signal *ws, int force, const char *exit_event_name,
 =
                  bool exit_event_initial_state)
@@ -1661,4 +1666,8 @@
    =
 return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic pop
+#endif
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openv=
pn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 6908cbb=2E=2Ef4be796=
 100644
--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec=

@@ -146,6 +146,11 @@
 }
 
 #ifdef ENABLE_MANAGEMENT
+
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnost=
ic ignored "-Wsign-conversion"
+#endif
 /**
  * Signature callback for xkey=
_provider with management-external-key
  *
@@ -276,6 +281,10 @@
 
     retu=
rn (*siglen > 0);
 }
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic pop
+#endif
+
 #endif /* ENABLE MANAGEMENT */
 
 /**
diff --=
git a/src/openvpn/xkey_provider=2Ec b/src/openvpn/xkey_provider=2Ec
index a=
349d4d=2E=2E9211c11 100644
--- a/src/openvpn/xkey_provider=2Ec
+++ b/src/op=
envpn/xkey_provider=2Ec
@@ -940,6 +940,11 @@
     return ret;
 }
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 signature=
_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
      =
          const unsigned char *tbs, size_t tbslen)
@@ -1074,6 +1079,10 @@
 =
    return signature_sign(ctx, sig, siglen, sigsize, buf, sz);
 }
 
+#if de=
fined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+=

 /* Sign digest using native sign function -- will only work for native ke=
ys
  */
 int
diff --git a/src/openvpnmsica/dllmain=2Ec b/src/openvpnmsica/d=
llmain=2Ec
index 85ebda9=2E=2E777c823 100644
--- a/src/openvpnmsica/dllmain=
=2Ec
+++ b/src/openvpnmsica/dllmain=2Ec
@@ -98,6 +98,11 @@
     return true=
;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic=
 push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 =
x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
=
@@ -189,3 +194,7 @@
                       hRecordProg);
     MsiCloseHandl=
e(hRecordProg);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic pop
+#endif
diff --git a/src/openvpnserv/common=2Ec b/src/op=
envpnserv/common=2Ec
index 671ddde=2E=2Ee20feb7 100644
--- a/src/openvpnser=
v/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -30,6 +30,11 @@
 LPCWSTR s=
ervice_instance =3D L"";
 static wchar_t win_sys_path[MAX_PATH];
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static DWORD
 GetRegS=
tring(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_val=
ue)
 {
@@ -309,6 +314,10 @@
     return utf16;
 }
 
+#if defined(__GNUC__) =
|| defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const wchar_t =
*
 get_win_sys_path(void)
 {
diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec
index 81205d6=2E=2Eac6a264 100644
--- a/sr=
c/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -524=
,6 +524,10 @@
     free(sud->directory);
 }
 
+#if defined(__GNUC__) || def=
ined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignore=
d "-Wsign-conversion"
+#endif
 
 static SOCKADDR_INET
 sockaddr_inet(short =
family, const inet_address_t *addr)
@@ -3964,6 +3968,9 @@
     return 0;
 }=

 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop=

+#endif
 
 static DWORD WINAPI
 ServiceCtrlInteractive(DWORD ctrl_code, DW=
ORD event, LPVOID data, LPVOID ctx)
diff --git a/src/plugins/auth-pam/auth-=
pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 948b6af=2E=2E0cd201d 1006=
44
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plugins/auth-pam/auth-=
pam=2Ec
@@ -184,6 +184,11 @@
     return -1;
 }
 
+#if defined(__GNUC__) ||=
 defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ig=
nored "-Wsign-conversion"
+#endif
+
 static ssize_t
 send_string(int fd, co=
nst char *string)
 {
@@ -199,6 +204,10 @@
     }
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef DO_DA=
EMONIZE
 
 /*
diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
index ac=
1ecd2=2E=2Ea3d83e9 100644
--- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/tap=2Ec=

@@ -102,6 +102,11 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clan=
g__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-c=
onversion"
+#endif
+
 /**
  * Returns length of string of strings
  *
@@ -1=
226,6 +1231,9 @@
     return dwResult;
 }
 
+#if defined(__GNUC__) || defin=
ed(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 void
 tap_free_adapter=
_list(_In_ struct tap_adapter_node *pAdapterList)
diff --git a/tests/unit_t=
ests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
ind=
ex 338265d=2E=2Eb480985 100644
--- a/tests/unit_tests/openvpn/test_buffer=
=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -106,6 +106,11 @@
  =
   gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma=
 GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#=
endif
+
 static void
 test_buffer_format_hex_ex(void **state)
 {
@@ -139,6 =
+144,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clan=
g__)
+#pragma GCC diagnostic pop
+#endif
+
 struct test_buffer_list_aggrega=
te_ctx
 {
     struct buffer_list *empty;
diff --git a/tests/unit_tests/ope=
nvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
index f86ac=
a8=2E=2Ee68a0b2 100644
--- a/tests/unit_tests/openvpn/test_crypto=2Ec
+++ b=
/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -52,6 +52,11 @@
 
 static cons=
t char testtext[] =3D "Dummy text to test PEM encoding";
 
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diag=
nostic ignored "-Wsign-conversion"
+#endif
+
 static void
 crypto_pem_encod=
e_decode_loopback(void **state)
 {
@@ -799,6 +804,10 @@
     assert_null(ep=
och_lookup_decrypt_key(co, 23));
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 crypto_test_epoch_key_=
overflow(void **state)
 {
@@ -914,6 +923,11 @@
     assert_memory_equal(out=
, expected_hash, UT_SIPHASH_HASH_SIZE);
 }
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
+#endif
+
 static void
 test_siphash_openssl(void **st=
ate)
 {
@@ -959,6 +973,9 @@
     siphash_openssl_uninit(sipctx);
 }
 
+#if =
defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif=

 
 int
 main(void)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi=2E=
c b/tests/unit_tests/openvpn/test_cryptoapi=2Ec
index 37bbe92=2E=2E55aafbb =
100644
--- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec
+++ b/tests/unit_t=
ests/openvpn/test_cryptoapi=2Ec
@@ -137,6 +137,11 @@
     return c->cert ? =
c : NULL;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+=

 /* import sample certificates into windows cert store */
 static void
 im=
port_certs(void **state)
@@ -223,6 +228,10 @@
     certs_loaded =3D true;
 =
}
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic po=
p
+#endif
+
 static int
 cleanup(void **state)
 {
diff --git a/tests/unit_t=
ests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index 3=
a84e1e=2E=2Ee331d3d 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+++=
 b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -50,6 +50,11 @@
     return "d=
ummy";
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 s=
tatic void
 test_write_dhcp_search_str(void **state)
 {
@@ -141,6 +146,10 @=
@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic pop
+#endif
+
 int
 main(void)
 {
diff --git a/tests/un=
it_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networ=
king=2Ec
index 1c9cac1=2E=2Eae75386 100644
--- a/tests/unit_tests/openvpn/t=
est_networking=2Ec
+++ b/tests/unit_tests/openvpn/test_networking=2Ec
@@ -4=
0,6 +40,11 @@
     return net_iface_del(NULL, name);
 }
 
+#if defined(__GN=
UC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
+#endif
+
 static int
 net__iface_mtu_set=
(int mtu)
 {
@@ -48,6 +53,10 @@
     return net_iface_mtu_set(NULL, iface, =
mtu);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic pop
+#endif
+
 static int
 net__addr_v4_add(const char *addr_str, int =
prefixlen)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/un=
it_tests/openvpn/test_pkt=2Ec
index 49ba833=2E=2E889e6d7 100644
--- a/tests=
/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2E=
c
@@ -618,6 +618,11 @@
     assert_memory_equal(server_id2_p1=2Eid, server_=
id_p2=2Eid, SID_SIZE);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
+#endif
+
 static void
 test_generate_reset_packet_plain(void **ut_stat=
e)
 {
@@ -696,6 +701,10 @@
     free_tas(&tas_server);
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* A p=
eer can ask us to append the wrapped client key (WKc) to our next
  * contr=
ol packet=2E Only a tls-crypt-v2 client has one, so check that we
  * refus=
e to build such a packet when we have no key instead of walking
diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec
index 4987dd0=2E=2E85b8d12 100644
--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -265,6 +265,10 @@
 #=
endif /* HAVE_OPENSSL_STORE */
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-=
conversion"
+#endif
 
 static void
 init_frame_parameters(struct frame *fra=
me)
@@ -886,6 +890,10 @@
     free_certificate(cert);
 }
 
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Cert=
ificate with two CNs, "foo" and "bar"=2E
  *
  * Generated with:
diff --git=
 a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/t=
est_tls_crypt=2Ec
index f8aa199=2E=2Eab90ea5 100644
--- a/tests/unit_tests/=
openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2E=
c
@@ -232,6 +232,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clan=
g__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-c=
onversion"
+#endif
+
 /**
  * Check that short messages are successfully wr=
apped-and-unwrapped=2E
  */
@@ -773,6 +778,10 @@
     tls_wrap_free(&wrap_c=
tx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnos=
tic pop
+#endif
+
 static void
 test_tls_crypt_v2_write_server_key_file(voi=
d **state)
 {
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/te=
sts/unit_tests/openvpn/test_user_pass=2Ec
index 776a86a=2E=2E5bc1d2a 100644=

--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/o=
penvpn/test_user_pass=2Ec
@@ -46,6 +46,12 @@
     return query_user_exec_bu=
iltin();
 }
 #endif
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma=
 GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#=
endif
+
 bool
 query_user_exec_builtin(void)
 {
@@ -58,6 +64,11 @@
 
     r=
eturn mock();
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 void
 management_auth_failure(const struct mana=
gement *man, const char *type, const char *reason)
 {

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66=
960fb
Gerrit-Change-Number: 1186
Gerrit-PatchSet: 20
Gerrit-Owner: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>

--LK/DbW1Zkak=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #20</strong> to th=
is change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/11=
86?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">En=
able -Wsign-conversion<br><br>As before with -Wconversion override all the =
known issues<br>to be able to address them one by one=2E<br><br>Change-Id: =
Iecf502ec811e99c56647b2d45298fa0fb66960fb<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=
ure=2Eac<br>M src/openvpn/acc=2Ec<br>M src/openvpn/argv=2Ec<br>M src/openvp=
n/auth_token=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br=
>M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/console_builtin=2Ec<br>M src/o=
penvpn/console_systemd=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/cry=
pto_epoch=2Ec<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_o=
penssl=2Ec<br>M src/openvpn/cryptoapi=2Ec<br>M src/openvpn/dco=2Ec<br>M src=
/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dc=
o_win=2Ec<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/dns=2Ec<br>M src/openv=
pn/env_set=2Ec<br>M src/openvpn/error=2Ec<br>M src/openvpn/error=2Eh<br>M s=
rc/openvpn/event=2Ec<br>M src/openvpn/fdmisc=2Ec<br>M src/openvpn/fdmisc=2E=
h<br>M src/openvpn/forward=2Ec<br>M src/openvpn/fragment=2Ec<br>M src/openv=
pn/helper=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/lzo=2Ec<br>M src/o=
penvpn/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/mss=2Ec<br>M s=
rc/openvpn/mtcp=2Ec<br>M src/openvpn/mtu=2Ec<br>M src/openvpn/multi=2Ec<br>=
M src/openvpn/multi_io=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/o=
penvpn/occ=2Ec<br>M src/openvpn/openvpn=2Ec<br>M src/openvpn/options=2Ec<br=
>M src/openvpn/options_parse=2Ec<br>M src/openvpn/options_show=2Ec<br>M src=
/openvpn/options_string=2Ec<br>M src/openvpn/options_util=2Ec<br>M src/open=
vpn/packet_id=2Ec<br>M src/openvpn/ping=2Ec<br>M src/openvpn/pkcs11=2Ec<br>=
M src/openvpn/pkcs11_openssl=2Ec<br>M src/openvpn/platform=2Ec<br>M src/ope=
nvpn/plugin=2Ec<br>M src/openvpn/pool=2Ec<br>M src/openvpn/proxy=2Ec<br>M s=
rc/openvpn/ps=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/reliable=2Ec<b=
r>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/sock=
et=2Eh<br>M src/openvpn/socket_util=2Ec<br>M src/openvpn/socks=2Ec<br>M src=
/openvpn/ssl=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=
=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src=
/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_=
verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M src/openvpn=
/status=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Ec<br>M sr=
c/openvpn/tun_afunix=2Ec<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/wfp_blo=
ck=2Ec<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/win32=2Ec<br>M src/=
openvpn/xkey_helper=2Ec<br>M src/openvpn/xkey_provider=2Ec<br>M src/openvpn=
msica/dllmain=2Ec<br>M src/openvpnserv/common=2Ec<br>M src/openvpnserv/inte=
ractive=2Ec<br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/tapctl/tap=2Ec<=
br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn=
/test_crypto=2Ec<br>M tests/unit_tests/openvpn/test_cryptoapi=2Ec<br>M test=
s/unit_tests/openvpn/test_dhcp=2Ec<br>M tests/unit_tests/openvpn/test_netwo=
rking=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>M tests/unit_tests/=
openvpn/test_ssl=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>M =
tests/unit_tests/openvpn/test_user_pass=2Ec<br>96 files changed, 1,116 inse=
rtions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1186/20</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 5cf1a30=2E=2Ea90=
eb1a 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CM=
akeLists=2Etxt</span><br><span>@@ -117,7 +117,7 @@</span><br><span>     che=
ck_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)</sp=
an><br><span>     check_and_add_compiler_flag(-Wstrict-prototypes StrictPro=
totypes)</span><br><span>     check_and_add_compiler_flag(-Wold-style-defin=
ition OldStyleDefinition)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    add_compile_options(-Wconversion -Wno-sign-conversion)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    add_compile_options(-Wconver=
sion)</span><br><span>     add_compile_options(-Wextra -Wno-unused-paramete=
r)</span><br><span>     # clang doesn&#39;t have the different levels but a=
lso doesn&#39;t include it in -Wextra</span><br><span>     check_and_add_co=
mpiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFallthrough)</span><br><s=
pan>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 5f18=
798=2E=2Eea338d8 100644</span><br><span>--- a/configure=2Eac</span><br><spa=
n>+++ b/configure=2Eac</span><br><span>@@ -1249,7 +1249,7 @@</span><br><spa=
n> ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])</span><br><span>=
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</span><br><span> ACL_CH=
ECK_ADD_COMPILE_FLAGS([-Wold-style-definition])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-si=
gn-conversion])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_=
CHECK_ADD_COMPILE_FLAGS([-Wconversion])</span><br><span> ACL_CHECK_ADD_COMP=
ILE_FLAGS([-Wall])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -W=
no-unused-parameter])</span><br><span> # clang doesn&#39;t have the differe=
nt levels but also doesn&#39;t include it in -Wextra</span><br><span>diff -=
-git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index 455f=
56d=2E=2Ee21891d 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br=
><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -148,6 +148,11 @@</span=
><br><span>     return parse_acc_message_flags(flags, err_reason, gc);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored=
 &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> void</span><br><span> receive_acc_message(struct context *c=
, const struct buffer *buffer)</span><br><span> {</span><br><span>@@ -236,6=
 +241,10 @@</span><br><span> }</span><br><span> </span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> bool</span><br><span> send_acc_message(struct context *c,</span><br=
><span>                  struct tls_multi *multi,</span><br><span>diff --gi=
t a/src/openvpn/argv=2Ec b/src/openvpn/argv=2Ec</span><br><span>index 02867=
1d=2E=2Ec716e5b0 100644</span><br><span>--- a/src/openvpn/argv=2Ec</span><b=
r><span>+++ b/src/openvpn/argv=2Ec</span><br><span>@@ -323,6 +323,11 @@</sp=
an><br><span>     return f;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  Cr=
eate a struct argv based on a format string</span><br><span>  *</span><br><=
span>@@ -418,6 +423,10 @@</span><br><span>     return res;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  printf() va=
riant which populates a struct argv=2E  It processes the</span><br><span>  =
*  format string with the provided arguments=2E  For each space separator f=
ound</span><br><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/=
auth_token=2Ec</span><br><span>index 84558af=2E=2E211af90 100644</span><br>=
<span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/au=
th_token=2Ec</span><br><span>@@ -36,6 +36,11 @@</span><br><span>  * padding=
 */</span><br><span> static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN=
_DATA_LEN is not a multiple of 3&quot;);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> is_auth_tok=
en(const char *password)</span><br><span> {</span><br><span>@@ -291,6 +296,=
9 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span> </span><br><span> static bool</spa=
n><br><span> check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, c=
onst char *username)</span><br><span>diff --git a/src/openvpn/buffer=2Ec b/=
src/openvpn/buffer=2Ec</span><br><span>index 8813fa5=2E=2E7f142c4f 100644</=
span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openv=
pn/buffer=2Ec</span><br><span>@@ -92,6 +92,11 @@</span><br><span>     retur=
n buf;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> struct buffer</span><br><span> #ifdef BUF_INIT_T=
RACKING</span><br><span> clone_buf_debug(const struct buffer *buf, const ch=
ar *file, int line)</span><br><span>@@ -305,6 +310,10 @@</span><br><span>  =
   return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * Garbage collection</span><br><span>  */</span><br><span>@=
@ -439,6 +448,11 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br=
><span>  * Hex dump -- Output a binary buffer to a hex string and return it=
=2E</span><br><span>  */</span><br><span>@@ -538,6 +552,10 @@</span><br><sp=
an>     buf_null_terminate(buf);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> const char *</span><br><span> skip_leading_whitespace(const char=
 *str)</span><br><span> {</span><br><span>@@ -717,6 +735,11 @@</span><br><s=
pan>     return memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> bool</span><br><span> buf_string_compare_advance(struct buffer *src, c=
onst char *match)</span><br><span> {</span><br><span>@@ -731,6 +754,10 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
int</span><br><span> buf_substring_len(const struct buffer *buf, int delim)=
</span><br><span> {</span><br><span>@@ -957,6 +984,11 @@</span><br><span>  =
   return false;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static inline bool</span><br><span> =
char_inc_exc(const char c, const unsigned int inclusive, const unsigned int=
 exclusive)</span><br><span> {</span><br><span>@@ -964,6 +996,10 @@</span><=
br><span>            &amp;&amp; !char_class((unsigned char)c, exclusive);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> s=
tring_class(const char *str, const unsigned int inclusive, const unsigned i=
nt exclusive)</span><br><span> {</span><br><span>@@ -1241,6 +1277,11 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> void</span><br><span> buffer_list_a=
ggregate_separator(struct buffer_list *bl, const size_t max_len, const char=
 *sep)</span><br><span> {</span><br><span>@@ -1286,6 +1327,10 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</spa=
n><br><span> buffer_list_aggregate(struct buffer_list *bl, const size_t max=
)</span><br><span> {</span><br><span>@@ -1323,6 +1368,11 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> struct buffer_list *</span><br><span> buffer_li=
st_file(const char *fn, int max_line_len)</span><br><span> {</span><br><spa=
n>@@ -1402,3 +1452,7 @@</span><br><span>     buf_advance(buf, field_len + 1=
);</span><br><span>     return field;</span><br><span> }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>dif=
f --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>i=
ndex 7af4444=2E=2Eede3066 100644</span><br><span>--- a/src/openvpn/buffer=
=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -643,6=
 +643,11 @@</span><br><span>     return true;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span=
><br><span>  * Initialise a buffer with an externally provided writable mem=
ory region=2E</span><br><span>  *</span><br><span>@@ -1619,6 +1624,10 @@</s=
pan><br><span>     return memcmp(CBPTR(src), match, size) =3D=3D 0;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Retur=
n true if the head of \c src matches the string \c match=2E</span><br><span=
>  *</span><br><span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/co=
mp-lz4=2Ec</span><br><span>index 57c6bb3=2E=2E0c5f22f 100644</span><br><spa=
n>--- a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz4=
=2Ec</span><br><span>@@ -89,6 +89,11 @@</span><br><span>     compv2_escape_=
data_ifneeded(buf);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> do_lz4=
_decompress(int zlen_max, struct buffer *work, struct buffer *buf,</span><b=
r><span>                   struct compress_context *compctx)</span><br><spa=
n>@@ -198,6 +203,10 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> const struct compress_alg lz4_alg =3D { &quot;lz4&q=
uot;, lz4_compress_init, lz4_compress_uninit, lz4_compress,</span><br><span=
>                                       lz4_decompress };</span><br><span> =
</span><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn=
/console_builtin=2Ec</span><br><span>index 4737677=2E=2Edc71d12 100644</spa=
n><br><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src=
/openvpn/console_builtin=2Ec</span><br><span>@@ -41,6 +41,11 @@</span><br><=
span> #include &lt;termios=2Eh&gt;</span><br><span> #endif</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</=
span><br><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><br>=
<span>@@ -289,3 +294,7 @@</span><br><span> </span><br><span>     return ret=
;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/console_system=
d=2Ec b/src/openvpn/console_systemd=2Ec</span><br><span>index eaed24e=2E=2E=
8fc7f72 100644</span><br><span>--- a/src/openvpn/console_systemd=2Ec</span>=
<br><span>+++ b/src/openvpn/console_systemd=2Ec</span><br><span>@@ -53,6 +5=
3,11 @@</span><br><span>     return (sd_booted() &gt; 0) &amp;&amp; (stat(S=
YSTEMD_ASK_PASSWORD_PATH, &amp;c) =3D=3D 0);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static boo=
l</span><br><span> get_console_input_systemd(const char *prompt, const bool=
 echo, char *input, const int capacity)</span><br><span> {</span><br><span>=
@@ -86,6 +91,10 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> /**</span><br><span>  *  Systemd aware implem=
entation of query_user_exec()=2E  If systemd is not running</span><br><span=
>  *  it will fall back to use query_user_exec_builtin() instead=2E</span><=
br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span=
><br><span>index a8ad7f0=2E=2E33e0376 100644</span><br><span>--- a/src/open=
vpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span=
>@@ -62,6 +62,11 @@</span><br><span>  * happen unless the frame parameters =
are wrong=2E</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> openvpn=
_encrypt_aead(struct buffer *buf, struct buffer work, struct crypto_options=
 *opt)</span><br><span> {</span><br><span>@@ -1577,6 +1582,10 @@</span><br>=
<span>     return nbits;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> void</span><br><span> must_have_n_keys(const char *filename, const char =
*option, const struct key2 *key2, int n)</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</=
span><br><span>index 35f9b55=2E=2E312cf6f 100644</span><br><span>--- a/src/=
openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec=
</span><br><span>@@ -38,6 +38,11 @@</span><br><span> #include &quot;buffer=
=2Eh&quot;</span><br><span> #include &quot;integer=2Eh&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><b=
r><span> ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_=
t info_len,</span><br><span>                  uint8_t *out, size_t out_len)=
</span><br><span>@@ -458,3 +463,7 @@</span><br><span>         epoch_iterate=
_send_key(opt);</span><br><span>     }</span><br><span> }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>di=
ff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>index 3a2a8c6=2E=2Eceaaad4 100644</span><br><span>--- a/src=
/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtl=
s=2Ec</span><br><span>@@ -821,6 +821,11 @@</span><br><span>     ASSERT(hmac=
_length =3D=3D dst_size);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Genera=
te the hash required by for the \c tls1_PRF function=2E</span><br><span>  *=
</span><br><span>@@ -1149,4 +1154,8 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABL=
E_CRYPTO_MBEDTLS) */</span><br><span>diff --git a/src/openvpn/crypto_openss=
l=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index b7f2ef3=2E=2E0=
a1d00c 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><b=
r><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -487,6 +487=
,11 @@</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br>=
<span> crypto_pem_decode(const char *name, struct buffer *dst, const struct=
 buffer *src)</span><br><span> {</span><br><span>@@ -1306,6 +1311,10 @@</sp=
an><br><span> }</span><br><span> #endif /* if OPENSSL_VERSION_NUMBER &lt; 0=
x30000000L */</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> memcmp=
_constant_time(const void *a, const void *b, size_t size)</span><br><span> =
{</span><br><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryp=
toapi=2Ec</span><br><span>index ef3c94c=2E=2E30a5144 100644</span><br><span=
>--- a/src/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoap=
i=2Ec</span><br><span>@@ -62,7 +62,7 @@</span><br><span>     return 0;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#else  /* HAVE_XKEY_PROVIDER */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#else /* HAVE_XKEY_PROVIDER */</span><br><span> </sp=
an><br><span> static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;</span><br><span> =
</span><br><span>@@ -260,6 +260,11 @@</span><br><span>     return false;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> static const CERT_CONTEXT *</span><br><span> find_certifi=
cate_in_store(const char *cert_prop, HCERTSTORE cert_store)</span><br><span=
> {</span><br><span>@@ -598,6 +603,10 @@</span><br><span>     return 0;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> SS=
L_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/ope=
nvpn/dco=2Ec</span><br><span>index f3b5d44=2E=2E236be93 100644</span><br><s=
pan>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</sp=
an><br><span>@@ -50,6 +50,11 @@</span><br><span> #include &lt;cap-ng=2Eh&gt=
;</span><br><span> #endif</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static int</span><br><span> dco_install_key(stru=
ct tls_multi *multi, struct key_state *ks, const uint8_t *encrypt_key,</spa=
n><br><span>                 const uint8_t *encrypt_iv, const uint8_t *decr=
ypt_key, const uint8_t *decrypt_iv,</span><br><span>@@ -807,4 +812,8 @@</sp=
an><br><span> #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)=
 || defined(_WIN32) */</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #endif /* defined(ENABLE_DCO) */</span><br><span>diff --git a/src/openvpn/=
dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 3148f10=
=2E=2E11b8dff 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</spa=
n><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -577,6 +57=
7,11 @@</span><br><span>         __func__, peerid, mi-&gt;context=2Ec2=2Edc=
o_read_bytes, mi-&gt;context=2Ec2=2Edco_write_bytes);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-con=
version&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> i=
nt</span><br><span> dco_read_and_process(dco_context_t *dco)</span><br><spa=
n> {</span><br><span>@@ -762,6 +767,10 @@</span><br><span>     return avail=
able;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</sp=
an><br><span> dco_version_string(struct gc_arena *gc)</span><br><span> {</s=
pan><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linu=
x=2Ec</span><br><span>index a84e310=2E=2E60107c4 100644</span><br><span>---=
 a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2E=
c</span><br><span>@@ -220,6 +220,11 @@</span><br><span>     return sock;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> int</span><br><span> dco_new_peer(dco_context_t *dco, uns=
igned int peerid, int sd, struct sockaddr *localaddr,</span><br><span>     =
         struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,</span=
><br><span>@@ -1257,6 +1262,10 @@</span><br><span>     return ret;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_get_=
peer_stats(struct context *c, const bool raise_sigusr1_on_err)</span><br><s=
pan> {</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/d=
co_win=2Ec</span><br><span>index 12b0666=2E=2Ea854045 100644</span><br><spa=
n>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=
=2Ec</span><br><span>@@ -220,6 +220,11 @@</span><br><span>     return 0;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> static void</span><br><span> dco_connect_wait(HANDLE hand=
le, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)</span><br><s=
pan> {</span><br><span>@@ -1091,6 +1096,10 @@</span><br><span>     gc_free(=
&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><=
br><span> dco_supports_epoch_data(const struct context *c)</span><br><span>=
 {</span><br><span>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec=
</span><br><span>index 19e9e2d=2E=2E525d567 100644</span><br><span>--- a/sr=
c/openvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><sp=
an>@@ -72,6 +72,11 @@</span><br><span>     return -1;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-con=
version&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic in_addr_t</span><br><span> do_extract(struct dhcp *dhcp, int optlen)<=
/span><br><span> {</span><br><span>@@ -186,6 +191,10 @@</span><br><span>   =
  return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if define=
d(_WIN32) || defined(DHCP_UNIT_TEST)</span><br><span> </span><br><span> /*<=
/span><br><span>@@ -327,6 +336,11 @@</span><br><span>     buf_write(buf, tm=
p_buf, len);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> bool</span><br><span> build_dhcp_options_s=
tring(struct buffer *buf, const struct tuntap_options *o)</span><br><span> =
{</span><br><span>@@ -375,4 +389,8 @@</span><br><span>     return !error;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(_WIN3=
2) */</span><br><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2E=
c</span><br><span>index abe30ed=2E=2Ee2cb981 100644</span><br><span>--- a/s=
rc/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><spa=
n>@@ -58,6 +58,11 @@</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-co=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
bool</span><br><span> dns_server_addr_parse(struct dns_server *server, cons=
t char *addr)</span><br><span> {</span><br><span>@@ -144,6 +149,10 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> bool</span><br><span> dns_domain_list_append(struct dns_domain **ent=
ry, char **domains, struct gc_arena *gc)</span><br><span> {</span><br><span=
>@@ -402,6 +411,11 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static voi=
d</span><br><span> run_up_down_service(bool add, const struct options *o, c=
onst struct tuntap *tt)</span><br><span> {</span><br><span>@@ -476,7 +490,1=
1 @@</span><br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, s=
izeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef _WI=
N32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef=
 _WIN32 */</span><br><span> </span><br><span> static void</span><br><span> =
setenv_dns_option(struct env_set *es, const char *format, size_t i, size_t =
j, const char *value)</span><br><span>@@ -702,6 +720,11 @@</span><br><span>=
     return true;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> run_up_=
down_command(bool up, struct options *o, const struct tuntap *tt,</span><br=
><span>                     struct dns_updown_runner_info *updown_runner)</=
span><br><span>@@ -780,6 +803,10 @@</span><br><span>     msg(M_INFO, &quot;=
dns %s command exited with status %d&quot;, up ? &quot;up&quot; : &quot;dow=
n&quot;, status);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #end=
if /* _WIN32 */</span><br><span> </span><br><span> void</span><br><span>dif=
f --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec</span><br><span=
>index 67a5bf5=2E=2Ed59115a 100644</span><br><span>--- a/src/openvpn/env_se=
t=2Ec</span><br><span>+++ b/src/openvpn/env_set=2Ec</span><br><span>@@ -432=
,6 +432,11 @@</span><br><span>     return (script_security() &gt;=3D SSEC_P=
W_ENV || !is_password_env_var(str));</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Make arrays of =
strings */</span><br><span> </span><br><span> const char **</span><br><span=
>@@ -470,3 +475,7 @@</span><br><span>     ret[i] =3D NULL;</span><br><span>=
     return (const char **)ret;</span><br><span> }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --gi=
t a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index 32d=
819d=2E=2Ea3f7990 100644</span><br><span>--- a/src/openvpn/error=2Ec</span>=
<br><span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -219,6 +219,11 @@<=
/span><br><span>     va_end(arglist);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) =
&amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> static const char *</span><br><span> openvpn_strerror(int err,=
 bool crt_error, struct gc_arena *gc)</span><br><span> {</span><br><span>@@=
 -689,6 +694,10 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN=
32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * In =
multiclient mode, put a client-specific prefix</span><br><span>  * before e=
ach message=2E</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/ope=
nvpn/error=2Eh</span><br><span>index 373cbc1=2E=2E0056d05 100644</span><br>=
<span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=
=2Eh</span><br><span>@@ -406,6 +406,11 @@</span><br><span> }</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clan=
g__))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static inline int</span><br><span> =
openvpn_errno_maybe_crt(bool *crt_error)</span><br><span> {</span><br><span=
>@@ -426,6 +431,10 @@</span><br><span>     return err;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quo=
t;errlevel=2Eh&quot;</span><br><span> </span><br><span> #endif /* ifndef ER=
ROR_H */</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/e=
vent=2Ec</span><br><span>index 5e17ea1=2E=2Ec4a856d 100644</span><br><span>=
--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</sp=
an><br><span>@@ -486,6 +486,11 @@</span><br><span> #endif</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> static struct event_set *</span><br><span> we_init(int *maxevents, uns=
igned int flags)</span><br><span> {</span><br><span>@@ -524,8 +529,17 @@</s=
pan><br><span>     return (struct event_set *)wes;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #endif /* _WIN32 */</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if EPOLL</span><br><sp=
an> </span><br><span> struct ep_set</span><br><span>@@ -1122,6 +1136,10 @@<=
/span><br><span> }</span><br><span> #endif /* SELECT */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static struct event_set *</span><br><span> event_set_init_si=
mple(int *maxevents, unsigned int flags)</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/fdmisc=2Ec b/src/openvpn/fdmisc=2Ec</span><br><sp=
an>index 6910f81=2E=2Ee715964 100644</span><br><span>--- a/src/openvpn/fdmi=
sc=2Ec</span><br><span>+++ b/src/openvpn/fdmisc=2Ec</span><br><span>@@ -31,=
6 +31,11 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&qu=
ot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* Set a file descriptor to non-blocking =
*/</span><br><span> bool</span><br><span> set_nonblock_action(socket_descri=
ptor_t fd)</span><br><span>@@ -50,6 +55,10 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(_WIN32) &amp;&amp; (defined(__GNUC__) || =
defined(__clang__))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /* Set a file descriptor to not be passed across execs */</span=
><br><span> bool</span><br><span> set_cloexec_action(socket_descriptor_t fd=
)</span><br><span>diff --git a/src/openvpn/fdmisc=2Eh b/src/openvpn/fdmisc=
=2Eh</span><br><span>index eac8075=2E=2E15ee3cd 100644</span><br><span>--- =
a/src/openvpn/fdmisc=2Eh</span><br><span>+++ b/src/openvpn/fdmisc=2Eh</span=
><br><span>@@ -35,6 +35,11 @@</span><br><span> </span><br><span> void set_c=
loexec(socket_descriptor_t fd);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> static inline void</span><br><span> openvp=
n_fd_set(socket_descriptor_t fd, fd_set *setp)</span><br><span> {</span><br=
><span>@@ -45,4 +50,8 @@</span><br><span> }</span><br><span> #undef FD_SET =
/* prevent direct use of FD_SET() */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif        /* FD_MISC_H */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* FD_MISC_H */</span><br>=
<span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span>=
<br><span>index 82cb6c9=2E=2Ebcad559 100644</span><br><span>--- a/src/openv=
pn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><spa=
n>@@ -286,6 +286,11 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span>=
<br><span>  * Handle incoming configuration</span><br><span>  * messages on=
 the control channel=2E</span><br><span>@@ -2033,6 +2038,10 @@</span><br><s=
pan>     check_timeout_random_component(c);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> void</span><br><span> multi_io_process_flags(struct c=
ontext *c, struct event_set *es, struct link_socket *sock, const unsigned i=
nt flags)</span><br><span> {</span><br><span>diff --git a/src/openvpn/fragm=
ent=2Ec b/src/openvpn/fragment=2Ec</span><br><span>index c454434=2E=2E55f2a=
08 100644</span><br><span>--- a/src/openvpn/fragment=2Ec</span><br><span>++=
+ b/src/openvpn/fragment=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br><=
span>         goto error; \</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> fragment_list_buf_init(struct fragment_list *list, const struct frame=
 *frame)</span><br><span> {</span><br><span>@@ -284,6 +289,10 @@</span><br>=
<span>     ASSERT(buf_write_prepend(buf, &amp;flags, sizeof(flags)));</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * With=
out changing the number of fragments, return a possibly smaller</span><br><=
span>  * max fragment size that will allow for the last fragment to be of</=
span><br><span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec=
</span><br><span>index 6b5fcee6=2E=2Ed9ddf6a 100644</span><br><span>--- a/s=
rc/openvpn/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><b=
r><span>@@ -148,6 +148,11 @@</span><br><span> }</span><br><span> </span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span=
><br><span>  * Process server, server-bridge, and client helper</span><br><=
span>  * directives after the parameters themselves have been</span><br><sp=
an>@@ -507,6 +512,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  *</span><br><=
span>  * HELPER DIRECTIVE:</span><br><span>diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec</span><br><span>index 29c24f2=2E=2E5235c4f 100644<=
/span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvp=
n/init=2Ec</span><br><span>@@ -103,6 +103,11 @@</span><br><span>     c-&gt;=
persist =3D cpsave;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Pass tunnel =
endpoint and MTU parms to a user-supplied script=2E</span><br><span>  * Use=
d to execute the up/down script/plugins=2E</span><br><span>@@ -3687,6 +3692=
,10 @@</span><br><span>     c-&gt;c2=2Elink_socket_owned =3D true;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * bind T=
CP/UDP sockets</span><br><span>  */</span><br><span>diff --git a/src/openvp=
n/lzo=2Ec b/src/openvpn/lzo=2Ec</span><br><span>index 51cf5e8=2E=2E2b0691b =
100644</span><br><span>--- a/src/openvpn/lzo=2Ec</span><br><span>+++ b/src/=
openvpn/lzo=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br><span> #includ=
e &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> lz=
o_compress_init(struct compress_context *compctx)</span><br><span> {</span>=
<br><span>@@ -120,6 +125,10 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> const struct compress_alg lzo_alg =3D { &qu=
ot;lzo&quot;, lzo_compress_init, lzo_compress_uninit, lzo_compress,</span><=
br><span>                                       lzo_decompress };</span><br=
><span> #endif /* ENABLE_LZO */</span><br><span>diff --git a/src/openvpn/ma=
nage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 581e7be=2E=2E480953=
2 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b=
/src/openvpn/manage=2Ec</span><br><span>@@ -779,6 +779,11 @@</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> man_query_user_pa=
ss(struct management *man, const char *type, const char *string, const bool=
 needed,</span><br><span>                     const char *prompt, char *des=
t, int len)</span><br><span>@@ -804,6 +809,10 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> man_query_username(struct management *man, const char *type, const ch=
ar *string)</span><br><span> {</span><br><span>@@ -2473,6 +2482,11 @@</span=
><br><span> </span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static ssi=
ze_t</span><br><span> man_read(struct management *man)</span><br><span> {</=
span><br><span>@@ -2611,6 +2625,10 @@</span><br><span>     return sent;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> man_connection_clear(struct man_connection *mc)</span><br><span> {</s=
pan><br><span>@@ -2682,6 +2700,11 @@</span><br><span>     CLEAR(*mp);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static void</span><br><span> man_settings_init(struct man_se=
ttings *ms, const char *addr, const char *port,</span><br><span>           =
        const char *pass_file, const char *client_user, const char *client_=
group,</span><br><span>@@ -3297,6 +3320,10 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</sp=
an><br><span> </span><br><span> void</span><br><span>@@ -3606,6 +3633,11 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Process =
the management event loop for sec seconds</span><br><span>  */</span><br><s=
pan>@@ -4341,6 +4373,10 @@</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> void</span><br><span> management_check_bytecoun=
t_client(struct context *c, struct management *man, struct timeval *timeval=
)</span><br><span> {</span><br><span>@@ -4475,6 +4511,12 @@</span><br><span=
> #else /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #i=
nclude &quot;win32=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defin=
ed(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> void</span><br><span> management_sleep(const int n)<=
/span><br><span> {</span><br><span>@@ -4488,4 +4530,8 @@</span><br><span> #=
endif /* ifdef _WIN32 */</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if !defined(_WIN32) &amp;&amp; (=
defined(__GNUC__) || defined(__clang__))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><=
span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><sp=
an>index 8c9ad08=2E=2E9a307a2 100644</span><br><span>--- a/src/openvpn/misc=
=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -72,6 +7=
2,11 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMEN=
T</span><br><span> /* Get username/password from the management interface *=
/</span><br><span> static bool</span><br><span>@@ -762,6 +767,10 @@</span><=
br><span>     return (state =3D=3D 2);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> void</span><br><span> output_peer_info_env(struct env_set =
*es, const char *peer_info)</span><br><span> {</span><br><span>diff --git a=
/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 0cfa272d=
=2E=2E5bc94d9 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><s=
pan>+++ b/src/openvpn/mss=2Ec</span><br><span>@@ -194,6 +194,11 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static inline size_t</span><br><span=
> adjust_payload_max_cbc(const struct key_type *kt, size_t target)</span><b=
r><span> {</span><br><span>@@ -313,6 +318,10 @@</span><br><span>     frame-=
&gt;mss_fix =3D (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_ove=
rhead);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br=
><span> frame_calculate_dynamic(struct frame *frame, const struct key_type =
*kt, const struct options *options,</span><br><span>                       =
  const struct link_socket_info *lsi)</span><br><span>diff --git a/src/open=
vpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 2d0af06=2E=2Efc5b=
657 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b=
/src/openvpn/mtcp=2Ec</span><br><span>@@ -37,6 +37,11 @@</span><br><span> #=
include &lt;sys/inotify=2Eh&gt;</span><br><span> #endif</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct multi_insta=
nce *</span><br><span> multi_create_instance_tcp(struct multi_context *m, s=
truct link_socket *sock)</span><br><span> {</span><br><span>@@ -88,6 +93,10=
 @@</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> void</span><br><span> multi_tcp_instance_specific_free(stru=
ct multi_instance *mi)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index 5ce40c8=2E=2E78=
92935 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ =
b/src/openvpn/mtu=2Ec</span><br><span>@@ -37,6 +37,11 @@</span><br><span> #=
include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_common=
=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /* allocate a buffer for socket or tun layer */</span><br><spa=
n> void</span><br><span> alloc_buf_sock_tun(struct buffer *buf, const struc=
t frame *frame)</span><br><span>@@ -383,6 +388,10 @@</span><br><span>     r=
eturn BSTR(&amp;out);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
void</span><br><span> set_sock_extended_error_passing(int sd, sa_family_t p=
roto_af)</span><br><span> {</span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index bcaa012=2E=2E0890480 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -247,6 +247,11 @@</span><br><span> </sp=
an><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic i=
gnored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span> static uint=
64_t</span><br><span> /*</span><br><span>@@ -4555,3 +4560,7 @@</span><br><s=
pan>     return (!ipv6_net_contains_host(&amp;ifconfig_local, o-&gt;ifconfi=
g_ipv6_netbits,</span><br><span>                                     dest))=
;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b=
/src/openvpn/multi_io=2Ec</span><br><span>index fb4810b=2E=2Ee07b691 100644=
</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/o=
penvpn/multi_io=2Ec</span><br><span>@@ -104,6 +104,11 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> struct multi_io *</span><br><span> multi_io_init(c=
onst int maxclients)</span><br><span> {</span><br><span>@@ -121,6 +126,10 @=
@</span><br><span>     return multi_io;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> void</span><br><span> multi_io_free(struct multi_io *mult=
i_io)</span><br><span> {</span><br><span>diff --git a/src/openvpn/networkin=
g_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index 97ff7b=
d=2E=2E501c635 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2E=
c</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@=
 -243,6 +243,11 @@</span><br><span>     return 0;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-convers=
ion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</=
span><br><span>  * Send Netlink message and run callback on reply (if speci=
fied)</span><br><span>  */</span><br><span>@@ -1485,6 +1490,10 @@</span><br=
><span>     return sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #endif /* !ENABLE_SITNL */</span><=
br><span> </span><br><span> #endif /* TARGET_LINUX */</span><br><span>diff =
--git a/src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec</span><br><span>index f25=
ae19=2E=2E38685f5 100644</span><br><span>--- a/src/openvpn/occ=2Ec</span><b=
r><span>+++ b/src/openvpn/occ=2Ec</span><br><span>@@ -177,6 +177,7 @@</span=
><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span> #p=
ragma GCC diagnostic push</span><br><span> #pragma GCC diagnostic ignored &=
quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span> #endif</span><br><span> </span><br><span> void</span><br><span>@@ -3=
52,10 +353,6 @@</span><br><span>     c-&gt;c2=2Eocc_op =3D -1;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> process_received_o=
cc_msg(struct context *c)</span><br><span> {</span><br><span>@@ -426,3 +423=
,7 @@</span><br><span>     }</span><br><span>     c-&gt;c2=2Ebuf=2Elen =3D =
0; /* don&#39;t pass packet on */</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff -=
-git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>in=
dex b32f009=2E=2E9f0f50c 100644</span><br><span>--- a/src/openvpn/openvpn=
=2Ec</span><br><span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -351,=
6 +351,12 @@</span><br><span> }</span><br><span> </span><br><span> #ifdef _=
WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> wmain(int=
 argc, wchar_t *wargv[])</span><br><span> {</span><br><span>@@ -394,6 +400,=
11 @@</span><br><span> </span><br><span>     return ret;</span><br><span> }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #e=
lse  /* ifdef _WIN32 */</span><br><span> int</span><br><span> main(int argc=
, char *argv[])</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index 454d2d6=2E=2Edbbeb00 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -947,6 +947,11 @@</span><br><span>     seten=
v_str_i(es, &quot;local_port&quot;, e-&gt;port, i);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conve=
rsion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> setenv_settings(struct env_set *es, const struct options=
 *o)</span><br><span> {</span><br><span>@@ -7874,6 +7879,7 @@</span><br><sp=
an> </span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br=
><span> #pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span> #endif</span><br=
><span> </span><br><span> bool</span><br><span>diff --git a/src/openvpn/opt=
ions_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index 5d6f93=
e=2E=2E0a5eae5 100644</span><br><span>--- a/src/openvpn/options_parse=2Ec</=
span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -234,=
6 +234,11 @@</span><br><span>     } u;</span><br><span> };</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</sp=
an><br><span> in_src_get(const struct in_src *is, char *line, const int siz=
e)</span><br><span> {</span><br><span>@@ -298,6 +303,10 @@</span><br><span>=
     return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c int</span><br><span> check_inline_file(const struct in_src *is, char *p[]=
, struct gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</span><br><span>ind=
ex 321a37b=2E=2E88422e0 100644</span><br><span>--- a/src/openvpn/options_sh=
ow=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@=
@ -341,6 +341,11 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><=
br><span> show_settings(const struct options *o)</span><br><span> {</span><=
br><span>@@ -629,4 +634,8 @@</span><br><span> #endif</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><=
span>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_stri=
ng=2Ec</span><br><span>index 4a43fce4=2E=2E4fe34bf 100644</span><br><span>-=
-- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns_string=2Ec</span><br><span>@@ -380,6 +380,7 @@</span><br><span> #if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic=
 push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wsign-compare&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span> #endif</spa=
n><br><span> </span><br><span> char *</span><br><span>diff --git a/src/open=
vpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index d=
25d85c=2E=2E23fdac7 100644</span><br><span>--- a/src/openvpn/options_util=
=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ =
-211,6 +211,11 @@</span><br><span>                                         =
   &quot;route-metric&quot;, &quot;topology&quot;,</span><br><span>        =
                                    &quot;tun-mtu&quot;, &quot;keepalive&qu=
ot; };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> bool</span><br><span> check_push_update_option_flags(char *line, in=
t *i, uint64_t *flags)</span><br><span> {</span><br><span>@@ -273,6 +278,10=
 @@</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> bool</span><br><span> apply_pull_filter(const struct option=
s *o, char *line)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 9dd6ce3=
=2E=2E881df5d 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span>=
<br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -71,6 +71,11 @=
@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> =
packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_=
backtrack,</span><br><span>                     const char *name, int unit)=
</span><br><span>@@ -175,6 +180,10 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Expire sequen=
ce numbers which can no longer</span><br><span>  * be accepted because they=
 would violate</span><br><span>diff --git a/src/openvpn/ping=2Ec b/src/open=
vpn/ping=2Ec</span><br><span>index 526e64c=2E=2Ebbacd20 100644</span><br><s=
pan>--- a/src/openvpn/ping=2Ec</span><br><span>+++ b/src/openvpn/ping=2Ec</=
span><br><span>@@ -64,6 +64,11 @@</span><br><span>     gc_free(&amp;gc);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /*</span><br><span>  * Should we ping the remote?</span><=
br><span>  */</span><br><span>@@ -84,3 +89,7 @@</span><br><span>     c-&gt;=
c2=2Ebuf=2Elen =3D 0;</span><br><span>     dmsg(D_PING, &quot;SENT PING&quo=
t;);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/pkcs11=2Ec =
b/src/openvpn/pkcs11=2Ec</span><br><span>index f00ba9b=2E=2Eb4bed12 100644<=
/span><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/open=
vpn/pkcs11=2Ec</span><br><span>@@ -54,6 +54,11 @@</span><br><span> }</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static void</span><br><span> __mysleep(unsigned long use=
c)</span><br><span> {</span><br><span>@@ -812,4 +817,9 @@</span><br><span> =
    pkcs11h_terminate();</span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> #endif /* ENABLE_PKCS11 */</span><br><span>diff --git a/src/openvpn/pk=
cs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>index 8ab=
d60a=2E=2Ec5974fce 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl=
=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>@=
@ -130,6 +130,11 @@</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
*</span><br><span>  * Sign op called from xkey provider</span><br><span>  *=
</span><br><span>@@ -230,6 +235,10 @@</span><br><span>     return 1;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /* wrapper for handle free *=
/</span><br><span> static void</span><br><span> xkey_handle_free(void *hand=
le)</span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/pla=
tform=2Ec</span><br><span>index 9412eeb=2E=2Ee10161f 100644</span><br><span=
>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=
=2Ec</span><br><span>@@ -76,6 +76,11 @@</span><br><span> </span><br><span> =
/* Get/Set UID of process */</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> bool</span><br><span> platform_user_get(const=
 char *username, struct platform_state_user *state)</span><br><span> {</spa=
n><br><span>@@ -658,6 +663,10 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> bool</span><br><span> platform_absolute_p=
athname(const char *pathname)</span><br><span> {</span><br><span>diff --git=
 a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index d1=
f228e=2E=2E2872265 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</spa=
n><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -463,6 +463,11 =
@@</span><br><span> #define _OPENVPN_PATCH_LEVEL &quot;git:&quot; CONFIGURE=
_GIT_REVISION CONFIGURE_GIT_FLAGS</span><br><span> #endif</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</spa=
n><br><span> plugin_open_item(struct plugin *p, const struct plugin_option =
*o,</span><br><span>                  struct openvpn_plugin_string_list **r=
etlist, const char **envp,</span><br><span>@@ -545,6 +550,10 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int=
</span><br><span> plugin_call_item(const struct plugin *p, void *per_client=
_context, const int type,</span><br><span>                  const struct ar=
gv *av, struct openvpn_plugin_string_list **retlist,</span><br><span>diff -=
-git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index ff=
f0e3f=2E=2E016f3a8 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span>=
<br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -137,6 +137,11 @@</=
span><br><span>     return ret;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct ifconfig_pool *<=
/span><br><span> ifconfig_pool_init(const bool ipv4_pool, enum pool_type ty=
pe, in_addr_t start, in_addr_t end,</span><br><span>                    con=
st bool duplicate_cn, const bool ipv6_pool, const struct in6_addr ipv6_base=
,</span><br><span>@@ -708,6 +713,10 @@</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> void</span><br><span> ifconfig_pool=
_write(struct ifconfig_pool_persist *persist, const struct ifconfig_pool *p=
ool)</span><br><span> {</span><br><span>diff --git a/src/openvpn/proxy=2Ec =
b/src/openvpn/proxy=2Ec</span><br><span>index 7b5a289=2E=2Ecd9f3b2 100644</=
span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvp=
n/proxy=2Ec</span><br><span>@@ -53,6 +53,11 @@</span><br><span> }</span><br=
><span> </span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /* cached proxy username/password */</span><br><span> static stru=
ct user_pass static_proxy_user_pass;</span><br><span> </span><br><span>@@ -=
288,6 +293,10 @@</span><br><span>     p-&gt;up =3D static_proxy_user_pass; =
/* this is a copy of protected memory */</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> #if 0</span><br><span> /* function only used in #if 0 de=
bug statement */</span><br><span> static void</span><br><span>diff --git a/=
src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index f8cfe1c5=2E=
=2E86b4fc9 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>=
+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -165,6 +165,11 @@</span><br><sp=
an>     return CMSG_SPACE(sizeof(socket_descriptor_t));</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-c=
onversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /*</span><br><span>  * Send a command (char), data (head), and a file desc=
riptor (sd_send) to a local process</span><br><span>  * over unix socket sd=
=2E  Unfortunately, there&#39;s no portable way to send file descriptors</s=
pan><br><span>@@ -618,6 +623,10 @@</span><br><span>     return IOSTAT_GOOD;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  =
* Forward data from pc to pc-&gt;counterpart=2E</span><br><span>  */</span>=
<br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><b=
r><span>index a18f33b=2E=2E6f628b8 100644</span><br><span>--- a/src/openvpn=
/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -38=
9,6 +389,11 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><s=
pan> receive_auth_pending(struct context *c, const struct buffer *buffer)</=
span><br><span> {</span><br><span>@@ -795,6 +800,10 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><=
br><span> send_push_options(struct context *c, struct buffer *buf, struct p=
ush_list *push_list, int safe_cap,</span><br><span>                   bool =
*push_sent, bool *multi_push)</span><br><span>diff --git a/src/openvpn/reli=
able=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index 7b5b17c=2E=2Eb045=
b1f 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+=
++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -311,6 +311,11 @@</span><b=
r><span>  * struct reliable member functions=2E</span><br><span>  */</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-convers=
ion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void<=
/span><br><span> reliable_init(struct reliable *rel, int buf_size, int offs=
et, int array_size, bool hold)</span><br><span> {</span><br><span>@@ -780,6=
 +785,10 @@</span><br><span>     ASSERT(0); /* buf not found in rel */</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Ena=
ble an outgoing buffer previously returned by a get function as active=2E</=
span><br><span>  */</span><br><span>diff --git a/src/openvpn/route=2Ec b/sr=
c/openvpn/route=2Ec</span><br><span>index d0d26c6=2E=2Ee8e1f60 100644</span=
><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/ro=
ute=2Ec</span><br><span>@@ -582,6 +582,11 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> bool</span><br><span> block_local_needed(const struct route_li=
st *rl)</span><br><span> {</span><br><span>@@ -3217,6 +3222,10 @@</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* IPv6 =
implementation using netlink</span><br><span>  * https://www=2Elinuxjournal=
=2Ecom/article/7356 - &quot;Kernel Korner - Why and How to Use Netlink Sock=
et&quot;</span><br><span>  * netlink(3), netlink(7), rtnetlink(7)</span><br=
><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><=
br><span>index 1fbd07b=2E=2Ec07ef60 100644</span><br><span>--- a/src/openvp=
n/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@=
@ -422,6 +422,11 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> socket_descriptor_t</span><br><span> socket_do_accept(socket_descripto=
r_t sd, struct link_socket_actual *act, const bool nowait)</span><br><span>=
 {</span><br><span>@@ -2084,6 +2089,10 @@</span><br><span>     return buf-&=
gt;len;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifnd=
ef _WIN32 */</span><br><span> </span><br><span> /*</span><br><span>diff --g=
it a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index =
52e09c9=2E=2E2210bfe 100644</span><br><span>--- a/src/openvpn/socket=2Eh</s=
pan><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -288,12 +288,=
21 @@</span><br><span>     return sh=2Eis_handle ? (int)GetLastError() : WS=
AGetLastError();</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> inline static void</span><br><span> =
SocketHandleSetLastError(sockethandle_t sh, DWORD err)</span><br><span> {</=
span><br><span>     sh=2Eis_handle ? SetLastError(err) : WSASetLastError(er=
r);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline void=
</span><br><span> SocketHandleSetInvalError(sockethandle_t sh)</span><br><s=
pan> {</span><br><span>@@ -459,6 +468,11 @@</span><br><span> </span><br><sp=
an> #endif /* if PORT_SHARE */</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> static inline bool</span><br><span> socket_=
connection_reset(const struct link_socket *sock, ssize_t status)</span><br>=
<span> {</span><br><span>@@ -482,6 +496,10 @@</span><br><span>     return f=
alse;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline bo=
ol</span><br><span> link_socket_verify_incoming_addr(const struct buffer *b=
uf, const struct link_socket_info *info,</span><br><span>                  =
                const struct link_socket_actual *from_addr)</span><br><span=
>@@ -649,6 +667,11 @@</span><br><span> ssize_t link_socket_write_tcp(struct=
 link_socket *sock, struct buffer *buf,</span><br><span>                   =
            struct link_socket_actual *to);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span>=
 </span><br><span> static inline int</span><br><span>@@ -721,6 +744,10 @@</=
span><br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static inline ssize_t</span><br><span> link_socket_write=
_udp(struct link_socket *sock, struct buffer *buf, struct link_socket_actua=
l *to)</span><br><span> {</span><br><span>diff --git a/src/openvpn/socket_u=
til=2Ec b/src/openvpn/socket_util=2Ec</span><br><span>index 879be73=2E=2Ea0=
49f33 100644</span><br><span>--- a/src/openvpn/socket_util=2Ec</span><br><s=
pan>+++ b/src/openvpn/socket_util=2Ec</span><br><span>@@ -123,6 +123,11 @@<=
/span><br><span> #define IF_NAMESIZE 16</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char=
 *</span><br><span> print_link_socket_actual_ex(const struct link_socket_ac=
tual *act, const char *separator,</span><br><span>                         =
    const unsigned int flags, struct gc_arena *gc)</span><br><span>@@ -188,=
6 +193,10 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /*</span><br><span>  * Convert an in_addr_t in host byte orde=
r</span><br><span>  * to an ascii dotted quad=2E</span><br><span>diff --git=
 a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index a8c9=
fd3=2E=2E51e3a1e 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><=
br><span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -226,6 +226,11 @@</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br>=
<span> recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *ad=
dr,</span><br><span>                  const struct event_timeout *server_po=
ll_timeout, volatile int *signal_received)</span><br><span>@@ -310,6 +315,1=
0 @@</span><br><span>     return true;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> static int</span><br><span> port_from_servname(const char =
*servname)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index a538b52=2E=2Ee253242 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -152,6 +152,11 @@</span><br><span>     return=
 limit;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> void</span><br><span> tls_init_control_channel_=
frame_parameters(struct frame *frame, int tls_mtu)</span><br><span> {</span=
><br><span>@@ -236,6 +241,10 @@</span><br><span>     return overhead;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> init_=
ssl_lib(void)</span><br><span> {</span><br><span>@@ -797,6 +806,11 @@</span=
><br><span>     return false;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** @addtogroup control=
_processor</span><br><span>  *  @{ */</span><br><span> </span><br><span>@@ =
-1048,6 +1062,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Clean up a \=
c tls_session structure=2E</span><br><span>  * @ingroup control_processor</=
span><br><span>@@ -1330,6 +1348,11 @@</span><br><span>     key_source_print=
(&amp;k-&gt;server, &quot;Server&quot;);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</s=
pan><br><span> openvpn_PRF(const uint8_t *secret, size_t secret_len, const =
char *label, const uint8_t *client_seed,</span><br><span>             size_=
t client_seed_len, const uint8_t *server_seed, size_t server_seed_len,</spa=
n><br><span>@@ -4482,3 +4505,7 @@</span><br><span> done:</span><br><span>  =
   return BSTR(&amp;out);</span><br><span> }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/sr=
c/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>ind=
ex 45d7715=2E=2Ecbc3118 100644</span><br><span>--- a/src/openvpn/ssl_mbedtl=
s=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ =
-199,6 +199,11 @@</span><br><span>         ciphers);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> vo=
id</span><br><span> tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, cons=
t char *ciphers)</span><br><span> {</span><br><span>@@ -1187,6 +1192,10 @@<=
/span><br><span>     return 1;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /* **************************************</span><br><span>  *</spa=
n><br><span>  * Information functions</span><br><span>diff --git a/src/open=
vpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index f13f507=2E=
=2Edf9e42c 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -393,6 +393,11 @@</sp=
an><br><span>     return ret;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *sess=
ion, const char *common_cipher)</span><br><span> {</span><br><span>@@ -576,=
6 +581,10 @@</span><br><span>     o-&gt;ncp_ciphers =3D (char *)ncp_ciphers=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>=
  * Checks for availibility of Chacha20-Poly1305 and sets</span><br><span> =
 * the ncp_cipher to either AES-256-GCM:AES-128-GCM or</span><br><span>diff=
 --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><b=
r><span>index fe2bfda=2E=2E035cfb8 100644</span><br><span>--- a/src/openvpn=
/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><b=
r><span>@@ -277,7 +277,14 @@</span><br><span>     sslopt |=3D SSL_OP_NO_REN=
EGOTIATION;</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMBER) &amp=
;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span>     SSL_CTX_set_options(ctx-&gt;ctx, sslopt);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_V=
ERSION_NUMBER) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an> </span><br><span>     if (!tls_ctx_set_tls_versions(ctx, ssl_flags))</s=
pan><br><span>     {</span><br><span>@@ -511,6 +518,11 @@</span><br><span> =
{</span><br><span>     ASSERT(ctx);</span><br><span> #if OPENSSL_VERSION_NU=
MBER &lt; 0x30000000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     /* This method could be as easy as</span><br=
><span>      *  SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups)</span><br><sp=
an>@@ -556,6 +568,10 @@</span><br><span>         crypto_msg(M_FATAL, &quot;=
Failed to set allowed TLS group list: %s&quot;, groups);</span><br><span>  =
   }</span><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #else  /* if OP=
ENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span>     if (!SSL_CTX_=
set1_groups_list(ctx-&gt;ctx, groups))</span><br><span>     {</span><br><sp=
an>@@ -1466,6 +1482,11 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversi=
on&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</s=
pan><br><span>  * Pass the input hash in &#39;dgst&#39; to management and g=
et the signature back=2E</span><br><span>  *</span><br><span>@@ -1710,6 +17=
31,11 @@</span><br><span>     return 0;</span><br><span> }</span><br><span>=
 #endif /* !defined(OPENSSL_NO_EC) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #endif /* ENABLE_MANAGEMENT &amp;&amp; !=
HAVE_XKEY_PROVIDER */</span><br><span> </span><br><span> #ifdef ENABLE_MANA=
GEMENT</span><br><span>@@ -2099,6 +2125,11 @@</span><br><span>  * to BIOs=
=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> static void</span><br><span> bio_write_post(const=
 int status, struct buffer *buf)</span><br><span> {</span><br><span>@@ -211=
0,6 +2141,10 @@</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /*</span><br><span>  * Read from an OpenSSL BIO in non-blo=
cking mode=2E</span><br><span>  */</span><br><span>diff --git a/src/openvpn=
/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index f78782f=2E=2E6=
0573ee 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br=
><span>  */</span><br><span> #define SWAP_BUF_SIZE 256</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
>  * Move a packet authentication HMAC + related fields to or from the fron=
t</span><br><span>  * of the buffer so it can be processed by encrypt/decry=
pt=2E</span><br><span>@@ -591,3 +596,7 @@</span><br><span>     buf_advance(=
buf, cmdlen);</span><br><span>     return cmdbuf;</span><br><span> }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec</=
span><br><span>index ba185c1=2E=2E337faed 100644</span><br><span>--- a/src/=
openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span><=
br><span>@@ -86,6 +86,10 @@</span><br><span>     return var_value;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> </span><br><span> unsigned int</span><br><s=
pan> peer_info_extract_int(const char *peer_info, const char *field, const =
char *format, unsigned int default_value)</span><br><span>@@ -166,6 +170,10=
 @@</span><br><span>     return BSTR(&amp;buf);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /**</span><br><span>  * SSL/TLS Cipher suite name=
 translation table</span><br><span>  */</span><br><span>diff --git a/src/op=
envpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 0cd=
ec1e=2E=2Ebf0267d 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</=
span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -400,6 +=
400,11 @@</span><br><span>     return SUCCESS;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span=
><br><span>  * Export the subject, common_name, and raw certificate fields =
to the</span><br><span>  * environment for later verification by scripts an=
d plugins=2E</span><br><span>@@ -803,6 +808,10 @@</span><br><span>     retu=
rn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* ***********=
****************************************************************</span><br>=
<span>  * Functions for the management of deferred authentication when usin=
g</span><br><span>  * user/password authentication=2E</span><br><span>@@ -8=
84,6 +893,11 @@</span><br><span>     return supported;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-co=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  *  Checks if the deferred state should also send auth=
 pending</span><br><span>  *  request to the client=2E Also removes the aut=
h_pending control file</span><br><span>@@ -958,6 +972,10 @@</span><br><span=
>     return ret;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**<=
/span><br><span>  *  Removes auth_pending and auth_control files from file =
system</span><br><span>  *  and key_state structure</span><br><span>diff --=
git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=
=2Ec</span><br><span>index a132f12=2E=2Ebba2f2f 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify_mbedtls=2Ec</span><br><span>@@ -222,6 +222,11 @@</span><br><span>   =
  return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> result_t</span><br><span> backend_x5=
09_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls=
_x509_crt *cert)</span><br><span> {</span><br><span>@@ -786,6 +791,10 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
* Dummy function because Netscape certificate types are not supported in Op=
enVPN with mbedtls=2E</span><br><span>  * Returns SUCCESS if usage is NS_CE=
RT_CHECK_NONE, FAILURE otherwise=2E */</span><br><span> result_t</span><br>=
<span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_ver=
ify_openssl=2Ec</span><br><span>index 0c36cf2=2E=2E19339ad 100644</span><br=
><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -317,6 +317,11 @@</span><b=
r><span>     return serial;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> char *</span><br><span> bac=
kend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)</s=
pan><br><span> {</span><br><span>@@ -573,6 +578,10 @@</span><br><span>     =
gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</=
span><br><span>  * Save X509 fields to environment, using the naming conven=
tion:</span><br><span>  *</span><br><span>diff --git a/src/openvpn/status=
=2Ec b/src/openvpn/status=2Ec</span><br><span>index 1036536=2E=2E533619f 10=
0644</span><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src=
/openvpn/status=2Ec</span><br><span>@@ -55,6 +55,11 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> struct status_output *</span><br><span> status_open(=
const char *filename, const int refresh_freq, const int msglevel,</span><br=
><span>             const struct virtual_output *vout, const unsigned int f=
lags)</span><br><span>@@ -119,6 +124,10 @@</span><br><span>     return so;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> =
status_trigger(struct status_output *so)</span><br><span> {</span><br><span=
>@@ -206,6 +215,11 @@</span><br><span>     return ret;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-co=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#define STATUS_PRINTF_MAXLEN 512</span><br><span> </span><br><span> void</s=
pan><br><span>@@ -297,3 +311,7 @@</span><br><span> </span><br><span>     re=
turn ret;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/tls_cr=
ypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index d66b96d=2E=2E2dad=
c4f 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>=
+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -93,6 +93,11 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> bool</span><br><span> tls_session_ge=
nerate_dynamic_tls_crypt_key(struct tls_session *session)</span><br><span> =
{</span><br><span>@@ -518,6 +523,10 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><=
span> tls_crypt_v2_check_client_key_age(const struct buffer *tls_crypt_v2_m=
etadata, int max_days)</span><br><span> {</span><br><span>@@ -698,6 +707,11=
 @@</span><br><span>     write_pem_key_file(filename, tls_crypt_v2_srv_pem_=
name);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> void</span><br><span> tls_crypt_v2_write_client_=
key_file(const char *filename, const char *b64_metadata,</span><br><span>  =
                                  const char *server_key_file, bool server_=
key_inline)</span><br><span>@@ -801,3 +815,7 @@</span><br><span> </span><br=
><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git =
a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index bcea331=
=2E=2E07e036e 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -112,6 +112,11 @@</span><b=
r><span> </span><br><span> static const char *netsh_get_id(const char *dev_=
node, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static bool</span><br><span> do_address_servic=
e(const bool add, const short family, const struct tuntap *tt)</span><br><s=
pan> {</span><br><span>@@ -479,6 +484,10 @@</span><br><span>     return ret=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifdef _WIN=
32 */</span><br><span> </span><br><span> #ifdef TARGET_SOLARIS</span><br><s=
pan>@@ -815,6 +824,11 @@</span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /*</span><br><span>  * Init tun/tap object=2E</span><br><span>  *<=
/span><br><span>@@ -1556,6 +1570,10 @@</span><br><span> #endif</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /* execute the ifconfig command th=
rough the shell */</span><br><span> void</span><br><span> do_ifconfig(struc=
t tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,</s=
pan><br><span>@@ -1701,6 +1719,11 @@</span><br><span> #include &lt;netinet/=
ip=2Eh&gt;</span><br><span> #include &lt;sys/uio=2Eh&gt;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline ssi=
ze_t</span><br><span> header_modify_read_write_return(ssize_t len)</span><b=
r><span> {</span><br><span>@@ -1786,6 +1809,10 @@</span><br><span> }</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* if defined(TA=
RGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || def=
ined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span> </span>=
<br><span> bool</span><br><span>@@ -2043,6 +2070,11 @@</span><br><span>    =
 free(tt);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> ssize_t</span><br><span> write_tun(const str=
uct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><=
span>@@ -2055,6 +2087,10 @@</span><br><span>     return read(tt-&gt;fd, buf=
, len);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(=
TARGET_LINUX)</span><br><span> </span><br><span> #if !PEDANTIC</span><br><s=
pan>@@ -2252,6 +2288,11 @@</span><br><span>     free(tt);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> ssize_t</span><br><span> write_tun(const struct tuntap *tt, const uint=
8_t *buf, int len)</span><br><span> {</span><br><span>@@ -2264,6 +2305,10 @=
@</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #elif defined(TARGET_SOLARIS)</span><br>=
<span> </span><br><span> #ifndef TUNNEWPPA</span><br><span>@@ -2881,6 +2926=
,11 @@</span><br><span> </span><br><span> #elif defined(TARGET_DARWIN)</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conve=
rsion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* =
Darwin (MacOS X) is mostly &quot;just use the generic stuff&quot;, but ther=
e</span><br><span>  * is always one caveat=2E=2E=2E:</span><br><span>  *</s=
pan><br><span>@@ -2946,6 +2996,10 @@</span><br><span>     return fd;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> open_d=
arwin_utun(const char *dev, const char *dev_type, const char *dev_node, str=
uct tuntap *tt)</span><br><span> {</span><br><span>@@ -3095,6 +3149,11 @@</=
span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ssize_t</span><br=
><span> write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</sp=
an><br><span> {</span><br><span>@@ -3121,6 +3180,10 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(TARGE=
T_AIX)</span><br><span> </span><br><span> void</span><br><span>@@ -3257,6 +=
3320,11 @@</span><br><span> </span><br><span> #elif defined(_WIN32)</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversi=
on&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</s=
pan><br><span> tun_read_queue(struct tuntap *tt, int maxsize)</span><br><sp=
an> {</span><br><span>@@ -6101,6 +6169,10 @@</span><br><span>     argv_free=
(&amp;argv);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</spa=
n><br><span> close_tun_handle(struct tuntap *tt)</span><br><span> {</span><=
br><span>@@ -6280,7 +6352,7 @@</span><br><span>     return BSTR(&amp;out);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#else                        /* generic */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#else  /* generic */</span><br><span>=
 </span><br><span> void</span><br><span> open_tun(const char *dev, const ch=
ar *dev_type, const char *dev_node, struct tuntap *tt,</span><br><span>@@ -=
6310,4 +6382,4 @@</span><br><span>     return read(tt-&gt;fd, buf, len);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif                       /* if defined (TARGET_ANDROID) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if define=
d (TARGET_ANDROID) */</span><br><span>diff --git a/src/openvpn/tun_afunix=
=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index 79d706a=2E=2E155bf8=
d 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><br><span>+=
++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -48,6 +48,11 @@</span><b=
r><span> #include &lt;stdlib=2Eh&gt;</span><br><span> </span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, co=
nst struct env_set *env)</span><br><span> {</span><br><span>@@ -171,6 +176,=
11 @@</span><br><span>      * with error messages */</span><br><span>     r=
eturn read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else  /* ifndef WIN32 =
*/</span><br><span> </span><br><span> // cppcheck-suppress-begin constParam=
eterPointer ; stubs</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src=
/openvpn/vlan=2Ec</span><br><span>index 04e18d6=2E=2Ed44dac1 100644</span><=
br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=
=2Ec</span><br><span>@@ -56,6 +56,11 @@</span><br><span>         (hdr-&gt;p=
cp_cfi_vid &amp; ~OPENVPN_8021Q_MASK_VID) | (htons(vid) &amp; OPENVPN_8021Q=
_MASK_VID);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /*</span><br><span>  * vlan_decapsulate - r=
emove 802=2E1q header and return VID</span><br><span>  *</span><br><span>@@=
 -170,6 +175,10 @@</span><br><span>     return -1;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /*</span><br><span>  * vlan_encapsulate - add =
802=2E1q header and set the context related VID</span><br><span>  *</span><=
br><span>diff --git a/src/openvpn/wfp_block=2Ec b/src/openvpn/wfp_block=2Ec=
</span><br><span>index 4d38fdb=2E=2Eb576899 100644</span><br><span>--- a/sr=
c/openvpn/wfp_block=2Ec</span><br><span>+++ b/src/openvpn/wfp_block=2Ec</sp=
an><br><span>@@ -131,6 +131,11 @@</span><br><span>     return err;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /*</span><br><span>  * Block outgoing local traffic, possibly =
DNS only, except for</span><br><span>  * (i) adapter with the specified ind=
ex (and loopback, if all is blocked)</span><br><span>@@ -340,6 +345,10 @@</=
span><br><span>     return err;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> DWORD</span><br><span> delete_wfp_block_filters(HANDLE engine_han=
dle)</span><br><span> {</span><br><span>diff --git a/src/openvpn/win32-util=
=2Ec b/src/openvpn/win32-util=2Ec</span><br><span>index e2c8810=2E=2E5f99e2=
b 100644</span><br><span>--- a/src/openvpn/win32-util=2Ec</span><br><span>+=
++ b/src/openvpn/win32-util=2Ec</span><br><span>@@ -36,6 +36,11 @@</span><b=
r><span> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;wi=
n32-util=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ign=
ored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> WCHAR *</span><br><span> wide_string(const char *utf8, =
struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -131,6 +136,10 @=
@</span><br><span>     return utf8;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /*</span><br><span>  * Return true if filename is safe to be =
used on Windows,</span><br><span>  * by avoiding the following reserved nam=
es:</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=
=2Ec</span><br><span>index 3af58ed=2E=2E079869f 100644</span><br><span>--- =
a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><=
br><span>@@ -545,6 +545,11 @@</span><br><span>     CLEAR(*ws);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> void</span><br><span> win32_signal_open(struct win32_signal *ws, in=
t force, const char *exit_event_name,</span><br><span>                   bo=
ol exit_event_initial_state)</span><br><span>@@ -1661,4 +1666,8 @@</span><b=
r><span>     return ret;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #endif /* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpn/xkey_=
helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>index 6908cbb=2E=
=2Ef4be796 100644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</span><=
br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -146,6 +146,1=
1 @@</span><br><span> }</span><br><span> </span><br><span> #ifdef ENABLE_MA=
NAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> /**</spa=
n><br><span>  * Signature callback for xkey_provider with management-extern=
al-key</span><br><span>  *</span><br><span>@@ -276,6 +281,10 @@</span><br><=
span> </span><br><span>     return (*siglen &gt; 0);</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #endif /* ENABLE MANAGEMENT */</span><br><span> </span><br><sp=
an> /**</span><br><span>diff --git a/src/openvpn/xkey_provider=2Ec b/src/op=
envpn/xkey_provider=2Ec</span><br><span>index a349d4d=2E=2E9211c11 100644</=
span><br><span>--- a/src/openvpn/xkey_provider=2Ec</span><br><span>+++ b/sr=
c/openvpn/xkey_provider=2Ec</span><br><span>@@ -940,6 +940,11 @@</span><br>=
<span>     return ret;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> sign=
ature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,</=
span><br><span>                const unsigned char *tbs, size_t tbslen)</sp=
an><br><span>@@ -1074,6 +1079,10 @@</span><br><span>     return signature_s=
ign(ctx, sig, siglen, sigsize, buf, sz);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> /* Sign digest using native sign function -- will only w=
ork for native keys</span><br><span>  */</span><br><span> int</span><br><sp=
an>diff --git a/src/openvpnmsica/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec=
</span><br><span>index 85ebda9=2E=2E777c823 100644</span><br><span>--- a/sr=
c/openvpnmsica/dllmain=2Ec</span><br><span>+++ b/src/openvpnmsica/dllmain=
=2Ec</span><br><span>@@ -98,6 +98,11 @@</span><br><span>     return true;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> void</span><br><span> x_msg_va(const unsigned int flags,=
 const char *format, va_list arglist)</span><br><span> {</span><br><span>@@=
 -189,3 +194,7 @@</span><br><span>                       hRecordProg);</spa=
n><br><span>     MsiCloseHandle(hRecordProg);</span><br><span> }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span>diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</=
span><br><span>index 671ddde=2E=2Ee20feb7 100644</span><br><span>--- a/src/=
openvpnserv/common=2Ec</span><br><span>+++ b/src/openvpnserv/common=2Ec</sp=
an><br><span>@@ -30,6 +30,11 @@</span><br><span> LPCWSTR service_instance =
=3D L&quot;&quot;;</span><br><span> static wchar_t win_sys_path[MAX_PATH];<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-c=
onversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 static DWORD</span><br><span> GetRegString(HKEY key, LPCWSTR value, LPWSTR=
 data, DWORD size, LPCWSTR default_value)</span><br><span> {</span><br><spa=
n>@@ -309,6 +314,10 @@</span><br><span>     return utf16;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> const wchar_t *</span><br><span> get_wi=
n_sys_path(void)</span><br><span> {</span><br><span>diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>ind=
ex 81205d6=2E=2Eac6a264 100644</span><br><span>--- a/src/openvpnserv/intera=
ctive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><=
span>@@ -524,6 +524,10 @@</span><br><span>     free(sud-&gt;directory);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignore=
d &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span> </span><br><span> static SOCKADDR_INET<=
/span><br><span> sockaddr_inet(short family, const inet_address_t *addr)</s=
pan><br><span>@@ -3964,6 +3968,9 @@</span><br><span>     return 0;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br=
><span> static DWORD WINAPI</span><br><span> ServiceCtrlInteractive(DWORD c=
trl_code, DWORD event, LPVOID data, LPVOID ctx)</span><br><span>diff --git =
a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</sp=
an><br><span>index 948b6af=2E=2E0cd201d 100644</span><br><span>--- a/src/pl=
ugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth=
-pam=2Ec</span><br><span>@@ -184,6 +184,11 @@</span><br><span>     return -=
1;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static ssize_t</span><br><span> send_string(int fd, =
const char *string)</span><br><span> {</span><br><span>@@ -199,6 +204,10 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #ifdef DO_DAEMONIZE</span><br><span> </span><br><span> /*</span><br><span=
>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</span><br><span>index=
 ac1ecd2=2E=2Ea3d83e9 100644</span><br><span>--- a/src/tapctl/tap=2Ec</span=
><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -102,6 +102,11 @@</s=
pan><br><span> }</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Returns l=
ength of string of strings</span><br><span>  *</span><br><span>@@ -1226,6 +=
1231,9 @@</span><br><span>     return dwResult;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> void</span><=
br><span> tap_free_adapter_list(_In_ struct tap_adapter_node *pAdapterList)=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/te=
sts/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index 338265d=2E=2Eb=
480985 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br>=
<span>@@ -106,6 +106,11 @@</span><br><span>     gc_free(&amp;gc);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> static void</span><br><span> test_buffer_format_hex_ex(void **=
state)</span><br><span> {</span><br><span>@@ -139,6 +144,10 @@</span><br><s=
pan>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> struct test_buffer_list_aggregate_ctx</span><br><span> {</span><br><sp=
an>     struct buffer_list *empty;</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</s=
pan><br><span>index f86aca8=2E=2Ee68a0b2 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_crypto=2Ec</span><br><span>@@ -52,6 +52,11 @@</span><br><span>=
 </span><br><span> static const char testtext[] =3D &quot;Dummy text to tes=
t PEM encoding&quot;;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static void</span><br><span> crypto_pem_encode_decod=
e_loopback(void **state)</span><br><span> {</span><br><span>@@ -799,6 +804,=
10 @@</span><br><span>     assert_null(epoch_lookup_decrypt_key(co, 23));</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> c=
rypto_test_epoch_key_overflow(void **state)</span><br><span> {</span><br><s=
pan>@@ -914,6 +923,11 @@</span><br><span>     assert_memory_equal(out, expe=
cted_hash, UT_SIPHASH_HASH_SIZE);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br=
><span> test_siphash_openssl(void **state)</span><br><span> {</span><br><sp=
an>@@ -959,6 +973,9 @@</span><br><span>     siphash_openssl_uninit(sipctx);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </=
span><br><span> int</span><br><span> main(void)</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/unit_tests/openvpn/te=
st_cryptoapi=2Ec</span><br><span>index 37bbe92=2E=2E55aafbb 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>@@ -137,6 =
+137,11 @@</span><br><span>     return c-&gt;cert ? c : NULL;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-W=
sign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /* import sample certificates into windows cert store */</span><br><=
span> static void</span><br><span> import_certs(void **state)</span><br><sp=
an>@@ -223,6 +228,10 @@</span><br><span>     certs_loaded =3D true;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> c=
leanup(void **state)</span><br><span> {</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</=
span><br><span>index 3a84e1e=2E=2Ee331d3d 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_dhcp=2Ec</span><br><span>@@ -50,6 +50,11 @@</span><br><span>   =
  return &quot;dummy&quot;;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span=
> test_write_dhcp_search_str(void **state)</span><br><span> {</span><br><sp=
an>@@ -141,6 +146,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</s=
pan><br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_networking=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><s=
pan>index 1c9cac1=2E=2Eae75386 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_networking=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_networking=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br><span>  =
   return net_iface_del(NULL, name);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int</span><=
br><span> net__iface_mtu_set(int mtu)</span><br><span> {</span><br><span>@@=
 -48,6 +53,10 @@</span><br><span>     return net_iface_mtu_set(NULL, iface,=
 mtu);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int</spa=
n><br><span> net__addr_v4_add(const char *addr_str, int prefixlen)</span><b=
r><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=
=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index 49ba833=
=2E=2E889e6d7 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pk=
t=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br=
><span>@@ -618,6 +618,11 @@</span><br><span>     assert_memory_equal(server=
_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void=
</span><br><span> test_generate_reset_packet_plain(void **ut_state)</span><=
br><span> {</span><br><span>@@ -696,6 +701,10 @@</span><br><span>     free_=
tas(&amp;tas_server);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/* A peer can ask us to append the wrapped client key (WKc) to our next</sp=
an><br><span>  * control packet=2E Only a tls-crypt-v2 client has one, so c=
heck that we</span><br><span>  * refuse to build such a packet when we have=
 no key instead of walking</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>=
index 4987dd0=2E=2E85b8d12 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>@@ -265,6 +265,10 @@</span><br><span> #endif /* HAVE_O=
PENSSL_STORE */</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 static void</span><br><span> init_frame_parameters(struct frame *frame)</s=
pan><br><span>@@ -886,6 +890,10 @@</span><br><span>     free_certificate(ce=
rt);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Certificate wi=
th two CNs, &quot;foo&quot; and &quot;bar&quot;=2E</span><br><span>  *</spa=
n><br><span>  * Generated with:</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec=
</span><br><span>index f8aa199=2E=2Eab90ea5 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -232,6 +232,11 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Check that s=
hort messages are successfully wrapped-and-unwrapped=2E</span><br><span>  *=
/</span><br><span>@@ -773,6 +778,10 @@</span><br><span>     tls_wrap_free(&=
amp;wrap_ctx);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c void</span><br><span> test_tls_crypt_v2_write_server_key_file(void **stat=
e)</span><br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br=
><span>index 776a86a=2E=2E5bc1d2a 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_user_pass=2Ec</span><br><span>@@ -46,6 +46,12 @@</span><br><span> =
    return query_user_exec_builtin();</span><br><span> }</span><br><span> #=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> query_us=
er_exec_builtin(void)</span><br><span> {</span><br><span>@@ -58,6 +64,11 @@=
</span><br><span> </span><br><span>     return mock();</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void=
</span><br><span> management_auth_failure(const struct management *man, con=
st char *type, const char *reason)</span><br><span> {</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=
=3Demail">change 1186</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1186?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1186 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--LK/DbW1Zkak=--


--===============3992784510260860158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3992784510260860158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3992784510260860158==--

