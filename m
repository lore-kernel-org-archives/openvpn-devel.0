Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF50CC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ituct1ZQE+gQ7wqHfUMoPCueim+y0i8kpZru4jvupo4=; b=X47koLI/QVZH+AXMPEx3ifOKms
	fDkm+4DC0AdPDh9mb7wnT2u8rrPvS8Lpi9zmVT1UDwOtdQfbaxEOoU0LnJ20dzhmq4yoLNdhH1XeA
	uyO5nkynlt5jib63p0vKd28LVAemyCXlFLziFS+THrnjkA4Ngum5O+R6bhN7FRvPNquc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw2x-0001Gw-9Y;
	Fri, 28 Aug 2026 12:51:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw2c-0001GN-TA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iycgHNHWDXdtHlhlUulWtZfKcX5qcldlwDBpAyLQtJA=; b=fBYFfKDDZGqOj0EfaQd7PUgKWA
 f7yhjod2mJP3avQ/lRPKwCepeCMS6R7Oq4o5mD5MP23pGz2o1Dis4wOreaKxK1Og+5CHN8FOWF5Yx
 Rd732r1YnrxzgPuzrZmVTarG1cULSmZC/YdWhR4kmfpYs3Ld11F8esnwryvsQ6fsXLbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iycgHNHWDXdtHlhlUulWtZfKcX5qcldlwDBpAyLQtJA=; b=k
 nY8mZph+cmm483RsHGB67ex5smxnBWlPf+pWEWQEJqrv2ptKqCNIe6uSXCquhRZnH8l2qDj+nApik
 xgWv8uMtR5UX41gya6NJCZ0ywTuhRoLgiqVUzltLkk1/Ibd1PMcuT9r1PIzjoNHkVbB4p4/gc4kN0
 UTKrbP6S2Hnj0JP8=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw2P-0003ED-Up for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:50:31 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-482c58a8683so755503f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921423; x=1788526223; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iycgHNHWDXdtHlhlUulWtZfKcX5qcldlwDBpAyLQtJA=;
 b=Ur0r2ZtsDlFolblFjJAY6xQkj/VCBbPuA4bDhGTHK7crfoMy6kmQsnO/cJQns6D9/d
 XNHlYcjf23QGjBaj22PG3kVHgk4ICGaDaWv3heyir21Kh+krz9BmCz2e4mj/o3AYiI7f
 Rwt7KPTkdRufze6VUAOd1xPSiDSs4H3l7yeABeonF4PAFCf+JeRPMvaTtF610clx7wB0
 Oeg/wH1jeTINMAh34SjL1Hof+VS+Q7rn6xpR9Nbp7DiRPKJOg6M1Xr1FbRJOgR6VUTF7
 jYKggQXMvo1KGNdoZm05+5HpdBGJUyJonoP6Z+x9AyI/JgX6SdLEC0I4qnNwUtbofLOl
 AX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921423; x=1788526223;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iycgHNHWDXdtHlhlUulWtZfKcX5qcldlwDBpAyLQtJA=;
 b=leVUB9pQ3J0y4I0z8/MoZ/9Dbp0Kt0bVHjVVv3Jaens4O6XugsJ0FIKFSvfN57iqcz
 HYrR0E+VIVJTv4xCc8+FmII3Pw/5/EYLEUgSmMvrjp+cplRnIkwbSqQdzhqmmE75gKud
 5ZvfiQcUSqI1Bg+3mBv7ipShvUaZhrlFjO/vxIxmLgFv8KKuassqpfH81s+S6W3ZLcs2
 ZtCKiD6kgBmcgB9lJa12LAjo/nLmB7e7CqBQXRdyuXOlG+elYrYbrZG9S/gkgE/nzdv6
 it07GiX+Id2tw116KLi0rDX2Kmue5F6zz6fHEl7rdjRzcTvn+iFB6zKrhv6MfyavU3OQ
 bXdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdWVrjM4K2HX3XDvUvgZhd6dLhTY0VF11bwEtvecfe2/LnAL09BqDvdOI6j1W5gwFGa/86vg/sz3vswWRA@lists.sourceforge.net
X-Gm-Message-State: AFuF++kRlfXSbl0iR94ywHnniPmNLG3LTw5lco9wpGY04Q4samAclrVy
 /QfAafM26uk81ISkCJJRHHzt8XdPV6mwgJn7YV+gFo9GUnOhIb6WHu3s0f6c8WOvc3Q/iMOL/IW
 STY5WtY5/p3UcQrl4NZ+7KOektcJDTx1xbjhKavVOj5bdmGpZyY93sPFTIaqzEVS42Ki/
X-Gm-Gg: AR+sD10YCl6q8dWQ4GFJ5nfcKiZU261J7HWRveVJ3UPWC11+i1Kj7kk7UVtP4a4/Ebf
 vhlq1Va9vNoQ1ooldBqEF4TszbahWO8fLetb+KLXz44nOVP3xKnC7fipnzgM1IpwC/OjjnXD5sk
 P6Q5q5PKnpgGn1E4XD5O5cqF6wCDkBf3w6opKcYjU0Rw3eIJlAwZy0Qbd8n+E7WnQiD1Svi8hE5
 f6p34WfHTDhzeL2oKMLjZTSXzHayolooj81Na/TjrfoX9QplvW5gxbV/u+4PfUNyboPFOTxHip+
 GgHTNNGAqrqgjRPBQ7JIr+osO85sqllnxWkP9V5yp9WJgBZIUjosEMs40ubU3jZvBxcE1k2+EHW
 Pn/6qKpqN3yA0DlgWnc5NlNNGkPmjrf9w/Jx6qDsSLN+eDUeU+wjqpuE7o2drYyq0JWWXmGuc/C
 Q9AXmp0HMs0cajuLkvP0BXLQD13b2D0KwvaUE7S8wAk+LmLcWfE2aG5WBPYdAO+Co765WXf5z0S
 lnWNjRWOLz+WCDJ7NJHA5HZ5Udr1qIDjuWLjjtBjwuo4v+fumO9QNEbYakWrv8lCg3bmfbAyVhC
 vxB/CT17LSMPQFWguiCMqh7o/aWyYUjtvq8q18hnpX2ZuAqeeAQ=
X-Received: by 2002:a05:6000:2893:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-482f79b01abmr9628617f8f.12.1787921422252; 
 Fri, 28 Aug 2026 05:50:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm3976746f8f.25.2026.08.28.05.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:50:21 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:50:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 58fb5785dc6fe6df923ac633b617004c6f7b20e2
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3101e426bd196fa56abbdef77f852c0f8e4179e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw2P-0003ED-Up
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============7778265993473700695=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7778265993473700695==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KEPtORpe+ZU="; charset=UTF-8

--KEPtORpe+ZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail

to look at the new patch=
 set (#2)=2E


Change subject: mbedtls: Work-around bug in mbedtls 4=2E1=2E=
0 and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

mbedtls: Work-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0

Since the=
 first distros have started to pick up these
versions before a fix is relea=
sed, let's make our tests
pass on these versions=2E

A fix is merged, so it=
 might be fixed in 4=2E3=2E0=2E But I
didn't want to add that to the versio=
n check until we
have verified that=2E

Change-Id: I694410615958afbb422d9ea=
d71f04c1a60edc640
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
---
M =2Egithub/workflows/build=2Eyaml
M src/openvpn/mbedtls_compat=2Eh
2=
 files changed, 14 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1849/2

diff --git a/=2Egith=
ub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index 29e8be2a=
=2E=2E56dd3ed 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub=
/workflows/build=2Eyaml
@@ -365,7 +365,7 @@
       ovpnlibdesc: mbed TLS 4=
=2E
       # versioning=3Dsemver-coerced
       ghrepo: Mbed-TLS/mbedtls
- =
     gitref: v4=2E0=2E0
+      gitref: v4=2E2=2E0
       libconfigure: cmak=
e -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFIX
       libmake: cmake --buil=
d build
       libinstall: sudo cmake --install build
diff --git a/src/open=
vpn/mbedtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh
index 50739b6=2E=2E=
ec45a0f 100644
--- a/src/openvpn/mbedtls_compat=2Eh
+++ b/src/openvpn/mbedt=
ls_compat=2Eh
@@ -43,6 +43,7 @@
 #include "crypto_mbedtls_legacy=2Eh"
 #els=
e
 #include <mbedtls/oid=2Eh>
+#include "crypto_mbedtls=2Eh"
 #endif /* MBE=
DTLS_VERSION_NUMBER < 0x04000000 */
 
 #ifdef HAVE_PSA_CRYPTO_H
@@ -228,6 +=
229,18 @@
 mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, cons=
t mbedtls_pk_context *prv)
 {
 #if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+=
    /* work around bug in mbedtls 4=2E1=2E0 by adding missing public key in=
formation in prv
+     * cf=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/=
issues/807 */
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04010000
+    if (prv->MBE=
DTLS_PRIVATE(pub_raw_len) =3D=3D 0)
+    {
+        mbedtls_pk_context *mut=
_prv =3D (mbedtls_pk_context *)prv; /* remove const */
+        ASSERT(mbed=
_ok(psa_export_public_key(mut_prv->MBEDTLS_PRIVATE(priv_id),
+             =
                                mut_prv->MBEDTLS_PRIVATE(pub_raw),
+       =
                                      sizeof(mut_prv->MBEDTLS_PRIVATE(pub_r=
aw)),
+                                             &mut_prv->MBEDTLS_PRIVA=
TE(pub_raw_len))));
+    }
+#endif
     return mbedtls_pk_check_pair(pub, p=
rv);
 #else
     return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_ra=
ndom, rand_ctx_get());

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1849?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I694410615958afbb422d9ead71f04c1a60edc640
Gerrit-Change-Number: 1849
=
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: MaxF <max@m=
ax-fillinger=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>

--KEPtORpe+ZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">mbedtls: Work-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0<br>=
<br>Since the first distros have started to pick up these<br>versions befor=
e a fix is released, let&#39;s make our tests<br>pass on these versions=2E<=
br><br>A fix is merged, so it might be fixed in 4=2E3=2E0=2E But I<br>didn&=
#39;t want to add that to the version check until we<br>have verified that=
=2E<br><br>Change-Id: I694410615958afbb422d9ead71f04c1a60edc640<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =2Egit=
hub/workflows/build=2Eyaml<br>M src/openvpn/mbedtls_compat=2Eh<br>2 files c=
hanged, 14 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1849/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=
=2Eyaml</span><br><span>index 29e8be2a=2E=2E56dd3ed 100644</span><br><span>=
--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/work=
flows/build=2Eyaml</span><br><span>@@ -365,7 +365,7 @@</span><br><span>    =
   ovpnlibdesc: mbed TLS 4=2E</span><br><span>       # versioning=3Dsemver-=
coerced</span><br><span>       ghrepo: Mbed-TLS/mbedtls</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      gitref: v4=2E0=2E0</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      gitref: v4=2E2=2E0</span><br><=
span>       libconfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFI=
X</span><br><span>       libmake: cmake --build build</span><br><span>     =
  libinstall: sudo cmake --install build</span><br><span>diff --git a/src/o=
penvpn/mbedtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh</span><br><span>=
index 50739b6=2E=2Eec45a0f 100644</span><br><span>--- a/src/openvpn/mbedtls=
_compat=2Eh</span><br><span>+++ b/src/openvpn/mbedtls_compat=2Eh</span><br>=
<span>@@ -43,6 +43,7 @@</span><br><span> #include &quot;crypto_mbedtls_lega=
cy=2Eh&quot;</span><br><span> #else</span><br><span> #include &lt;mbedtls/o=
id=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;crypto_mbedtls=2Eh&quot;</span><br><span> #endif /* MBEDTLS_VERSION_N=
UMBER &lt; 0x04000000 */</span><br><span> </span><br><span> #ifdef HAVE_PSA=
_CRYPTO_H</span><br><span>@@ -228,6 +229,18 @@</span><br><span> mbedtls_com=
pat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *=
prv)</span><br><span> {</span><br><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D=
 0x04000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* w=
ork around bug in mbedtls 4=2E1=2E0 by adding missing public key informatio=
n in prv</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cf=
=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=
=3D 0x04010000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (prv-&gt;MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        mbedtls_pk_context *mut_prv =3D (mbedtls_pk_context=
 *)prv; /* remove const */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(mbed_ok(psa_export_public_key(mut_prv-&gt;MBEDTLS_PRI=
VATE(priv_id),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                        mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                            sizeof(mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw)),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                        &amp;mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw_len))));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     return =
mbedtls_pk_check_pair(pub, prv);</span><br><span> #else</span><br><span>   =
  return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_=
get());</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">change 1849</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I694410615=
958afbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1849 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=


</body></html>
--KEPtORpe+ZU=--


--===============7778265993473700695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7778265993473700695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7778265993473700695==--

