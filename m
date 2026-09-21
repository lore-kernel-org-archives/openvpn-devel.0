Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE0CC982ED
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBo8m51uo3jsUmCzKXZWM9YF2OmH6GxKSeVdrrl0j+w=; b=O7FDJ9sI1h10hLZWbNsEKuP0/s
	xpk3cChwOyHapttpTPEHBGEacx1shM3QdOVK0KyXGLbsc/oM90r6Z8XJg+FwKI1Xg1SHYoMipm1yi
	Ntnneh4tqzUa3zlUkKp9NG90oEdL0N1zmwTt6vKIargeET8k3zOPEjZ0A/+BTYoVWimo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8k5O-0005eZ-3O;
	Mon, 21 Sep 2026 19:53:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8k5B-0005eI-MZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Hsb76eOi+nHfZMRS3y1Cn7Bu8d7Kwu38IM+eCAhYYaw=; b=embxL5Io2EuEjnRQM0ShTd5KFX
 F3Sh259ibEv/FmgIY0pd1XyWtf/1oazTtoOIiG+/FQR1B0H2vRkb+CYJe6lLBRURaPhSAk7j7L+tZ
 Odmz4NTcoHjjZbEYqAX15/BXmsJIdnFtj5vnjJg4x9ufoY61QkTOYOS5XLLj/vow7TPo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hsb76eOi+nHfZMRS3y1Cn7Bu8d7Kwu38IM+eCAhYYaw=; b=N
 Zg+fUTCHNxSMcciqSDiFEp+SciCC03jg+iJqwyPFJigbyZ6Ghnk5ZsTdBlzuHZSm6Ld5HjDnzx8zT
 AZ6SEOA8DZYI+lnXT7W5ASu8pemE1FWtiYd+WC6JG5FgcAUxP3eJP8So5XAkq5jnSbdUq2e9UV2Wo
 UWMSobEX7eCeiQ78=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8k56-0003ue-U7 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:53:41 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484366874b0so2010660f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790020414; x=1790625214; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hsb76eOi+nHfZMRS3y1Cn7Bu8d7Kwu38IM+eCAhYYaw=;
 b=GVCxgdSaZca5FMQdKE0cay30MxK2b/g1LxwQoIZD7+UixeP7RUovSLdEXeym/lKY6S
 /VL4vIkGDud+lUO7J30qj4YSOho/vjvX+T1pzSk2/GMnAK14pp/5NY9p2TLSz+K4emYV
 9ypZEaN3R5eBkLdoRDrKkVCx0WrYSxzXU/OFgzauYTp6HmI1elU2YbuARO/TUc5uoQXy
 EeqJ26IFiVm/EWvvJic3SFCqlx3HPMYlq1QG8Hw7/+JaSzQtAbg+Nzw79pF9NqUkqRXK
 0bd8IKiInu9EMZLiSVcRAWXEum58AkK56QU39poLbQ9OFRiqu6sqcJnPzxTSILUbme73
 2rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790020414; x=1790625214;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hsb76eOi+nHfZMRS3y1Cn7Bu8d7Kwu38IM+eCAhYYaw=;
 b=T+CFp13M2JYyyTz9IqMFHReSdQ91aGBarZ3YeDtcjWJzN6XJnBXF5Ei/e1ckVksYCB
 vUIdK6v9ch2RNnjjbFl5Ticry3VDGc10Eltb5MOAOU0Hs1aCtdGxNmjDzuQ1+i/ifyD1
 JWvumTWrb/7lcQ8r5JQzmW5nhd2m2f2h8y3MOcvyCw96RJVq+O8mRXzxYmgANQ9/vZaJ
 oGsZBN4LWyXgCd6glLFXScKxrkH8wJiwTb4lM25SkRtOZeDA9Zmd18l4AfKeknjU4clg
 WsjuW1fy7Ct+3A+DV9wRTutqisMU4OKBv6JD47fkqvQ43OTOCdWIJywrqKfG3ZuAjrAq
 cSdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsorSxgzKb7L9P861S6pbY0S7f2lNVsoSdCcuG+vvRIA5C2rz2fkzXswz2qK6PjIH0XJp1UDJ6deUdT0kP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kL8Tdx6FHBDYUyRUCudY/bemZNYzYYYAuqO6Avii5dWzih870t
 YRFW2dijARn4GGuktHoVccr+XXVAGj8ZxsZefEsXcYlien+pAd9EXLWAPR22MAjOx9LkAK412FA
 seCsrgX+L4j/8NZpwf3SEyTRRPBrpfwHoMXxSgftix5bd3FbQAzMqi8Utn/ccQ5gkdAZO
X-Gm-Gg: AYBFou0Wd0rqrEzmLchvXbq+CxxRMNe9i0wloBbFFp4wjjbpuMhydPwim5x1BWFIyVw
 mm56czyJpSJJiVMTzxVWsSHB6NPKXpCQgezS4L7Cw1wuAgvLYEcegExBqilhXOAF1iEBjaYZ6Lk
 VmpTmoIp1PFW0M5N7BQacW5BkeLkaM0WdXN42StFUUS5zhl1zcxA8gkbuEKBTx6sEQwFQGkaiVm
 5TCXI082B3Zz8DtykKMp7yGCsxeVGuylX+22kkotczOxzgVrI2kYrCqpsEmSBLqmXnSkTOmU4Hg
 0lGLBrQMBNlpg6U5F1m6aQdikpjNS/XEbG/reiWnu9kYXziNrhKMd9e08mPNQgpafGw1x9qizpB
 We+P2KMETp3drSrocNpuHyWyloQGuiNy2/+f5ZimTE3b3ar+xdSKSxjao73YjZKy+W93Mkky/iw
 m2DZ/MqzQ8tCaOF2wfeBlpi7/2LFBLftl+tFIfy6bFgR+XGE9GuT7zmLcq4d9VnZiKfx08s/xHl
 3GPRitF0D37XCVtFshUtQKg/bcQefmwXeN1iqZ8c0GRENBz0+PVsfWkwHhbiVzq1KUzvCc95q4g
 T7SP+j6nYKTNWWpO1ozC9gWuTMt+Mtg0D2L5lm0BiBX6mpCAGSOYIXmZ2IYl
X-Received: by 2002:a05:6000:24c1:b0:487:a0f:82ff with SMTP id
 ffacd0b85a97d-4871e25e2b4mr22837549f8f.17.1790020414156; 
 Mon, 21 Sep 2026 12:53:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724460898sm24196031f8f.9.2026.09.21.12.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:53:33 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 19:53:32 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
X-Gerrit-Change-Number: 1921
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1921?usp=email>
X-Gerrit-Commit: 9e378318a0962a4cfad71af331ee4b193f45fef7
In-Reply-To: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
References: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkljYWE3NmEyMGVmNDFlMjYwNDRmYTY4NGQ1Mjk3ZjQwZDhkNWRkYzhkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <045c0d57a50da0076b7aaaa937dfe0ad31364451-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8k56-0003ue-U7
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4350274758393926916=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4350274758393926916==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bbg31m4Vhiw="; charset=UTF-8

--Bbg31m4Vhiw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1921?usp=3Demail )

Change subject: GHA: Explicitly set PKG_CONFIG_PATH=
 in Android build
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

GHA: Explicitly set PKG_CONFIG_PATH in Android build

Otherwise CMake =
could use the wrong pkg-config file=2E
It was still using the correct libra=
ries due to
architecture config=2E However, in Ubuntu 26=2E04 lz4 has
an ad=
ditional xxhash dependency and this dependency
was wrongly used=2E

Change-=
Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921
Message-Id=
: <20260921170825=2E8046-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39375=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows=
/build=2Eyaml
1 file changed, 2 insertions(+), 0 deletions(-)




diff --gi=
t a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
ind=
ex 56dd3ed=2E=2Ed67c215 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b=
/=2Egithub/workflows/build=2Eyaml
@@ -62,6 +62,8 @@
       - name: Install =
dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
 =
      - name: configure OpenVPN with cmake
+        env:
+          PKG_CON=
FIG_PATH: "${{ env=2EVCPKG_INSTALLED_DIR }}/${{ matrix=2Evcpkg_triplet }}/l=
ib/pkgconfig"
         run: |
           cmake -S =2E -B openvpn-build -DUN=
SUPPORTED_BUILDS=3Dyes \
             -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE=
_SYSTEM_VERSION=3D28 \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1921?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
Gerrit-Change-Number: 1921
Gerri=
t-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--Bbg31m4Vhiw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1921?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">GHA: Explicitly set PKG_CONFIG_PATH in And=
roid build<br><br>Otherwise CMake could use the wrong pkg-config file=2E<br=
>It was still using the correct libraries due to<br>architecture config=2E =
However, in Ubuntu 26=2E04 lz4 has<br>an additional xxhash dependency and t=
his dependency<br>was wrongly used=2E<br><br>Change-Id: Icaa76a20ef41e26044=
fa684d5297f40d8d5ddc8d<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921<br>Message-I=
d: &lt;20260921170825=2E8046-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39375=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M =2Egithub/workflows/build=2Eyaml<br>1 file changed, 2 insertions(+)=
, 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2E=
yaml b/=2Egithub/workflows/build=2Eyaml</span><br><span>index 56dd3ed=2E=2E=
d67c215 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span=
><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -62,6 =
+62,8 @@</span><br><span>       - name: Install dependencies</span><br><spa=
n>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><s=
pan>       - name: configure OpenVPN with cmake</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        env:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          PKG_CONFIG_PATH: &quot;${{ env=2EVCPKG_INSTA=
LLED_DIR }}/${{ matrix=2Evcpkg_triplet }}/lib/pkgconfig&quot;</span><br><sp=
an>         run: |</span><br><span>           cmake -S =2E -B openvpn-build=
 -DUNSUPPORTED_BUILDS=3Dyes \</span><br><span>             -DCMAKE_SYSTEM_N=
AME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
21?usp=3Demail">change 1921</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1921?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1921 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Bbg31m4Vhiw=--


--===============4350274758393926916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4350274758393926916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4350274758393926916==--

