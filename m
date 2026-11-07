Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E60606A326
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k1RoMv//;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AALf6SEv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lt62D0Az;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fP5obKSN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dJo2in7qz6NtV0Yvey63G53WeR2xMISYWdDiXN6ABeo=; b=k1RoMv//q1NKYUnPlnXHWB+HRj
	esVud9DcMz4GLH6Mjv62OLJZo0MOrYKK13JvtAnbqEfcQ5jk98IqgBxAJzZvNE4GlKWEAfjhz2/4D
	5sEsMg6FF1AXEonwDPu0qXm5TuGfIMjxD0dU1GyMKUVOeAyUfsD5Fbt3s9j9FFmHu1dE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPjTL-000000008Mn-3RnM;
	Sat, 07 Nov 2026 16:40:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPjTL-000000008Mh-00lu
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 16:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WBcAVpE3vTa2U0XKimP/Ucc2OAmrLnW8PoPVy40ErN8=; b=AALf6SEvPILxsIv58AQmeh8gze
 ncwkqlsFvk3nLTurKNcC54Gnpv1DEWUWO7AQNIxy1OgLeMbAW/y2LBLsQi6bP1MpOBqVaj0JD0vz1
 pD1MixNEE9pFPz1KZYsKBulkEZAf3Eu/5yLaGf9x82bCVdCfLyfEhj3KpUGtiDu4BBgA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WBcAVpE3vTa2U0XKimP/Ucc2OAmrLnW8PoPVy40ErN8=; b=Lt62D0AzMvnYKDG4rMs/CMMExW
 L8z7n9BNBjHvOvYGTh5Y9xWz1u4Q0zP37otDhESsnN5uT/0ZleZVbab9BVgpFveeu74JufDHEib8Q
 3zljR4IMYqHbKu3P4MdWnHzbRjrAktdGFNy7E4AUO6MbiFZ0R9eyFNxLFeG3lKJi9Jek=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPjTI-000000002Js-1ve4 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 16:40:54 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so954947f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794069646; x=1794674446; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WBcAVpE3vTa2U0XKimP/Ucc2OAmrLnW8PoPVy40ErN8=;
 b=fP5obKSNmp2SxlxnQyzNv5nPb5cBV4HSb0otH/2zXQIfCccKsFVI6VFVpBQY+3A67o
 qb5mychjLj91fiPUxYQJSwHEDxj/bwDrALrbv9A3vRVv8+D/SbLYesNYOvmd74XBAeHw
 HcC6oQT63KM0OpgPNSxcNvRTDS7MuLgmWfrEBNitAxLWMqL7+E3pCR5qw5o0M5KjIMIe
 h+g2I6n1fQQdgAI0P6u+oRgbXU+7DeobI+L7hTRqiWjlQVfPOqVLks18t7V3J2Vq4Fi2
 WRSZzlYw1+UPkdcypIr2YPjDt+Czmbgwgpq210OtI4X/j6rwf88QBdxuWJpsctDeBIUl
 Ja/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794069646; x=1794674446;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WBcAVpE3vTa2U0XKimP/Ucc2OAmrLnW8PoPVy40ErN8=;
 b=2mEwWRKStXkU0nChGYYANx1TpzUmp/+Vn+59401knATb3cAcvNmolGiiG4993GSiPS
 iFQGOvmggtah4EH2zaIYy6t5tt9isdk69Exj7zzfjDTWQC9VGGK9TypBLXMXZ+x1JAwO
 t13A4J9eIwH1Gbeg9B/ERZzqdAscrC2OvyujUrwxg/aj7n7tMiGrtqLIaffSho+mGyWU
 RC+mFoVwhQNENF4swLM9p8jE1F/fXL7qyBcXpZMsoRJ5T3CweAnhS09Z2xr5E2vZzXWQ
 UM1GjqBgIXUsQkwjuJOij0KHeB35i2TtkZxU5q4Z8fPG2vEfOKjnku3sJng8xwyv6vFZ
 WPyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFnQGSgeeL8y+/ilGg/A3DA4rOaGtKN6F0W1xwvaIeMjTmAuO/skC6sFvq26GIT6Re/m9e+ogxdsqWjcfeI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+wtVMWAR4+wUmZRuqjkIOBshZIJjWnh9E/0ceaH1pM2oEcbPqQ
 7QtI+y6Luyk8rTX5of7n1A1+JfTSXusDY6iPrS6YgJfy4smB/+ongoeCPtL9lD5z+dY5JC3kq8S
 rcFIRBWlhRwj3rjsGmB1GBuxN6HPXu81Xwk5RDLM5WnJg4kJHsPc7OX52cQBnz5zKB5o668isIu
 vfmCBVBg==
X-Gm-Gg: AYBFou3ny3+p1mNw/YLsOOKi4pTEOJwiSD9AamvzUL350T6OgmESuZD2P6rkO+FNYYE
 9It5EOROfwdyFMZIF7lGzrIvU9HMaq4n760G+9oeGVX23pcv1Imoqyu/LxUJasKp4Qj8j4Ss7md
 8onlKJdFHvFQ0j523Sr45+nLWVqlUmehDqgxx2mmvufm2FzYU8/ah8gzsIUwRj9zuuAvFkRrQ4U
 j9IGiPUebEcIjVzwq98P/LOFXc9cUDJnScn9o3w3gtudBgze9tK/8qlJ+nHomoYwuklTbyWjahg
 yfY5WaIxIXBCtm6JAZTmgdKEZMZ4bGD9q8MlOV8MRdCmp0OLHzMiN9UxzDW6dtHjFyac50+rOBa
 N765NtXdm8ePZuYPZka0rWDP5YJLvWfLP2qhOVRPyZi40zLOvXQYFWE9GomrweBNifb8JCmdf7H
 vX1JcnCctgC6iWMpayURDiRdH/SqguLn62rBKex7qs5bTJZhxP+N0oqctNWeoEdTSijvSd1tMMI
 uwySPo3xceuZ5svggo/CWJ4IBOAbvvz66fx/3ydPdBo+qnrxvz7xsxkBWPn8KEs7LbKSrw2VkTz
 RItOEWEo8rJSXBuBGV6uAKM+n85UzLvLPEJcJJ1M+ihps6b2nSRzfBis5ETH91/WX7YiVyO7/+z
 Suu44fIvut9WuJy8AFviidxVnhF90ZFvGLzHs0eZB+eIYqsYV5QVxY8wnMByRm83OkAxEvcc+0B
 OMW7UFONl7yC9TkmzFLqbqDO9NezFJbiFI06U=
X-Received: by 2002:a05:6000:4b0b:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-49275a271acmr10364780f8f.35.1794069645360; 
 Sat, 07 Nov 2026 08:40:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4948e90965csm3720022f8f.6.2026.11.07.08.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 08:40:44 -0800 (PST)
X-Google-Original-From: "buildbot (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 16:40:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: combinedCheckStateUpdate
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d545f0a6de5ab795a0c80447002f5cb54b48b32
X-Gerrit-Change-Number: 2151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2151?usp=email>
X-Gerrit-Commit: c0f3f3916c8909732e773f4e17f46e2ad88cbf4e
In-Reply-To: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
References: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkkxZDU0NWYwYTZkZTVhYjc5NWEwYzgwNDQ3MDAyZjVjYjU0YjQ4YjMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d31a14ae4e30a7eb9544b292ecf21f247ed378bf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPjTI-000000002Js-1ve4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: merge the
 FreeBSD and DragonFly IPv4 route branches
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "buildbot \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: yura.darnobyt@openvpn.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "buildbot \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0553028239435076098=="
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS,WEIRD_PORT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Message-ID: <20261107164044.IE-2F8LeiN0wAC7U-h6CVlz5ibq5HqeC-0AKnWdDS3w@z>

--===============0553028239435076098==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IfBNmZXnbbg="; charset=UTF-8

--IfBNmZXnbbg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The combined check state has been updated to SUCCESSFUL for patch set 1 of =
this change ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail )=
=2E

All checks:
Successful: Code Format Check, alpine-factory--disable-lz4=
, alpine-factory--disable-lzo, alpine-factory--disable-lzo--disable-lz4--en=
able-comp-stub, alpine-factory--disable-lzo--disable-management, alpine-fac=
tory--disable-management, alpine-factory--enable-developer-debug, alpine-fa=
ctory--enable-small, alpine-factory--with-crypto-librarymbedtls, alpine-fac=
tory-default, arch-factory--disable-lz4, arch-factory--disable-lzo, arch-fa=
ctory--disable-lzo--disable-lz4--enable-comp-stub, arch-factory--disable-lz=
o--disable-management, arch-factory--disable-management, arch-factory--enab=
le-developer-debug, arch-factory--enable-small, arch-factory--with-crypto-l=
ibrarymbedtls, arch-factory-default, cron2-fbsd14-factory--disable-lz4, cro=
n2-fbsd14-factory--disable-lzo, cron2-fbsd14-factory--disable-lzo--disable-=
lz4--enable-comp-stub, cron2-fbsd14-factory--disable-lzo--disable-managemen=
t, cron2-fbsd14-factory--disable-management, cron2-fbsd14-factory--enable-d=
eveloper-debug, cron2-fbsd14-factory--enable-small, cron2-fbsd14-factory-de=
fault, cron2-fbsd15-factory--disable-lz4, cron2-fbsd15-factory--disable-lzo=
, cron2-fbsd15-factory--disable-lzo--disable-lz4--enable-comp-stub, cron2-f=
bsd15-factory--disable-lzo--disable-management, cron2-fbsd15-factory--disab=
le-management, cron2-fbsd15-factory--enable-developer-debug, cron2-fbsd15-f=
actory--enable-small, cron2-fbsd15-factory-default, cron2-fbsd15-smoketest,=
 cron2-nbsd10-factory--disable-lz4, cron2-nbsd10-factory--disable-lzo, cron=
2-nbsd10-factory--disable-lzo--disable-lz4--enable-comp-stub, cron2-nbsd10-=
factory--disable-lzo--disable-management, cron2-nbsd10-factory--disable-man=
agement, cron2-nbsd10-factory--enable-developer-debug, cron2-nbsd10-factory=
--enable-small, cron2-nbsd10-factory--with-crypto-librarymbedtls, cron2-nbs=
d10-factory-default, cron2-obsd-factory--disable-lz4, cron2-obsd-factory--d=
isable-lzo, cron2-obsd-factory--disable-lzo--disable-lz4--enable-comp-stub,=
 cron2-obsd-factory--disable-lzo--disable-management, cron2-obsd-factory--d=
isable-management, cron2-obsd-factory--enable-developer-debug, cron2-obsd-f=
actory--enable-small, cron2-obsd-factory--with-crypto-librarymbedtls, cron2=
-obsd-factory-default, cron2-obsd75-factory--disable-lz4, cron2-obsd75-fact=
ory--disable-lzo, cron2-obsd75-factory--disable-lzo--disable-lz4--enable-co=
mp-stub, cron2-obsd75-factory--disable-lzo--disable-management, cron2-obsd7=
5-factory--disable-management, cron2-obsd75-factory--enable-developer-debug=
, cron2-obsd75-factory--enable-small, cron2-obsd75-factory-default, cron2-o=
i2024-factory--disable-lz4, cron2-oi2024-factory--disable-lzo, cron2-oi2024=
-factory--disable-lzo--disable-lz4--enable-comp-stub, cron2-oi2024-factory-=
-disable-lzo--disable-management, cron2-oi2024-factory--disable-management,=
 cron2-oi2024-factory--enable-developer-debug, cron2-oi2024-factory--enable=
-small, cron2-oi2024-factory-default, debian-12-factory--disable-lz4, debia=
n-12-factory--disable-lzo, debian-12-factory--disable-lzo--disable-lz4--ena=
ble-comp-stub, debian-12-factory--disable-lzo--disable-management, debian-1=
2-factory--disable-management, debian-12-factory--enable-developer-debug, d=
ebian-12-factory--enable-small, debian-12-factory-default, debian-12-factor=
y-package, debian-12-openvpn-legacy-factory-default, debian-13-factory--dis=
able-lz4, debian-13-factory--disable-lzo, debian-13-factory--disable-lzo--d=
isable-lz4--enable-comp-stub, debian-13-factory--disable-lzo--disable-manag=
ement, debian-13-factory--disable-management, debian-13-factory--enable-dev=
eloper-debug, debian-13-factory--enable-small, debian-13-factory-default, d=
ebian-13-factory-package, debian-13-static-factory-default, debian-unstable=
-cppcheck, debian-unstable-factory--disable-lz4, debian-unstable-factory--d=
isable-lzo, debian-unstable-factory--disable-lzo--disable-lz4--enable-comp-=
stub, debian-unstable-factory--disable-lzo--disable-management, debian-unst=
able-factory--disable-management, debian-unstable-factory--enable-developer=
-debug, debian-unstable-factory--enable-small, debian-unstable-factory-defa=
ult, debian-unstable-factory-package, fedora-45-arm64-factory--disable-lz4,=
 fedora-45-arm64-factory--disable-lzo, fedora-45-arm64-factory--disable-lzo=
--disable-lz4--enable-comp-stub, fedora-45-arm64-factory--disable-lzo--disa=
ble-management, fedora-45-arm64-factory--disable-management, fedora-45-arm6=
4-factory--enable-developer-debug, fedora-45-arm64-factory--enable-small, f=
edora-45-arm64-factory-default, fedora-45-factory--disable-lz4, fedora-45-f=
actory--disable-lzo, fedora-45-factory--disable-lzo--disable-lz4--enable-co=
mp-stub, fedora-45-factory--disable-lzo--disable-management, fedora-45-fact=
ory--disable-management, fedora-45-factory--enable-developer-debug, fedora-=
45-factory--enable-small, fedora-45-factory-default, macos-m1-cmake, macos-=
m1-factory--disable-lz4, macos-m1-factory--disable-lzo, macos-m1-factory--d=
isable-lzo--disable-lz4--enable-comp-stub, macos-m1-factory--disable-lzo--d=
isable-management, macos-m1-factory--disable-management, macos-m1-factory--=
enable-developer-debug, macos-m1-factory--enable-small, macos-m1-factory--w=
ith-crypto-librarymbedtls, macos-m1-factory-default, opensuse-leap-16-facto=
ry--disable-lz4, opensuse-leap-16-factory--disable-lzo, opensuse-leap-16-fa=
ctory--disable-lzo--disable-lz4--enable-comp-stub, opensuse-leap-16-factory=
--disable-lzo--disable-management, opensuse-leap-16-factory--disable-manage=
ment, opensuse-leap-16-factory--enable-developer-debug, opensuse-leap-16-fa=
ctory--enable-small, opensuse-leap-16-factory-default, t-server-factory-tse=
rver, ubuntu-2204-factory--disable-lz4, ubuntu-2204-factory--disable-lzo, u=
buntu-2204-factory--disable-lzo--disable-lz4--enable-comp-stub, ubuntu-2204=
-factory--disable-lzo--disable-management, ubuntu-2204-factory--disable-man=
agement, ubuntu-2204-factory--enable-developer-debug, ubuntu-2204-factory--=
enable-small, ubuntu-2204-factory-default, ubuntu-2204-factory-package, ubu=
ntu-2404-android, ubuntu-2404-arm64-factory--disable-lz4, ubuntu-2404-arm64=
-factory--disable-lzo, ubuntu-2404-arm64-factory--disable-lzo--disable-lz4-=
-enable-comp-stub, ubuntu-2404-arm64-factory--disable-lzo--disable-manageme=
nt, ubuntu-2404-arm64-factory--disable-management, ubuntu-2404-arm64-factor=
y--enable-developer-debug, ubuntu-2404-arm64-factory--enable-small, ubuntu-=
2404-arm64-factory-default, ubuntu-2404-arm64-factory-package, ubuntu-2404-=
cmake, ubuntu-2404-doxygen, ubuntu-2404-factory--disable-lz4, ubuntu-2404-f=
actory--disable-lzo, ubuntu-2404-factory--disable-lzo--disable-lz4--enable-=
comp-stub, ubuntu-2404-factory--disable-lzo--disable-management, ubuntu-240=
4-factory--disable-management, ubuntu-2404-factory--enable-developer-debug,=
 ubuntu-2404-factory--enable-small, ubuntu-2404-factory-default, ubuntu-240=
4-factory-package, ubuntu-2404-mingw, ubuntu-2404-smoketest, ubuntu-2404-st=
atic-factory-default, ubuntu-2604-clang-factory--disable-lz4, ubuntu-2604-c=
lang-factory--disable-lzo, ubuntu-2604-clang-factory--disable-lzo--disable-=
lz4--enable-comp-stub, ubuntu-2604-clang-factory--disable-lzo--disable-mana=
gement, ubuntu-2604-clang-factory--disable-management, ubuntu-2604-clang-fa=
ctory--enable-developer-debug, ubuntu-2604-clang-factory--enable-small, ubu=
ntu-2604-clang-factory-default, ubuntu-2604-cmake, ubuntu-2604-factory--dis=
able-lz4, ubuntu-2604-factory--disable-lzo, ubuntu-2604-factory--disable-lz=
o--disable-lz4--enable-comp-stub, ubuntu-2604-factory--disable-lzo--disable=
-management, ubuntu-2604-factory--disable-management, ubuntu-2604-factory--=
enable-developer-debug, ubuntu-2604-factory--enable-small, ubuntu-2604-fact=
ory-default, ubuntu-2604-factory-package, ubuntu-2610-cmake, ubuntu-2610-fa=
ctory--disable-lz4, ubuntu-2610-factory--disable-lzo, ubuntu-2610-factory--=
disable-lzo--disable-lz4--enable-comp-stub, ubuntu-2610-factory--disable-lz=
o--disable-management, ubuntu-2610-factory--disable-management, ubuntu-2610=
-factory--enable-developer-debug, ubuntu-2610-factory--enable-small, ubuntu=
-2610-factory-default, ubuntu-2610-factory-package, windows-server-2025-lat=
ent-ec2-msbuild-amd64, windows-server-2025-latent-ec2-msbuild-amd64-clang, =
windows-server-2025-latent-ec2-msbuild-arm64, windows-server-2025-latent-ec=
2-msbuild-x86, windows-server-2025-latent-ec2-msbuild-x86-clang

Change sub=
ject: route: merge the FreeBSD and DragonFly IPv4 route branches
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E
-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: combinedCheckStateUpdate
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d545f0a6de5ab795a0c80447=
002f5cb54b48b32
Gerrit-Change-Number: 2151
Gerrit-PatchSet: 1
Gerrit-Owner:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--IfBNmZXnbbg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>The combined chec=
k state has been updated to <strong>SUCCESSFUL</strong> for patch set 1 of =
this <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail=
">change</a>=2E</p><p><u><strong>All checks:</strong></u><br><strong>Succes=
sful:</strong> <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:=
8010/#/builders/1/builds/5681">Code Format Check</a>, <a href=3D"http://bui=
ldbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/188/builds/5851">alp=
ine-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/226/builds/5787">alpine-factory--disable-lz=
o</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/b=
uilders/183/builds/5764">alpine-factory--disable-lzo--disable-lz4--enable-c=
omp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8=
010/#/builders/178/builds/5747">alpine-factory--disable-lzo--disable-manage=
ment</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/=
#/builders/238/builds/5729">alpine-factory--disable-management</a>, <a href=
=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/679/bu=
ilds/26">alpine-factory--enable-developer-debug</a>, <a href=3D"http://buil=
dbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/136/builds/5715">alpi=
ne-factory--enable-small</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/8/builds/5758">alpine-factory--with-crypto-=
librarymbedtls</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/235/builds/5623">alpine-factory-default</a>, <a href=
=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/141/bu=
ilds/5826">arch-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecomm=
unity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/164/builds/5768">arch-factory--d=
isable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
:8010/#/builders/38/builds/5753">arch-factory--disable-lzo--disable-lz4--en=
able-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/112/builds/5729">arch-factory--disable-lzo--disable-m=
anagement</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:=
8010/#/builders/84/builds/5714">arch-factory--disable-management</a>, <a hr=
ef=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/665/=
builds/25">arch-factory--enable-developer-debug</a>, <a href=3D"http://buil=
dbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/13/builds/5706">arch-=
factory--enable-small</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eo=
penvpn=2Ein:8010/#/builders/102/builds/5719">arch-factory--with-crypto-libr=
arymbedtls</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
:8010/#/builders/81/builds/5609">arch-factory-default</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/275/builds/5581=
">cron2-fbsd14-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommu=
nity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/270/builds/5537">cron2-fbsd14-fac=
tory--disable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenv=
pn=2Ein:8010/#/builders/277/builds/5509">cron2-fbsd14-factory--disable-lzo-=
-disable-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/273/builds/5497">cron2-fbsd14-factory=
--disable-lzo--disable-management</a>, <a href=3D"http://buildbot=2Ecommuni=
ty=2Eaws=2Eopenvpn=2Ein:8010/#/builders/278/builds/5476">cron2-fbsd14-facto=
ry--disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2E=
openvpn=2Ein:8010/#/builders/678/builds/25">cron2-fbsd14-factory--enable-de=
veloper-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/272/builds/5456">cron2-fbsd14-factory--enable-small</=
a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/buil=
ders/276/builds/5514">cron2-fbsd14-factory-default</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/610/builds/1088">c=
ron2-fbsd15-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunit=
y=2Eaws=2Eopenvpn=2Ein:8010/#/builders/606/builds/1082">cron2-fbsd15-factor=
y--disable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/614/builds/1079">cron2-fbsd15-factory--disable-lzo--d=
isable-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2Ein:8010/#/builders/615/builds/1074">cron2-fbsd15-factory--d=
isable-lzo--disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/611/builds/1072">cron2-fbsd15-factory=
--disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eop=
envpn=2Ein:8010/#/builders/677/builds/25">cron2-fbsd15-factory--enable-deve=
loper-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ei=
n:8010/#/builders/613/builds/1069">cron2-fbsd15-factory--enable-small</a>, =
<a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders=
/609/builds/1080">cron2-fbsd15-factory-default</a>, <a href=3D"http://build=
bot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/612/builds/1184">cron2=
-fbsd15-smoketest</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenv=
pn=2Ein:8010/#/builders/524/builds/2861">cron2-nbsd10-factory--disable-lz4<=
/a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/bui=
lders/518/builds/2852">cron2-nbsd10-factory--disable-lzo</a>, <a href=3D"ht=
tp://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/526/builds/2=
840">cron2-nbsd10-factory--disable-lzo--disable-lz4--enable-comp-stub</a>, =
<a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders=
/520/builds/2829">cron2-nbsd10-factory--disable-lzo--disable-management</a>=
, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builde=
rs/519/builds/2816">cron2-nbsd10-factory--disable-management</a>, <a href=
=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/668/bu=
ilds/25">cron2-nbsd10-factory--enable-developer-debug</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/523/builds/2807=
">cron2-nbsd10-factory--enable-small</a>, <a href=3D"http://buildbot=2Ecomm=
unity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/522/builds/2775">cron2-nbsd10-fa=
ctory--with-crypto-librarymbedtls</a>, <a href=3D"http://buildbot=2Ecommuni=
ty=2Eaws=2Eopenvpn=2Ein:8010/#/builders/521/builds/2699">cron2-nbsd10-facto=
ry-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
:8010/#/builders/636/builds/307">cron2-obsd-factory--disable-lz4</a>, <a hr=
ef=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/635/=
builds/305">cron2-obsd-factory--disable-lzo</a>, <a href=3D"http://buildbot=
=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/640/builds/303">cron2-obs=
d-factory--disable-lzo--disable-lz4--enable-comp-stub</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/634/builds/301"=
>cron2-obsd-factory--disable-lzo--disable-management</a>, <a href=3D"http:/=
/buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/639/builds/298">=
cron2-obsd-factory--disable-management</a>, <a href=3D"http://buildbot=2Eco=
mmunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/676/builds/25">cron2-obsd-fact=
ory--enable-developer-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Ea=
ws=2Eopenvpn=2Ein:8010/#/builders/633/builds/294">cron2-obsd-factory--enabl=
e-small</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:80=
10/#/builders/638/builds/271">cron2-obsd-factory--with-crypto-librarymbedtl=
s</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/b=
uilders/637/builds/263">cron2-obsd-factory-default</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/285/builds/5507">c=
ron2-obsd75-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunit=
y=2Eaws=2Eopenvpn=2Ein:8010/#/builders/279/builds/5470">cron2-obsd75-factor=
y--disable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/284/builds/5440">cron2-obsd75-factory--disable-lzo--d=
isable-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2Ein:8010/#/builders/287/builds/5409">cron2-obsd75-factory--d=
isable-lzo--disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/283/builds/5362">cron2-obsd75-factory=
--disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eop=
envpn=2Ein:8010/#/builders/661/builds/25">cron2-obsd75-factory--enable-deve=
loper-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ei=
n:8010/#/builders/282/builds/5333">cron2-obsd75-factory--enable-small</a>, =
<a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders=
/280/builds/5277">cron2-obsd75-factory-default</a>, <a href=3D"http://build=
bot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/293/builds/5531">cron2=
-oi2024-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2Ein:8010/#/builders/292/builds/5480">cron2-oi2024-factory--d=
isable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
:8010/#/builders/291/builds/5459">cron2-oi2024-factory--disable-lzo--disabl=
e-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/289/builds/5440">cron2-oi2024-factory--disa=
ble-lzo--disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Ea=
ws=2Eopenvpn=2Ein:8010/#/builders/290/builds/5407">cron2-oi2024-factory--di=
sable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvp=
n=2Ein:8010/#/builders/667/builds/25">cron2-oi2024-factory--enable-develope=
r-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:80=
10/#/builders/296/builds/5380">cron2-oi2024-factory--enable-small</a>, <a h=
ref=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/294=
/builds/5319">cron2-oi2024-factory-default</a>, <a href=3D"http://buildbot=
=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/242/builds/5823">debian-1=
2-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2E=
openvpn=2Ein:8010/#/builders/54/builds/5766">debian-12-factory--disable-lzo=
</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/bu=
ilders/196/builds/5737">debian-12-factory--disable-lzo--disable-lz4--enable=
-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
:8010/#/builders/55/builds/5716">debian-12-factory--disable-lzo--disable-ma=
nagement</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8=
010/#/builders/163/builds/5707">debian-12-factory--disable-management</a>, =
<a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders=
/662/builds/25">debian-12-factory--enable-developer-debug</a>, <a href=3D"h=
ttp://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/4/builds/57=
10">debian-12-factory--enable-small</a>, <a href=3D"http://buildbot=2Ecommu=
nity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/97/builds/5756">debian-12-factory=
-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8=
010/#/builders/63/builds/5674">debian-12-factory-package</a>, <a href=3D"ht=
tp://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/328/builds/5=
064">debian-12-openvpn-legacy-factory-default</a>, <a href=3D"http://buildb=
ot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/438/builds/3785">debian=
-13-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/436/builds/3733">debian-13-factory--disable=
-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/=
#/builders/441/builds/3713">debian-13-factory--disable-lzo--disable-lz4--en=
able-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/440/builds/3697">debian-13-factory--disable-lzo--disa=
ble-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/437/builds/3686">debian-13-factory--disable-managemen=
t</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/b=
uilders/681/builds/25">debian-13-factory--enable-developer-debug</a>, <a hr=
ef=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/435/=
builds/3680">debian-13-factory--enable-small</a>, <a href=3D"http://buildbo=
t=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/447/builds/3624">debian-=
13-factory-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopen=
vpn=2Ein:8010/#/builders/445/builds/3666">debian-13-factory-package</a>, <a=
 href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/4=
49/builds/3602">debian-13-static-factory-default</a>, <a href=3D"http://bui=
ldbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/630/builds/416">debi=
an-unstable-cppcheck</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eop=
envpn=2Ein:8010/#/builders/28/builds/5807">debian-unstable-factory--disable=
-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/=
#/builders/104/builds/5749">debian-unstable-factory--disable-lzo</a>, <a hr=
ef=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/80/b=
uilds/5714">debian-unstable-factory--disable-lzo--disable-lz4--enable-comp-=
stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/=
#/builders/36/builds/5699">debian-unstable-factory--disable-lzo--disable-ma=
nagement</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8=
010/#/builders/75/builds/5681">debian-unstable-factory--disable-management<=
/a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/bui=
lders/666/builds/25">debian-unstable-factory--enable-developer-debug</a>, <=
a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/=
76/builds/5662">debian-unstable-factory--enable-small</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/216/builds/5636=
">debian-unstable-factory-default</a>, <a href=3D"http://buildbot=2Ecommuni=
ty=2Eaws=2Eopenvpn=2Ein:8010/#/builders/37/builds/5651">debian-unstable-fac=
tory-package</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2E=
in:8010/#/builders/669/builds/27">fedora-45-arm64-factory--disable-lz4</a>,=
 <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builder=
s/673/builds/27">fedora-45-arm64-factory--disable-lzo</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/659/builds/27">=
fedora-45-arm64-factory--disable-lzo--disable-lz4--enable-comp-stub</a>, <a=
 href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/6=
54/builds/27">fedora-45-arm64-factory--disable-lzo--disable-management</a>,=
 <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builder=
s/675/builds/26">fedora-45-arm64-factory--disable-management</a>, <a href=
=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/664/bu=
ilds/24">fedora-45-arm64-factory--enable-developer-debug</a>, <a href=3D"ht=
tp://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/652/builds/2=
6">fedora-45-arm64-factory--enable-small</a>, <a href=3D"http://buildbot=2E=
community=2Eaws=2Eopenvpn=2Ein:8010/#/builders/656/builds/28">fedora-45-arm=
64-factory-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopen=
vpn=2Ein:8010/#/builders/648/builds/39">fedora-45-factory--disable-lz4</a>,=
 <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builder=
s/644/builds/38">fedora-45-factory--disable-lzo</a>, <a href=3D"http://buil=
dbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/651/builds/36">fedora=
-45-factory--disable-lzo--disable-lz4--enable-comp-stub</a>, <a href=3D"htt=
p://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/641/builds/36=
">fedora-45-factory--disable-lzo--disable-management</a>, <a href=3D"http:/=
/buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/650/builds/36">f=
edora-45-factory--disable-management</a>, <a href=3D"http://buildbot=2Ecomm=
unity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/663/builds/25">fedora-45-factory=
--enable-developer-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/643/builds/36">fedora-45-factory--enable-sm=
all</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#=
/builders/645/builds/39">fedora-45-factory-default</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/365/builds/5135">m=
acos-m1-cmake</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/190/builds/5786">macos-m1-factory--disable-lz4</a>, <=
a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/=
179/builds/5752">macos-m1-factory--disable-lzo</a>, <a href=3D"http://build=
bot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/90/builds/5730">macos-=
m1-factory--disable-lzo--disable-lz4--enable-comp-stub</a>, <a href=3D"http=
://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/6/builds/5733"=
>macos-m1-factory--disable-lzo--disable-management</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/160/builds/5697">m=
acos-m1-factory--disable-management</a>, <a href=3D"http://buildbot=2Ecommu=
nity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/660/builds/25">macos-m1-factory--=
enable-developer-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2E=
openvpn=2Ein:8010/#/builders/191/builds/5683">macos-m1-factory--enable-smal=
l</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/b=
uilders/200/builds/5774">macos-m1-factory--with-crypto-librarymbedtls</a>, =
<a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders=
/131/builds/5674">macos-m1-factory-default</a>, <a href=3D"http://buildbot=
=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/507/builds/3149">opensuse=
-leap-16-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/496/builds/3113">opensuse-leap-16-fac=
tory--disable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenv=
pn=2Ein:8010/#/builders/514/builds/3098">opensuse-leap-16-factory--disable-=
lzo--disable-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommun=
ity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/516/builds/3096">opensuse-leap-16-=
factory--disable-lzo--disable-management</a>, <a href=3D"http://buildbot=2E=
community=2Eaws=2Eopenvpn=2Ein:8010/#/builders/506/builds/3088">opensuse-le=
ap-16-factory--disable-management</a>, <a href=3D"http://buildbot=2Ecommuni=
ty=2Eaws=2Eopenvpn=2Ein:8010/#/builders/671/builds/25">opensuse-leap-16-fac=
tory--enable-developer-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2Ein:8010/#/builders/501/builds/3083">opensuse-leap-16-factor=
y--enable-small</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/492/builds/2991">opensuse-leap-16-factory-default</a>=
, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builde=
rs/592/builds/1593">t-server-factory-tserver</a>, <a href=3D"http://buildbo=
t=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/129/builds/5806">ubuntu-=
2204-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/151/builds/5737">ubuntu-2204-factory--disab=
le-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:801=
0/#/builders/130/builds/5709">ubuntu-2204-factory--disable-lzo--disable-lz4=
--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopen=
vpn=2Ein:8010/#/builders/230/builds/5697">ubuntu-2204-factory--disable-lzo-=
-disable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eope=
nvpn=2Ein:8010/#/builders/12/builds/5682">ubuntu-2204-factory--disable-mana=
gement</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:801=
0/#/builders/653/builds/25">ubuntu-2204-factory--enable-developer-debug</a>=
, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builde=
rs/194/builds/5659">ubuntu-2204-factory--enable-small</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/232/builds/5737=
">ubuntu-2204-factory-default</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/202/builds/5651">ubuntu-2204-factory-=
package</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:80=
10/#/builders/367/builds/4357">ubuntu-2404-android</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/587/builds/1874">u=
buntu-2404-arm64-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecom=
munity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/565/builds/1860">ubuntu-2404-ar=
m64-factory--disable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/568/builds/1853">ubuntu-2404-arm64-factory-=
-disable-lzo--disable-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=
=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/570/builds/1854">ubuntu-2=
404-arm64-factory--disable-lzo--disable-management</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/588/builds/1843">u=
buntu-2404-arm64-factory--disable-management</a>, <a href=3D"http://buildbo=
t=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/682/builds/24">ubuntu-24=
04-arm64-factory--enable-developer-debug</a>, <a href=3D"http://buildbot=2E=
community=2Eaws=2Eopenvpn=2Ein:8010/#/builders/571/builds/1843">ubuntu-2404=
-arm64-factory--enable-small</a>, <a href=3D"http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2Ein:8010/#/builders/569/builds/1934">ubuntu-2404-arm64-facto=
ry-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
:8010/#/builders/583/builds/1843">ubuntu-2404-arm64-factory-package</a>, <a=
 href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/3=
64/builds/5030">ubuntu-2404-cmake</a>, <a href=3D"http://buildbot=2Ecommuni=
ty=2Eaws=2Eopenvpn=2Ein:8010/#/builders/412/builds/3824">ubuntu-2404-doxyge=
n</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/b=
uilders/253/builds/5472">ubuntu-2404-factory--disable-lz4</a>, <a href=3D"h=
ttp://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/260/builds/=
5438">ubuntu-2404-factory--disable-lzo</a>, <a href=3D"http://buildbot=2Eco=
mmunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/256/builds/5431">ubuntu-2404-f=
actory--disable-lzo--disable-lz4--enable-comp-stub</a>, <a href=3D"http://b=
uildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/258/builds/5423">u=
buntu-2404-factory--disable-lzo--disable-management</a>, <a href=3D"http://=
buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/268/builds/5408">=
ubuntu-2404-factory--disable-management</a>, <a href=3D"http://buildbot=2Ec=
ommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/655/builds/25">ubuntu-2404-fa=
ctory--enable-developer-debug</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/269/builds/5393">ubuntu-2404-factory-=
-enable-small</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/246/builds/5392">ubuntu-2404-factory-default</a>, <a =
href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/25=
4/builds/5373">ubuntu-2404-factory-package</a>, <a href=3D"http://buildbot=
=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/363/builds/4866">ubuntu-2=
404-mingw</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:=
8010/#/builders/582/builds/2135">ubuntu-2404-smoketest</a>, <a href=3D"http=
://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/451/builds/369=
9">ubuntu-2404-static-factory-default</a>, <a href=3D"http://buildbot=2Ecom=
munity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/605/builds/1492">ubuntu-2604-cl=
ang-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/604/builds/1489">ubuntu-2604-clang-factory-=
-disable-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2E=
in:8010/#/builders/600/builds/1486">ubuntu-2604-clang-factory--disable-lzo-=
-disable-lz4--enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=
=2Eaws=2Eopenvpn=2Ein:8010/#/builders/598/builds/1485">ubuntu-2604-clang-fa=
ctory--disable-lzo--disable-management</a>, <a href=3D"http://buildbot=2Eco=
mmunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/593/builds/1483">ubuntu-2604-c=
lang-factory--disable-management</a>, <a href=3D"http://buildbot=2Ecommunit=
y=2Eaws=2Eopenvpn=2Ein:8010/#/builders/674/builds/25">ubuntu-2604-clang-fac=
tory--enable-developer-debug</a>, <a href=3D"http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2Ein:8010/#/builders/594/builds/1481">ubuntu-2604-clang-facto=
ry--enable-small</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvp=
n=2Ein:8010/#/builders/597/builds/1443">ubuntu-2604-clang-factory-default</=
a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/buil=
ders/551/builds/2250">ubuntu-2604-cmake</a>, <a href=3D"http://buildbot=2Ec=
ommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/548/builds/2211">ubuntu-2604-=
factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eop=
envpn=2Ein:8010/#/builders/537/builds/2205">ubuntu-2604-factory--disable-lz=
o</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/b=
uilders/547/builds/2204">ubuntu-2604-factory--disable-lzo--disable-lz4--ena=
ble-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=
=2Ein:8010/#/builders/543/builds/2198">ubuntu-2604-factory--disable-lzo--di=
sable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvp=
n=2Ein:8010/#/builders/542/builds/2194">ubuntu-2604-factory--disable-manage=
ment</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/=
#/builders/680/builds/25">ubuntu-2604-factory--enable-developer-debug</a>, =
<a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders=
/550/builds/2185">ubuntu-2604-factory--enable-small</a>, <a href=3D"http://=
buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/549/builds/2130">=
ubuntu-2604-factory-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Ea=
ws=2Eopenvpn=2Ein:8010/#/builders/538/builds/2170">ubuntu-2604-factory-pack=
age</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#=
/builders/631/builds/473">ubuntu-2610-cmake</a>, <a href=3D"http://buildbot=
=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/624/builds/467">ubuntu-26=
10-factory--disable-lz4</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/620/builds/461">ubuntu-2610-factory--disabl=
e-lzo</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010=
/#/builders/621/builds/461">ubuntu-2610-factory--disable-lzo--disable-lz4--=
enable-comp-stub</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvp=
n=2Ein:8010/#/builders/618/builds/457">ubuntu-2610-factory--disable-lzo--di=
sable-management</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvp=
n=2Ein:8010/#/builders/629/builds/456">ubuntu-2610-factory--disable-managem=
ent</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#=
/builders/657/builds/25">ubuntu-2610-factory--enable-developer-debug</a>, <=
a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/=
622/builds/458">ubuntu-2610-factory--enable-small</a>, <a href=3D"http://bu=
ildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/625/builds/456">ubu=
ntu-2610-factory-default</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=
=2Eopenvpn=2Ein:8010/#/builders/628/builds/452">ubuntu-2610-factory-package=
</a>, <a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/bu=
ilders/398/builds/4196">windows-server-2025-latent-ec2-msbuild-amd64</a>, <=
a href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/=
396/builds/3910">windows-server-2025-latent-ec2-msbuild-amd64-clang</a>, <a=
 href=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/3=
95/builds/4018">windows-server-2025-latent-ec2-msbuild-arm64</a>, <a href=
=3D"http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/397/bu=
ilds/3983">windows-server-2025-latent-ec2-msbuild-x86</a>, <a href=3D"http:=
//buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein:8010/#/builders/399/builds/3814=
">windows-server-2025-latent-ec2-msbuild-x86-clang</a><br></p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">View Change</=
a></p><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2151?usp=3Demail">change 2151</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2151?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
combinedCheckStateUpdate </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I1d545f0a6de5ab795a0c8044700=
2f5cb54b48b32 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 215=
1 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--IfBNmZXnbbg=--


--===============0553028239435076098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0553028239435076098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0553028239435076098==--

