Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E5606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kOkPoxME;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dA6yYp6+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NCeFxH2B;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WOax16zf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KISIw9ZgSYVNmEroZILiB5STq2J0X2h026U833TSWTg=; b=kOkPoxMEVOY6E2pEwi1TEjSzT9
	oGVhD9lvLnFj8VRcmQBQZHwi2jeJ0YAXZF/h8e7OYctoSywg81SIPerzGxHDny8N1UhJDHBQKasPU
	acWvo7VUBWde5dL8RQN4bQmtKh5AR7ogDzaVDEgd+KQHq94UT1nPFVpzQPNwRV6VNVUM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX4pr-000000003gt-2jrK;
	Fri, 27 Nov 2026 22:54:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX4po-000000003gA-2ozM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:54:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z5MErMtAerhcj9K+GcINbwu0MeT/Wl+xCECZ8uadDEs=; b=dA6yYp6+5q5TLiJBV870Ng/bP6
 RjYSkV+J+SPsa1pfxBk1N4HLargus1HATUs0t2Y2pPIPGzrdLJFt8JnnbZ8TA35VYT+qIgtXU7cxx
 w5RvLSmqozL9xmN6TFTU3kOEZEd3oTT95KHtew2MHkVyND17bXt+uOtcb/BGFylhFKcI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z5MErMtAerhcj9K+GcINbwu0MeT/Wl+xCECZ8uadDEs=; b=NCeFxH2BJYbzSXAq9yM2qF+a3r
 uUFql6qeaLchR1vSB4FB/pXLHg3IPxrDMe4eMi+Wfnj+qcx/KSLwHcpMAPyWuK7Wc+zg1SiygVk6N
 MHhzwOl0uogZUKOE8jURwydb9QxkJLRW7uJj5A0jx3yVirMn71P9q0dIc8m6IGI7C/Hs=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX4pn-000000004tn-2O0O for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:54:28 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso45298105e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 14:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795820061; x=1796424861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5MErMtAerhcj9K+GcINbwu0MeT/Wl+xCECZ8uadDEs=;
 b=WOax16zfNAg7q5cScBhyj9yptL2q4ygBfodREP5uxoLX3Kyk1A0ck2j6A+8Xuj4HlN
 XzWI+5txyNWQchRaUMiEl5VrBXZYAWMGUFwLpPH8EZR+n5XEDfLp4p03EIqUI+mmQ2+B
 WJDKvJlbZO8ZAjIqQY6tyebqQ5dyDm4BCFw5AUOp/Zo4C5MnYPMu9R8srmAhfiPpuChc
 umeNyB7WUUr0pAd59KoQamzbgAC8hfl56FbflCR/6SItYC3RjA5NMo2AU1BedugPFYCH
 esRslwmSt1YdytA3UO4MDRedo/RJQcOJFz9l63nRFcsZxMaXQZO2yCchMdoqUbvrQtjo
 iKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795820061; x=1796424861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z5MErMtAerhcj9K+GcINbwu0MeT/Wl+xCECZ8uadDEs=;
 b=f4mRn8lOhBTs+2A8iAG9tCCLY4hye47RUjId81w6ZzSpolc5hZHX7CqRN5JbpO2TI0
 GVaSCTIZyQCM5/8hA95ZZGLr8fI1nagX1GWJEYp8C51bDgMqENiaA/u5eWXIyRB0UOC4
 L+z0W55xikPwdK+KaMzjE8xuegQtYKCj71SChOWvMo3a+JixJRJ4uBSDxa+zHzvlahyl
 L2hfYQyl7MJAcn6RsQ+6CzVqV9N+EnXN2f9dg6C3PzFfiCbmC7DRlSBDjmzfJavxX7bd
 lyERhisHi56LssqviA6LW1dAv4sX7CCi9S7O+3mwwPYRJ1AU2cb18wjAVDTjUs2e/DgO
 bqDw==
X-Forwarded-Encrypted: i=1;
 AL+hErGyWL94IOrHPbM72U3WmbL7cDeE3JcKF4rsElAsUhLmAw7Tpeu904V98Mm+9CZBqB1jyYelsLChfO3aYr+j@lists.sourceforge.net
X-Gm-Message-State: APuU4Z91McCYF0oS2WzShWt2nmExSj3LNyPq7lt7f7AXoEdN3UdY1g9G
 VMnxPjfGqZ8U7DsSnqWqApfvxbC4fodQRgxoMLfn1kk7laEVFYsIdtyNzwBqLgs6YlZ8cEHjuNT
 kv3OKPY62naCEZOgPy/d8HU7cYX42EnxXqhMT0lBCAhJ+RArWLKVbEPv8PWq3FWyDrvzA
X-Gm-Gg: AZFdTZff3fJSnTcFdDRqxjhk4MASDnYrdl8r1E410WLCF6WGQxhKHFjPHavVNvTYu1z
 vXZ+7/M9kASpZzg+zK4UeW+1rxSeh6q/Gof/mUmVqgamObouHIC+/Uh+AcXangw/gQf6ZP/Gqv7
 q93T1UBtgW0M/w8VZcBFoKZgMMYhvX1zC4BBPt9jL/sk85v2ZsrQT+cKces5pREjdiTSVxFHnuZ
 oFas6tljXaORPOkBG5Yk3fock8k2lwRoXktsVuaPgfDeTJv8Xhh37GDManSjbq8FRodEfV2Ncos
 qFkcn3IuaQQ536D40BYWEy6BdyR8bKrHr/eJSmJ6UlpdfN1w5ApDZ9Yi/+ORlwSJS6JRp2zqc25
 kX8xt5JkbMDfd03dO/3oDjJii8zDFABrN8VTJRuCGphTx8wbnyhFcnLnNjBzwrB8I47j6DIpZaz
 fBaEr4/m93HuODGf1mvjYFIVDCDMpwLBQhfPbmAfuWzLES7rh6L7QcSIhGF9R9I4P7unCMa8r7A
 ovPhBMn00IxT9xEc7qVobrFiXNLns3vKqY1PSYmto8OmdsmLvCUx15dcV4+M7OVGUKTZHW0lhQn
 mIoBI8p3OePK4NkmkPMGFZ9we/ZvH9DCV4dsfE48HOQ3Ov9O65I4q2vKpgLAX+T4T7EXwQncHii
 MDpECYWNMQAwKsdHIyQLLuJobXMz6xNpMRqoMZNSmgdmAYbTlW0uDQw7R28LMvT/oUo2xpaj6JU
 lwu4i6F1WhFQcVo08a
X-Received: by 2002:a05:600c:674b:b0:4b2:61e5:b2f4 with SMTP id
 5b1f17b1804b1-4bb8880f25cmr498950005e9.11.1795820060937; 
 Fri, 27 Nov 2026 14:54:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm599525245e9.0.2026.11.27.14.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:54:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 22:54:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
X-Gerrit-Change-Number: 2347
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2347?usp=email>
X-Gerrit-Commit: 88d49b64f6f56f6c4a4057249b69a02b9a2c4a27
In-Reply-To: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
References: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkkyNDc0NzRiNDNhYzdhMjJkMTZhMTUwYTg1NmFlNTY0MzY1N2VhY2RiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <34d750b99b38ba7fc169709dca2e107fdde802b8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xX4pn-000000004tn-2O0O
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns-scripts: don't
 re-evaluate collected search domains
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com,
 heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Deri Haerudi <abcderyscreenprinting@gmail.com>
Content-Type: multipart/mixed; boundary="===============6386793569831676465=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6386793569831676465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dmNkZa6PhhM="; charset=UTF-8

--dmNkZa6PhhM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2347?usp=3Demail )

Change subject: dns-scripts: don't re-evalu=
ate collected search domains
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dns-scripts: don't re-evaluate collected search domains

$=
domains was expanded before eval, so the domains collected so far
were pars=
ed as shell code again=2E Escape it like the indexed variable=2E

Change-Id=
: I247474b43ac7a22d16a150a856ae5643657eacdb
Signed-off-by: Heiko Hund <heik=
o@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

Reviewed-by: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347
Message-Id: <20261126102421=
=2E29800-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg42061=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M distro/dns-scripts/haikuos_file-dns=
-updown=2Esh
M distro/dns-scripts/resolvconf_file-dns-updown=2Esh
M distro/=
dns-scripts/systemd-dns-updown=2Esh
3 files changed, 3 insertions(+), 3 del=
etions(-)




diff --git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh =
b/distro/dns-scripts/haikuos_file-dns-updown=2Esh
index e19b2b7=2E=2E04e9e2=
6 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown=2Esh
+++ b/distro=
/dns-scripts/haikuos_file-dns-updown=2Esh
@@ -75,7 +75,7 @@
 
     test -z =
"$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-            e=
val domains=3D\"$domains\$dns_search_domain_${i} \" || break
+            e=
val domains=3D\"\$domains\$dns_search_domain_${i} \" || break
         done=

         text=3D"${text}search $domains\n"
     }
diff --git a/distro/dns-=
scripts/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolvconf_fil=
e-dns-updown=2Esh
index 8d23ed6=2E=2E78bf9d3 100644
--- a/distro/dns-script=
s/resolvconf_file-dns-updown=2Esh
+++ b/distro/dns-scripts/resolvconf_file-=
dns-updown=2Esh
@@ -75,7 +75,7 @@
 
     test -z "$dns_search_domain_1" || =
{
         for i in $(seq 1 6); do
-            eval domains=3D\"$domains\$=
dns_search_domain_${i} \" || break
+            eval domains=3D\"\$domains\=
$dns_search_domain_${i} \" || break
         done
         text=3D"${text}s=
earch $domains\n"
     }
diff --git a/distro/dns-scripts/systemd-dns-updown=
=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh
index 553056b=2E=2E3bdaa=
4b 100644
--- a/distro/dns-scripts/systemd-dns-updown=2Esh
+++ b/distro/dns=
-scripts/systemd-dns-updown=2Esh
@@ -227,7 +227,7 @@
 
         test -z "$d=
ns_search_domain_1" || {
             for i in $(seq 1 6); do
-            =
    eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+        =
        eval domains=3D\"\$domains\$dns_search_domain_${i} \" || break
    =
         done
             text=3D"${text}search $domains\n"
         }

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I247474b43ac7a22d16a150=
a856ae5643657eacdb
Gerrit-Change-Number: 2347
Gerrit-PatchSet: 3
Gerrit-Own=
er: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenp=
rinting@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--dmNkZa6PhhM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2347?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">dns-scripts: don&#39;t re-evaluate=
 collected search domains<br><br>$domains was expanded before eval, so the =
domains collected so far<br>were parsed as shell code again=2E Escape it li=
ke the indexed variable=2E<br><br>Change-Id: I247474b43ac7a22d16a150a856ae5=
643657eacdb<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Reviewed-b=
y: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347<br>Message-Id: &lt;2026112610=
2421=2E29800-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42061=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M distro/dns=
-scripts/haikuos_file-dns-updown=2Esh<br>M distro/dns-scripts/resolvconf_fi=
le-dns-updown=2Esh<br>M distro/dns-scripts/systemd-dns-updown=2Esh<br>3 fil=
es changed, 3 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/d=
istro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/haikuos=
_file-dns-updown=2Esh</span><br><span>index e19b2b7=2E=2E04e9e26 100644</sp=
an><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=2Esh</span><b=
r><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh</span><br><sp=
an>@@ -75,7 +75,7 @@</span><br><span> </span><br><span>     test -z &quot;$=
dns_search_domain_1&quot; || {</span><br><span>         for i in $(seq 1 6)=
; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            eval =
domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            eval domains=3D\=
&quot;\$domains\$dns_search_domain_${i} \&quot; || break</span><br><span>  =
       done</span><br><span>         text=3D&quot;${text}search $domains\n&=
quot;</span><br><span>     }</span><br><span>diff --git a/distro/dns-script=
s/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolvconf_file-dns-=
updown=2Esh</span><br><span>index 8d23ed6=2E=2E78bf9d3 100644</span><br><sp=
an>--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br><span=
>+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br><span>@=
@ -75,7 +75,7 @@</span><br><span> </span><br><span>     test -z &quot;$dns_=
search_domain_1&quot; || {</span><br><span>         for i in $(seq 1 6); do=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            eval doma=
ins=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            eval domains=3D\&quo=
t;\$domains\$dns_search_domain_${i} \&quot; || break</span><br><span>      =
   done</span><br><span>         text=3D&quot;${text}search $domains\n&quot=
;</span><br><span>     }</span><br><span>diff --git a/distro/dns-scripts/sy=
stemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh</span><b=
r><span>index 553056b=2E=2E3bdaa4b 100644</span><br><span>--- a/distro/dns-=
scripts/systemd-dns-updown=2Esh</span><br><span>+++ b/distro/dns-scripts/sy=
stemd-dns-updown=2Esh</span><br><span>@@ -227,7 +227,7 @@</span><br><span> =
</span><br><span>         test -z &quot;$dns_search_domain_1&quot; || {</sp=
an><br><span>             for i in $(seq 1 6); do</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                eval domains=3D\&quot;$domains\=
$dns_search_domain_${i} \&quot; || break</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                eval domains=3D\&quot;\$domains\$dns_s=
earch_domain_${i} \&quot; || break</span><br><span>             done</span>=
<br><span>             text=3D&quot;${text}search $domains\n&quot;</span><b=
r><span>         }</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">change 2347</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I247474b43ac7a22d1=
6a150a856ae5643657eacdb </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2347 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigent=
lich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--dmNkZa6PhhM=--


--===============6386793569831676465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6386793569831676465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6386793569831676465==--

