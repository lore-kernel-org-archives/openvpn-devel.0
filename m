Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E60C982EE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWCK63YtnrwAalf15agOPzx7jvuqEpg/mNXP3/lhBTA=; b=D1I3fCRnETbAF6HlOx4Pnq5AHJ
	7Gabnoc0D0niFm6fTR37QjWcFiTKelOUL3cfvV2Hvb84rwV82MHnsq3gE8NMqxs7ykXahPTjOpMPr
	ApPMJwUmuXbrnr0QSk4DGSpmju1QNN+RkhBE+i/vKh3pnTDN5byFseb5YjWet1mE7CXA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8k5M-00063X-Sp;
	Mon, 21 Sep 2026 19:53:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8k55-00061r-6w
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iUUMGWyzlif46Qhq3wW/hnVIFsABsM5iUg6piFGDeIA=; b=Y+1gp8mcROH2b3MJAq+gbJwhwf
 cXfA1n66FJBz8X1lkJJYwBdTbq7rHhbvPd6SaTqJleXBrPt7dwFofxkJEZ2hehMjXuMGOgbJj4+2A
 tZz1kGBrwbIuIKlGtzb4YCRH09i0LBwAB2J5RyHwWOjlaUQIg2zl+CL3L38sZ2yqnSes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iUUMGWyzlif46Qhq3wW/hnVIFsABsM5iUg6piFGDeIA=; b=Q
 xNz7QdenKtUfXvuPa2terQ3wbXWY/9hCUTSwpA3Xa6J5XLz5cYdco/OB1g3m4S0Vezmj+c4dd3ZCA
 pnTXViwwDSSuj43oJrgoW+DFOhebfe6SpkKmf6OSW0A+don5ObTfs5tj+IFEjMNF8cMrvceLzrb58
 SyIc8Lf4jMNvMiR4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8k55-0003ub-1n for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:53:39 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so19542375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790020412; x=1790625212; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iUUMGWyzlif46Qhq3wW/hnVIFsABsM5iUg6piFGDeIA=;
 b=TqfEC55uam3Z3+Rk9hkEX1WUElFutUxyvDePrTkfjReeuw7h+SuZNdNpk9I3NAamgw
 qe4DrJr1KbS1nvsSEK+Mqm74CVUmMB+9WxI5cqslKMsSe/JGPX/D0k8+0UZIDhh+BOl6
 vN1S75/6DWf7QVfiIXZDVN4IGLPJ6MUbk2iSpujLqt8KCDoUsaan2mPpL+8gfbCBehpT
 7kph0bdyYcqHQuttHG6DLNkJFjS9upTpXAn7EmK98FegtvX6+ijdsMTa9pc7YqB2gy/s
 UHqotRVE4S8seLgm4fjEyMX7MuJIl7WBMbpc1J9G23YOl0Xf1TSA1x5POkvFn+J7LHUA
 evtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790020412; x=1790625212;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iUUMGWyzlif46Qhq3wW/hnVIFsABsM5iUg6piFGDeIA=;
 b=Rpd5VBiEj5yrzQTlMZAMuit54QrmQJ2Z0HDRy+i+uqCfHjFHhTJoEzUycGt285cS//
 TtaJqqFAhBSCbAKjIGpXHqwexnz3G+Kfth6rrXxOa9BSD+2LpVyAD8yFOPArmGlMeBxQ
 pOdNfPYP1ficoT4iuwBUzBS1+YRxesM9pkF2gBFDik5uZjrFzimx9WTdTjalqU7ypC0A
 2+ddBPT7hInbkSGVn1033tVz4GkuNDQvrYOia2SIY8Rh55jJjeUjoIpN9xfIqIQ1XZ9z
 /zw8MPAWeAFyLnZ+OjSl4ypoiC9MspTQuHOOcud4fHqrfUTHStaa8PgQfeJgPAbq+kfQ
 mkRQ==
X-Gm-Message-State: AFuF++nmVz0Vf50cwZWe6yjmB2F7IvGdZ1x5h6GPTZpAUytCcVdtCcj4
 PJxOwX5NzrH6M3slUEI2vS8hTUJqScm8rC/jYagBgD5GZN4aisvVG53BGS8ggV+Dpv+OAzQzcnR
 VNhcv9aeGd1TCtOuP6AjAtAbOWIkm3PKA0oKB6zAgw1yhDFzdagL3entmIZplvPZjXYdP
X-Gm-Gg: AYBFou1ksqdfUlsIwTmQX/B7NThWFVj2tPJdhn4144Uq/njkFq5PlaZE+eG8HodyjLD
 0wNOb111YJAVf1Z2nte++QFJem0cwiY2vyVMZ6wS0q5CyYWOe79Ot7pzjzULjW4g1skXzUi42p6
 8FndHw+GcslB20y1rSS0eG/trIPlVj3eUQtWiEjsrbbO9QWfejs3+8+vSB0DTTxvooExlz7QVNz
 J/PI2haVYEr/3oX50HYlfa/rHXD3U0iZVBzzommdWI6mf8yV9zNnk1OMTaCDQOXf5HyGk0w1yL7
 0kt6+RBMAe297x8wp6IJKYHvPVX2RcIVUirG8cv2H67VGO4YS9lzF90sU9H3k8v/kQ3qvIaser/
 sXce1PxJEetojFVEK1usPzgbNzYnWjt0ZvbO2xBwh2VJeuYlqpYrxsRAcQ1eP4jIz8ze5cCnQAh
 5BrFkCBNB2u/gHqnIoXNrExEJ4h0/7wd4RsRqmqReatjHFcRDggcUwO4lfnGdj4LMwsdAs+3to4
 KuWABa31Q06CL5AOqgS/iAEI+rCyTRlDOP2nUJYYdwR39XkQtSV5l7YWHliLeyXsDQLaIe3OTVm
 8wagV98VOOzM+iVkdlOLsPyneb2XBqVuOgp7ZTuLokjsz0xBUSxAl67un8Fi9w==
X-Received: by 2002:a05:600c:5250:b0:49f:bd0d:59f5 with SMTP id
 5b1f17b1804b1-49fc5746338mr176459785e9.18.1790020412342; 
 Mon, 21 Sep 2026 12:53:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc6ca43edsm315325195e9.0.2026.09.21.12.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:53:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 19:53:29 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
X-Gerrit-Change-Number: 1921
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1921?usp=email>
X-Gerrit-Commit: 9e378318a0962a4cfad71af331ee4b193f45fef7
In-Reply-To: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
References: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkljYWE3NmEyMGVmNDFlMjYwNDRmYTY4NGQ1Mjk3ZjQwZDhkNWRkYzhkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <045c0d57a50da0076b7aaaa937dfe0ad31364451-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8k55-0003ub-1n
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Explicitly set
 PKG_CONFIG_PATH in Android build
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1798478464451093117=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1798478464451093117==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cniHe2ARhLA="; charset=UTF-8

--cniHe2ARhLA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: GHA: Explicitly set PKG_CONFIG_PATH in Android=
 build
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA:=
 Explicitly set PKG_CONFIG_PATH in Android build

Otherwise CMake could use=
 the wrong pkg-config file=2E
It was still using the correct libraries due =
to
architecture config=2E However, in Ubuntu 26=2E04 lz4 has
an additional =
xxhash dependency and this dependency
was wrongly used=2E

Change-Id: Icaa7=
6a20ef41e26044fa684d5297f40d8d5ddc8d
Signed-off-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921
Message-Id: <202609=
21170825=2E8046-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39375=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/build=
=2Eyaml
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1921/2

diff --git a/=
=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index 5=
6dd3ed=2E=2Ed67c215 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2E=
github/workflows/build=2Eyaml
@@ -62,6 +62,8 @@
       - name: Install depe=
ndencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
     =
  - name: configure OpenVPN with cmake
+        env:
+          PKG_CONFIG_=
PATH: "${{ env=2EVCPKG_INSTALLED_DIR }}/${{ matrix=2Evcpkg_triplet }}/lib/p=
kgconfig"
         run: |
           cmake -S =2E -B openvpn-build -DUNSUPP=
ORTED_BUILDS=3Dyes \
             -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE_SYS=
TEM_VERSION=3D28 \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1921?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
Gerrit-Change-Number: 1921
Gerr=
it-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--cniHe2ARhLA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">GHA: Explicitly set PKG_=
CONFIG_PATH in Android build<br><br>Otherwise CMake could use the wrong pkg=
-config file=2E<br>It was still using the correct libraries due to<br>archi=
tecture config=2E However, in Ubuntu 26=2E04 lz4 has<br>an additional xxhas=
h dependency and this dependency<br>was wrongly used=2E<br><br>Change-Id: I=
caa76a20ef41e26044fa684d5297f40d8d5ddc8d<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1921<br>Message-Id: &lt;20260921170825=2E8046-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg39375=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>1 file changed,=
 2 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1921/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml=
</span><br><span>index 56dd3ed=2E=2Ed67c215 100644</span><br><span>--- a/=
=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/=
build=2Eyaml</span><br><span>@@ -62,6 +62,8 @@</span><br><span>       - nam=
e: Install dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg i=
nstall openssl lz4 cmocka</span><br><span>       - name: configure OpenVPN =
with cmake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
nv:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          PKG_CO=
NFIG_PATH: &quot;${{ env=2EVCPKG_INSTALLED_DIR }}/${{ matrix=2Evcpkg_triple=
t }}/lib/pkgconfig&quot;</span><br><span>         run: |</span><br><span>  =
         cmake -S =2E -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes \</span><=
br><span>             -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=
=3D28 \</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail">change 1921</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaa76a20e=
f41e26044fa684d5297f40d8d5ddc8d </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1921 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--cniHe2ARhLA=--


--===============1798478464451093117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1798478464451093117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1798478464451093117==--

