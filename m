Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EBAC43327
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7rmJaOChLS3PBEe23jeXV5eeyC/3eCUHlOPPdb48Pzw=; b=BMPKpSI5XfGg7T
	E4bHkQb+f29AD9caqsiPJoP5QDhdRR1gMdlcTl187nEySJZKhP+acliGU0Usb7FT1UGwd/nqhiypY
	KNhFtAUqGMtEDdvgkYDYPvOiMXnSlWhqIO8jzaqlW1RcbSJDpa4dGIkOp9E7c3pK8iCxV9Mr9Gaxg
	u2o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wexKb-00082S-3a;
	Wed, 01 Jul 2026 15:58:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wexKZ-00082L-T8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2+HGBvaz4Hl3OUWvuAfwZE6cYLcExOqlH2TxjSfgOug=; b=IpTCOP+GVXdZPkxNczEYR3y7tO
 p+PBoskTuIznCGhBeGqtnMOl2ULZjBm7xzt/lHcse1WWrZ5h2FfXYSGOUpw+crbkXLztUecT6qkHE
 8lMODU8d0mvLBK7f1Oxw5Bab/v1Q+fM+X4PibFACFcDhfa5IoZMxFmmYqMp9Kg9bTktw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2+HGBvaz4Hl3OUWvuAfwZE6cYLcExOqlH2TxjSfgOug=; b=F
 TGFI+pP7yeZaRt/xekecuwFlD7Jugm84ipm8jo1eZyk6N4d48f0t1/FX812tiq4WGiDudWBMZCJE0
 TMSHYejbItPIW8gdA9PakLHKCpFNRP6EAWJeUtjzHku88nzCyu68qu1u1tM96XFxf0Jfj8PqtYujJ
 at5mI9JncbAmqU6I=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wexKY-0003VU-Gv for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:58:31 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so20000975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782921499; x=1783526299; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+HGBvaz4Hl3OUWvuAfwZE6cYLcExOqlH2TxjSfgOug=;
 b=U1VuOETZgWreuExm2btgyMFRq6XYApbNMiFD/tR6eJe0yP9MBm+vwPeNo5DQC2oii5
 4G6yJUo1avjmPPfvNt4FUk8/BCinKIZtoaGP/Oh0vqij+4TPYbj9zTWaY6eRIV2PiCZU
 GkKqv+14opXAJprh0IgLQJspxYDtB/hWpx5ggDWdq4/dQx7N9XT8mIVg8g12mHqeySsG
 LIISsfquHGaFXqQ95FHgqLkSLaL/ijSbbk9dZ9nMU/HWFa2/r06XdubXJHObqy7wC7dt
 PJXYKaZJqSKAWhYZgjO4dn3JwI6L2O2SPbRUZhz0PJBfWVJjnv2F6zCVqovewWZ4wwu1
 E6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782921499; x=1783526299;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2+HGBvaz4Hl3OUWvuAfwZE6cYLcExOqlH2TxjSfgOug=;
 b=sX26T9VnWvGXDBpKECScIZhktFA95I88JkOgZHlmwcJNB4dGhranRd60770by3w6bP
 AkILNhhgZnAigEsRrY6UTShh8Md4i7OVKtbTdT9m54askrKhBa5EuYcg4NOvQNagRBF8
 dwz/NuJwp/PYkHy7LSvAbeoald3t8ivi9yXn+j/zxZ7ylMUAQFmXO865lC0Vg9TIFebA
 yCIfgQRp/z8V/uFMsbr9ZbAdXxVohZ3v3fpLNC/QY2HaRojy4Fe+R+BP9gJYLR6yDIK6
 ilwyk2VdyRVUVjVs471bwNeKuNyEitF63HnhN2ZPCe/9FCp4NENx2TJbeDmisBlPJmLB
 Kokg==
X-Gm-Message-State: AOJu0Yxe5+mWPKRUk4v06OeMqWn/f2khVsXAdV8Uoi23ftt9lCDKSKFu
 dS9nbiNOhhCJvIE49gci1k8G9QOKlbYW8ohjXRbbuh85bc1UrvGMHrwZULWRKjWey9NzuFas3Fv
 +dLBkw/UIDfuSAZyZ7QQzAAVf5jhGwMsFQlkPK6B3pPYYJg+qqr5rRgoYMiKUbAn8CvHVN2x763
 tlre+sPg==
X-Gm-Gg: AfdE7cmMFO89I9RRN6TynS6DZf3afl8RBNhkLNbxrh3E4Q/OwHR7sO/1UTCadFS4MEP
 mcNautTS1LB2nKAnm0wjjq4VHGSxGyH2/st1hlB9YMdpGzp+qwAebSe7Iuqlh5qhhVGTefG/OG+
 E0RXVgq9llzcNUZSRwSnqo2jlWOFZwsrq8NPET6W4/V+7lofPcwC7o5qbG1UXiYNUmKxbwb9Khx
 8pHfpuITj9C8z85kYbDOWgJkDkZH8K/bQT4pD102D7YJPeyIRgmaS+7hG96NsdiUv+mmAXfg2ZW
 f6AqL3OJlSTMSZ2hbIMjecVmz2wv/dQOF1x6DBut4qFmO5ILb1Q1/i/9TklTRmeApsDBiq/WQ8O
 5PTJXZTWmqZHBqT/YRLXqAnwT9MEmWvHDgd7KkSV83/1yTQWml+NFPZQTNw6tnYFiNEp7TftdaJ
 zV0a5wO5zcqqG2NkMs9Wkr2QMGmUsdN4/3ePOVtGT8dnnNAzJJu42gwC66fKTJe0x8NDvOQYPPa
 Z76rvlbMvIVKSMCZzyRtR6PBB0qqw0FDQWBe37pd9ENv3se5xvUAAe46kBpPh4Qw/6Axd+xH++0
 A9s=
X-Received: by 2002:a05:600c:c492:b0:492:714d:8c4 with SMTP id
 5b1f17b1804b1-493c234dab7mr32361215e9.11.1782921499283; 
 Wed, 01 Jul 2026 08:58:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d15ddsm83627195e9.6.2026.07.01.08.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:58:18 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 15:58:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
X-Gerrit-Change-Number: 1761
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1761?usp=email>
X-Gerrit-Commit: bb285c2156009fbfbc3ceee439e71daf2cc3dc8a
References: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTIxNDk2MDAwLkliYTU3N2Q2NjJiMzg5ZGU1MzliODEwMzQ3MzVlNDM3MTk5Y2I0OTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b65b6d984958596bc7809b24a4be8bec7e06ef9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wexKY-0003VU-Gv
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_tls_crypt: Fix
 issue with temp file name on big endian systems
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3488249417590395291=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3488249417590395291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PnAOVmK4wVo="; charset=UTF-8

--PnAOVmK4wVo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1761?usp=3Demail

to review the following change=2E


Chang=
e subject: test_tls_crypt: Fix issue with temp file name on big endian syst=
ems
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test_tl=
s_crypt: Fix issue with temp file name on big endian systems

Encountered b=
y Fedora s390x build instances=2E

Change-Id: Iba577d662b389de539b81034735e=
437199cb495d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---=

M tests/unit_tests/openvpn/test_tls_crypt=2Ec
1 file changed, 7 insertions=
(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/61/1761/1

diff --git a/tests/unit_tests/openvpn/test_tls_cr=
ypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index 82b1dc8=2E=2E1d=
8ac25 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/=
unit_tests/openvpn/test_tls_crypt=2Ec
@@ -722,8 +722,13 @@
 
     tls_optio=
ns=2Etmp_dir =3D "/tmp";
 
-    /* Since we override rand_bytes the tmpfile=
 name is non-random as well */
-    const char *non_random_tmpfile =3D "/tm=
p/openvpn_tls_crypt_v2_metadata__706050403020100706050403020100=2Etmp";
+  =
  /* Since we override rand_bytes the tmpfile name is non-random as well=2E=

+     * Build the expected name via the same code path as
+     * platform=
_create_temp_file() */
+    char non_random_tmpfile[128];
+    snprintf(non=
_random_tmpfile, sizeof(non_random_tmpfile),
+             "%s/" PACKAGE "_=
tls_crypt_v2_metadata__%08" PRIx64 "%08" PRIx64 "=2Etmp",
+             tls=
_options=2Etmp_dir, get_random(), get_random());
     unlink(non_random_tmp=
file);
 
     expect_string(__wrap_buffer_write_file, filename, non_random_=
tmpfile);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/176=
1?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchang=
e
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iba577d66=
2b389de539b81034735e437199cb495d
Gerrit-Change-Number: 1761
Gerrit-PatchSet=
: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>

--PnAOVmK4wVo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">test_tls_crypt: Fix issue with temp file name on big endian systems<br=
><br>Encountered by Fedora s390x build instances=2E<br><br>Change-Id: Iba57=
7d662b389de539b81034735e437199cb495d<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/unit_tests/openvpn/test_tls=
_crypt=2Ec<br>1 file changed, 7 insertions(+), 2 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/61/1761/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index 82=
b1dc8=2E=2E1d8ac25 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_cr=
ypt=2Ec</span><br><span>@@ -722,8 +722,13 @@</span><br><span> </span><br><s=
pan>     tls_options=2Etmp_dir =3D &quot;/tmp&quot;;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Since we override r=
and_bytes the tmpfile name is non-random as well */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *non_random_tmpfile =3D &quo=
t;/tmp/openvpn_tls_crypt_v2_metadata__706050403020100706050403020100=2Etmp&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Since =
we override rand_bytes the tmpfile name is non-random as well=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * Build the expected name=
 via the same code path as</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * platform_create_temp_file() */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    char non_random_tmpfile[128];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    snprintf(non_random_tmpfile, siz=
eof(non_random_tmpfile),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             &quot;%s/&quot; PACKAGE &quot;_tls_crypt_v2_metadata__%08=
&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             tls_options=2Etmp_dir, ge=
t_random(), get_random());</span><br><span>     unlink(non_random_tmpfile);=
</span><br><span> </span><br><span>     expect_string(__wrap_buffer_write_f=
ile, filename, non_random_tmpfile);</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=
=3Demail">change 1761</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1761?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1761 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--PnAOVmK4wVo=--


--===============3488249417590395291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3488249417590395291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3488249417590395291==--

