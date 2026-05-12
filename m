Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39076CD343F
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDUeXFzeJMUKA9QowF6Y+Lx/abZQ4SWeWMm9fBgMynU=; b=dF1mGXtX78Vltrb4Eh2B7zWH3e
	Z191z7cxOVdX7jzTbcBgF+CeKvgRgLWBWJkGq9S/yPZytUhpv0vOQm/6d+WBf39Je6UyjgoiHrxpZ
	dcenE/uEOyaYC2XeWx4rw1KT0MAzXVgPjJfyV/Kr/S62Ziu8vFSHyW0xc9xMXaH0u4Dk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMuk4-0007zI-NT;
	Tue, 12 May 2026 21:34:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMuk4-0007zC-5U
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 21:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0281DB2IB99x3UphAmE5eoJFrokcmTSqekOXBS0spe8=; b=OCgdLmkmiPM6zeVXJ6IPEPg+Ez
 et9QdSMvUDHP7S/AV2wh/muq4f4kBwnhzYsgGz0WMi7kTBlb25jQCI29h9iD1V32tVKpAN8Y/QoMt
 q66tavid+ZLBWtsvhLPDKafXGahIVnONpYG8/dHXRKXlUl1BVoUAGGy/cuW44M+Dq5Q0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0281DB2IB99x3UphAmE5eoJFrokcmTSqekOXBS0spe8=; b=S
 NG8CriK2xcB4KwPY6Lwuo8dA/3pqMhB9cxiyOeQbRnDQLJZWTTwQXiYWH29ascWI+LTzMKAgeOxyO
 tMpKKh2YDtAhZH6V9XjzB45OU25/f0QQ/Rhp+jbaqMRc4S8SPJclXQRq6uFB0FWhVfkpBDZQF8qGS
 uXuC6EI+HZeFdMik=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMujy-0007QA-2W for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 21:34:16 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso37761125e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778621644; x=1779226444; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0281DB2IB99x3UphAmE5eoJFrokcmTSqekOXBS0spe8=;
 b=gRYkR5SqVxtu0vJ5bd7mOmv1jCGNazZyAWIKbZa6BvvmcJzy/hMgrY+ttVSLTzQEZd
 EdhhAA2TCgPlum3X47qeSFcvbcxnhUe+WVhHYbcOZABkvU/s8XtGiCnQvUhyH1GlAGNP
 IhyYVqYjNk/Tiu0mo7apsd+jpsfqN67R2z+pB9rrsRLVrQSVPgZ/4sq+pTl1YJ3wi55P
 TTqaN++XyRJl3DM+wmtc7OkD6xlyDoDmsIPxeLK2BmDsKzi+CeyBIpb5JYjttEWTLgXR
 B7/TktTSVKeAOfaPASFiNksx/A4Qkc7aZ7np0W7y3tUNxnySBzj0nUT4eroNALzpCOHP
 925A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778621644; x=1779226444;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0281DB2IB99x3UphAmE5eoJFrokcmTSqekOXBS0spe8=;
 b=XuvzDOghwNKzWh1/01x/xtA9px6vkpMCOkGrTEnhcnxm/bOf0hfVn/n/wsHrayAJxd
 PKT4KBr5sZGpSF5SI9kTMydJ2MtgbODF7zRA7vsShUE/YtKu/I5qp/DFRN8S20L/5lGi
 cveu00pOJfz50/IsdfVUusjlttj13Vjn/EVKK64G3XfxDfb3NblzduA+3/YGIgckGABu
 Ltl24sjzqx5w3h4w60e8vE6ZbJz0fRu0YD5QsJP7CJQMx1lpZ6nZR4C/0fOC6ODj5ZdC
 BPzijaCrHn6YEPKyVuWZ5SQL5m8cPqpIkzAn6Klo1rzZJjGGejMGYJBY7ABw1c0d3R7X
 NqMg==
X-Gm-Message-State: AOJu0Yz9i+fs9YHrCuzfNWgTEug/R6CDlkCfm/DrjLKh/eYa6e6Fxey7
 o6su4Y+QfLVxQrTUO6bHnQgZF8S3omr1Lw+8znytfiOrD6rRTrD6xKJ7hX1lTDsjE5BE1AbVwrF
 JZfOKJ+bZSXHA87pxl4BnMhPjPMQ79f1IzDxapQU8idr46s/R1tGYgnonu/Z9jtGVSrzBhmERHn
 G7JGPmTA==
X-Gm-Gg: Acq92OF/pq7bM2sLGF2vVeeOeGVtDZo1gz0WFf+HJdiodtNeUNpCztaPxOtRsUX8qFG
 2ZpLly1kKSJkwq5CS5Dg9TtG01JqupTaYp2oQJUCBY5acxrTs0OH+ijsLdqi4oqbFruNhAyCcmt
 x7W/cIHeEUyt2c+tEm6Bf0TvHLOmHkDoYvzeqOtz9FaVZY2JHoBRvPWYW3VZz5dzWB8vOlRn8+E
 6gCB9sj76SPn1uWr3CFCrtCxrcXxVCtTTfEKdTAi61Pg5FqSsYdKayx3HLqjQbRaqoueTu6rhTb
 DA7hX8ZJ7D//gR5kRI6muHHEyCWAafCvl5kLsgEZoRryMwwcQXbJ3yYqHWTo0WO/zu38iFMognS
 cefIWfcc7EXTjDflhXU0r22Wwn0Rc/TSZpPsUqsWqCCcBTFdlrC1tEGO0vouMUwATk8HN/1u8/p
 9XmWfyoOtd8WakaMd0z02LdAJlyZUELVD6ZXGXg0NHXixNw8ATedmK/irlmw9bw/CYpFdkvidKK
 TR+SPZu/BF0xbYpMMcFRBS5lWPsowo3gafbIUQOOKyUsUd9MiNAzQ9Wq6JLq7jf6qA4Z0dBz+eL
 JbPSWKgWBl2w58CW41l1SVrY
X-Received: by 2002:a05:600c:3507:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-48fc9a4b04emr6714075e9.26.1778621642475; 
 Tue, 12 May 2026 14:34:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410558sm54667575e9.5.2026.05.12.14.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:34:01 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 21:33:57 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 2f810de894ef77d2b697255ef12960b4b040f9ca
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e6907b86339ef5918370fc62fd8b9be99f3dade2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMujy-0007QA-2W
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1128081481606787969=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1128081481606787969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="djs6V/gVuFc="; charset=UTF-8

--djs6V/gVuFc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1663?usp=3Demail

to look at the new patch set (#6)=2E

=

Change subject: Remove instances of constParameterPointer cppcheck warning=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove ins=
tances of constParameterPointer cppcheck warnings

This requires a few supp=
ressions since cppcheck
doesn't quite understand the different code-paths
i=
mplemented by preprocessor defines=2E

Change-Id: I56248cf6d199c2da770774b8=
fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M dev-tools/cppcheck-suppression
M sample/sample-plugins/client-connec=
t/sample-client-connect=2Ec
M sample/sample-plugins/defer/multi-auth=2Ec
M =
sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=
=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=
=2Ec
M src/openvpn/clinat=2Eh
M src/openvpn/comp=2Ec
M src/openvpn/comp=2Eh=

M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/dco=2Ec
M =
src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_interna=
l=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/d=
hcp=2Ec
M src/openvpn/dhcp=2Eh
M src/openvpn/event=2Eh
M src/openvpn/forwar=
d=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/init=2Ec
M src/openvpn/init=
=2Eh
M src/openvpn/interval=2Eh
M src/openvpn/list=2Ec
M src/openvpn/list=
=2Eh
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/mbuf=
=2Ec
M src/openvpn/mbuf=2Eh
M src/openvpn/mss=2Ec
M src/openvpn/mss=2Eh
M s=
rc/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M src/ope=
nvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/networking=2Eh
M src/o=
penvpn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/ope=
nvpn/occ=2Eh
M src/openvpn/openssl_compat=2Eh
M src/openvpn/options=2Ec
M s=
rc/openvpn/options_parse=2Ec
M src/openvpn/otime=2Ec
M src/openvpn/otime=2E=
h
M src/openvpn/proto=2Eh
M src/openvpn/proxy=2Ec
M src/openvpn/proxy=2Eh
M=
 src/openvpn/ps=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/push=2Ec
M src/openv=
pn/push=2Eh
M src/openvpn/push_util=2Ec
M src/openvpn/reliable=2Ec
M src/op=
envpn/reliable=2Eh
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src=
/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=2Eh
=
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/openvpn/ssl=2Ec
M src=
/openvpn/ssl=2Eh
M src/openvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2E=
c
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl=
_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
M src/openvpn/ssl_verify=2Eh
M src/op=
envpn/status=2Ec
M src/openvpn/status=2Eh
M src/openvpn/tun=2Ec
M src/openv=
pn/tun=2Eh
M src/openvpn/tun_afunix=2Ec
M src/openvpn/tun_afunix=2Eh
M src/=
openvpn/vlan=2Ec
M src/openvpn/vlan=2Eh
M src/openvpn/win32=2Eh
M src/openv=
pnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_tes=
ts/openvpn/mock_management=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
M t=
ests/unit_tests/openvpn/test_user_pass=2Ec
88 files changed, 329 insertions=
(+), 287 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/63/1663/6

diff --git a/dev-tools/cppcheck-suppression b/de=
v-tools/cppcheck-suppression
index 900e03c=2E=2Ead05f34 100644
--- a/dev-to=
ols/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -2,7 +2,6 =
@@
 # occurences right now=2E They still should be fixed at some point
 con=
stParameter
 constParameterCallback
-constParameterPointer
 invalidPrintfAr=
gType_sint
 invalidPrintfArgType_uint
 usleepCalled
@@ -33,6 +32,37 @@
 bad=
BitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
 # IGN: we store integer=
s in pointers
 CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec
+constPar=
ameterPointer:/usr/include/*
+# IGN: test files provide mocks/stubs that ma=
tch prototypes from headers exactly
+constParameterPointer:tests/unit_tests=
/openvpn/mock_*
+constParameterPointer:tests/unit_tests/openvpn/test_*
+con=
stParameterPointer:tests/unit_tests/openvpnserv/test_*
+# FP: different cry=
pto implementations but same API
+constParameterPointer:src/openvpn/crypto_=
mbedtls_legacy=2Ec:85
+constParameterPointer:src/openvpn/crypto_openssl=2Ec=
:172
+constParameterPointer:src/openvpn/crypto_openssl=2Ec:1456
+constParam=
eterPointer:src/openvpn/cryptoapi=2Ec:58
+constParameterPointer:src/openvpn=
/ssl_mbedtls=2Ec
+constParameterPointer:src/openvpn/ssl_openssl=2Ec
+constP=
arameterPointer:src/openvpn/ssl_verify_mbedtls=2Ec
+# IGN: too many differe=
nt implementations, not worth it
+constParameterPointer:src/openvpn/dco*
+c=
onstParameterPointer:src/openvpn/socket=2E*
+# FP: parameters are modified =
on some platform only
+constParameterPointer:src/openvpn/dns=2Ec:859
+const=
ParameterPointer:src/openvpn/error=2Ec:223
+constParameterPointer:src/openv=
pn/forward=2Ec:1247
+constParameterPointer:src/openvpn/manage=2Ec:344
+cons=
tParameterPointer:src/openvpn/manage=2Ec:3332
+constParameterPointer:src/op=
envpn/misc=2Ec:792
+constParameterPointer:src/openvpn/misc=2Ec:812
+constPa=
rameterPointer:src/openvpn/options=2Ec:3205
+constParameterPointer:src/open=
vpn/route=2Ec:3947
+constParameterPointer:src/openvpn/tun=2Ec:560
+constPar=
ameterPointer:src/openvpn/tun=2Ec:2188
+constParameterPointer:src/openvpn/t=
un_afunix=2Ec
+# IGN: not a FP but the documentation for the FP_ISSET claim=
s this is not const=2E=2E=2E
+constParameterPointer:src/openvpn/event=2Ec:1=
015
 # IGN: event code uses a pointer to store integers
 intToPointerCast:s=
rc/openvpn/forward=2Ec
 intToPointerCast:src/openvpn/multi_io=2Ec
diff --gi=
t a/sample/sample-plugins/client-connect/sample-client-connect=2Ec b/sample=
/sample-plugins/client-connect/sample-client-connect=2Ec
index 420de61=2E=
=2Ecbd98e8 100644
--- a/sample/sample-plugins/client-connect/sample-client-=
connect=2Ec
+++ b/sample/sample-plugins/client-connect/sample-client-connec=
t=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_connect(struct p=
lugin_context *context, const char **argv, const char **envp)
+openvpn_plug=
in_client_connect(const struct plugin_context *context, const char **argv, =
const char **envp)
 {
     /* log environment variables handed to us by Ope=
nVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary number)
@=
@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v2(struct pl=
ugin_context *context,
-                                       struct plugi=
n_per_client_context *pcc,
+                                       const st=
ruct plugin_per_client_context *pcc,
                                      =
  struct openvpn_plugin_string_list **return_list)
 {
     time_t time_left=
 =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-plugins/defe=
r/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
index bacf557=
=2E=2Ecdd616f 100644
--- a/sample/sample-plugins/defer/multi-auth=2Ec
+++ b=
/sample/sample-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
 }
 
 stati=
c bool
-do_auth_user_pass(struct plugin_context *context, const char *usern=
ame, const char *password)
+do_auth_user_pass(const struct plugin_context *=
context, const char *username, const char *password)
 {
     plog(context, =
PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, receiv=
ed_passw=3D%s",
          np(context->test_valid_user), np(username), np(co=
ntext->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
 
 static int=

-auth_user_pass_verify(struct plugin_context *context, struct plugin_per_c=
lient_context *pcc,
+auth_user_pass_verify(const struct plugin_context *con=
text, struct plugin_per_client_context *pcc,
                       const c=
har *argv[], const char *envp[])
 {
     /* get username/password from envp=
 string array */
diff --git a/sample/sample-plugins/keying-material-exporte=
r-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-material-e=
xporter-demo/keyingmaterialexporter=2Ec
index 25c9ff5=2E=2E512861a 100644
-=
-- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexpo=
rter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingma=
terialexporter=2Ec
@@ -186,7 +186,7 @@
 }
 
 static void
-file_store(char *=
file, char *content)
+file_store(const char *file, const char *content)
 {
=
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -202,7 +202,7 @@
 ser=
ver_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct pl=
ugin *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =
=3D (struct session *)args->per_client_context;
+    const struct session *=
sess =3D (struct session *)args->per_client_context;
 
     char file[MAXPA=
TH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key=
);
@@ -214,7 +214,7 @@
 client_store(struct openvpn_plugin_args_func_in con=
st *args)
 {
     struct plugin *plugin =3D (struct plugin *)args->handle;
=
-    struct session *sess =3D (struct session *)args->per_client_context;
+=
    const struct session *sess =3D (struct session *)args->per_client_conte=
xt;
 
     char *file =3D "/tmp/openvpn_sso_user";
     ovpn_note("app sess=
ion file: %s", file);
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buf=
fer=2Ec
index 131e1d6=2E=2Ef9990d6 100644
--- a/src/openvpn/buffer=2Ec
+++ =
b/src/openvpn/buffer=2Ec
@@ -290,7 +290,7 @@
  * truncated by buf_printf
  =
*/
 void
-buf_catrunc(struct buffer *buf, const char *str)
+buf_catrunc(con=
st struct buffer *buf, const char *str)
 {
     if (buf_forward_capacity(bu=
f) <=3D 1)
     {
@@ -1091,7 +1091,7 @@
 }
 
 bool
-string_check_buf(struct=
 buffer *buf, const unsigned int inclusive, const unsigned int exclusive)
+=
string_check_buf(const struct buffer *buf, const unsigned int inclusive, co=
nst unsigned int exclusive)
 {
     ASSERT(buf);
 
diff --git a/src/openvpn=
/buffer=2Eh b/src/openvpn/buffer=2Eh
index 6a751ad=2E=2E0d3b202 100644
--- =
a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -487,7 +487,7 @@
 =
 * write a string to the end of a buffer that was
  * truncated by buf_prin=
tf
  */
-void buf_catrunc(struct buffer *buf, const char *str);
+void buf_c=
atrunc(const struct buffer *buf, const char *str);
 
 /*
  * Parse a string=
 based on a given delimiter char
@@ -774,7 +774,7 @@
 }
 
 static inline in=
t
-buf_peek_u8(struct buffer *buf)
+buf_peek_u8(const struct buffer *buf)
 =
{
     int ret;
     if (BLEN(buf) < 1)
@@ -923,7 +923,7 @@
  * @param excl=
usive Character classes that are not allowed even if they are also in inclu=
sive=2E
  * @return True if the string consists only of allowed characters,=
 false otherwise=2E
  */
-bool string_check_buf(struct buffer *buf, const u=
nsigned int inclusive,
+bool string_check_buf(const struct buffer *buf, con=
st unsigned int inclusive,
                       const unsigned int exclus=
ive);
 
 /**
@@ -1102,7 +1102,7 @@
     }
 
 static inline void
-check_mall=
oc_return(void *p)
+check_malloc_return(const void *p)
 {
     if (!p)
    =
 {
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index 32c13=
25=2E=2Eb465950 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clina=
t=2Ec
@@ -159,7 +159,7 @@
 #endif
 
 static void
-print_pkt(struct openvpn_=
iphdr *iph, const char *prefix, const int direction, const msglvl_t msgleve=
l)
+print_pkt(const struct openvpn_iphdr *iph, const char *prefix, const in=
t direction, const msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new=
();
 
@@ -181,7 +181,7 @@
 }
 
 void
-client_nat_transform(const struct cli=
ent_nat_option_list *list, struct buffer *ipbuf,
+client_nat_transform(cons=
t struct client_nat_option_list *list, const struct buffer *ipbuf,
        =
              const int direction)
 {
     struct ip_tcp_udp_hdr *h =3D (st=
ruct ip_tcp_udp_hdr *)BPTR(ipbuf);
diff --git a/src/openvpn/clinat=2Eh b/sr=
c/openvpn/clinat=2Eh
index 1e8ceb3=2E=2Ebc56037 100644
--- a/src/openvpn/cl=
inat=2Eh
+++ b/src/openvpn/clinat=2Eh
@@ -60,7 +60,7 @@
                   =
                 const char *network, const char *netmask,
                =
                    const char *foreign_network, msglvl_t msglevel);
 
-voi=
d client_nat_transform(const struct client_nat_option_list *list, struct bu=
ffer *ipbuf,
+void client_nat_transform(const struct client_nat_option_list=
 *list, const struct buffer *ipbuf,
                           const int di=
rection);
 
 #endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn/co=
mp=2Ec b/src/openvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 100644
--- a/src/o=
penvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /* U=
SE_COMP */
 
 bool
-check_compression_settings_valid(struct compress_option=
s *info, msglvl_t msglevel)
+check_compression_settings_valid(const struct =
compress_options *info, msglvl_t msglevel)
 {
     /*
      * We also allow=
 comp-stub-v2 here as it technically allows escaping of
diff --git a/src/op=
envpn/comp=2Eh b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead80243 100644
---=
 a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  * fl=
ags of allow-compression and also the whether algorithms are compiled
  * i=
n
  */
-bool check_compression_settings_valid(struct compress_options *info=
, msglvl_t msglevel);
+bool check_compression_settings_valid(const struct c=
ompress_options *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "bu=
ffer=2Eh"
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
inde=
x a9a33c0=2E=2Ee04eedf 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvp=
n/crypto=2Ec
@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct ke=
y *key, const struct key_type *kt)
+key_is_zero(const struct key *key, cons=
t struct key_type *kt)
 {
     size_t cipher_length =3D cipher_kt_key_size(=
kt->cipher);
     for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +=
1123,7 @@
  * Make sure that cipher key is a valid key for current key_type=
=2E
  */
 bool
-check_key(struct key *key, const struct key_type *kt)
+chec=
k_key(const struct key *key, const struct key_type *kt)
 {
     if (cipher_=
defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(s=
truct crypto_options *co, struct frame *frame)
+test_crypto(struct crypto_o=
ptions *co, const struct frame *frame)
 {
     int i, j;
     struct gc_are=
na gc =3D gc_new();
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypt=
o=2Eh
index fbca2a0=2E=2E044f2d2 100644
--- a/src/openvpn/crypto=2Eh
+++ b/=
src/openvpn/crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write_key_file(const i=
nt nkeys, const char *filename);
 
-bool check_key(struct key *key, const s=
truct key_type *kt);
+bool check_key(const struct key *key, const struct ke=
y_type *kt);
 
 /**
  * Initialize a key_type structure with=2E
@@ -609,7 +=
609,7 @@
 /** Print a cipher list entry */
 void print_cipher(const char *c=
ipher);
 
-void test_crypto(struct crypto_options *co, struct frame *f);
+v=
oid test_crypto(struct crypto_options *co, const struct frame *f);
 
 
 /* =
key direction functions */
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/d=
co=2Ec
index 69ce1d7=2E=2Ef509a29 100644
--- a/src/openvpn/dco=2Ec
+++ b/sr=
c/openvpn/dco=2Ec
@@ -556,7 +556,7 @@
 }
 
 static bool
-dco_multi_get_loca=
laddr(struct multi_context *m, struct multi_instance *mi,
+dco_multi_get_lo=
caladdr(const struct multi_context *m, const struct multi_instance *mi,
   =
                      struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKT=
INFO
@@ -568,7 +568,7 @@
         return false;
     }
 
-    struct link_s=
ocket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+    c=
onst struct link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->l=
sa->actual;
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ =
-606,7 +606,7 @@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context *m,=
 struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_cont=
ext *m, struct multi_instance *mi)
 {
     const struct context *c =3D &mi-=
>context;
 
@@ -660,7 +660,7 @@
 }
 
 void
-dco_install_iroute(struct multi=
_context *m, struct multi_instance *mi, struct mroute_addr *addr)
+dco_inst=
all_iroute(struct multi_context *m, struct multi_instance *mi, const struct=
 mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
) || defined(_WIN32)
     if (!dco_enabled(&m->top=2Eoptions))
@@ -779,7 +7=
79,7 @@
         /* Checked if we added a host route as the assigned client=
 IP address was
          * outside the --ifconfig-ipv6 tun interface confi=
g */
 #if !defined(_WIN32)
-        struct in6_addr *dest =3D &mi->context=
=2Ec2=2Epush_ifconfig_ipv6_local;
+        const struct in6_addr *dest =3D =
&mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (multi_check_push=
_ifconfig_ipv6_extra_route(mi, dest))
         {
             /* On windows=
 we do not install these routes, so we also do not need to delete them */
d=
iff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 4e5aad5=2E=2E69=
4875c 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -204,7 =
+204,7 @@
  * @param mi        the client instance
  * @return          0 o=
n success or a negative error code otherwise
  */
-int dco_multi_add_new_pe=
er(struct multi_context *m, struct multi_instance *mi);
+int dco_multi_add_=
new_peer(const struct multi_context *m, struct multi_instance *mi);
 
 /**
=
  * Install an iroute in DCO, which means adding a route to the system rout=
ing
@@ -215,7 +215,7 @@
  * @param addr      the route to add
  */
 void dc=
o_install_iroute(struct multi_context *m, struct multi_instance *mi,
-     =
                   struct mroute_addr *addr);
+                        cons=
t struct mroute_addr *addr);
 
 /**
  * Remove all routes added through the=
 specified client
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and AEAD =
tag at the end=2E
  */
 bool
-dco_supports_epoch_data(struct context *c);
+=
dco_supports_epoch_data(const struct context *c);
 #else  /* if defined(ENA=
BLE_DCO) */
 
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 stati=
c inline int
-dco_multi_add_new_peer(struct multi_context *m, struct multi_=
instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct=
 multi_instance *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 static =
inline bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch=
_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/op=
envpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index d933aaf=2E=2E7346=
903 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=
=2Ec
@@ -930,7 +930,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context=
 *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false=
;
 }
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=
=2Eh
index fcf8aca=2E=2E1022e66 100644
--- a/src/openvpn/dco_internal=2Eh
+=
++ b/src/openvpn/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are implemente=
d by dco_linux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned in=
t peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-            =
     struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const str=
uct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int=
 peerid, socket_descriptor_t sd,
+                 struct sockaddr *localad=
dr, struct sockaddr *remoteaddr,
+                 const struct in_addr *vp=
n_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t=
 *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src=
/openvpn/dco_linux=2Ec
index 56f6259=2E=2E31bbe87 100644
--- a/src/openvpn/=
dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -114,7 +114,7 @@
 }
 
 sta=
tic struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)=

+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
     stru=
ct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -804,7 +804,7 @@
=
 
 /* libnl < 3=2E11=2E0 does not implement nla_get_uint() */
 static uint6=
4_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const struct=
 nlattr *attr)
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
     {
@@=
 -916,7 +916,7 @@
 }
 
 static bool
-ovpn_iface_check(dco_context_t *dco, s=
truct nlattr *attrs[])
+ovpn_iface_check(const dco_context_t *dco, struct n=
lattr *attrs[])
 {
     /* we must know which interface this message is ref=
erring to in order to
      * avoid mixing messages for other instances
@@ =
-1340,7 +1340,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+=
dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
d=
iff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index b3268bc=
=2E=2E8deb9d8 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_wi=
n=2Ec
@@ -1100,7 +1100,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct cont=
ext *c)
+dco_supports_epoch_data(const struct context *c)
 {
     OVPN_VERS=
ION ver =3D { 0 };
     return dco_get_version(&ver) && ((ver=2EMajor =3D=
=3D 2 && ver=2EMinor >=3D 8) || (ver=2EMajor > 2));
diff --git a/src/openvp=
n/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index a54ab3f=2E=2E68173e6 100644
--- a/s=
rc/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -145,7 +145,7 @@
 }
 
 in=
_addr_t
-dhcp_extract_router_msg(struct buffer *ipbuf)
+dhcp_extract_router=
_msg(const struct buffer *ipbuf)
 {
     struct dhcp_full *df =3D (struct d=
hcp_full *)BPTR(ipbuf);
     const int optlen =3D
diff --git a/src/openvpn/=
dhcp=2Eh b/src/openvpn/dhcp=2Eh
index 38ebf8d=2E=2Eed8a0c9 100644
--- a/src=
/openvpn/dhcp=2Eh
+++ b/src/openvpn/dhcp=2Eh
@@ -91,7 +91,7 @@
 
 #pragma p=
ack()
 
-in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);
+in_addr_=
t dhcp_extract_router_msg(const struct buffer *ipbuf);
 
 #if defined(_WIN3=
2) || defined(DHCP_UNIT_TEST)
 #include "tun=2Eh"
diff --git a/src/openvpn/=
event=2Eh b/src/openvpn/event=2Eh
index b784dfe=2E=2E0940a1d 100644
--- a/s=
rc/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@@ -204,7 +204,7 @@
 #else=
 /* ifdef _WIN32 */
 
 static inline void
-wait_signal(struct event_set *es=
, void *arg)
+wait_signal(const struct event_set *es, const void *arg)
 {
 =
}
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 88=
7d7d7=2E=2E1d76859 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/f=
orward=2Ec
@@ -231,7 +231,7 @@
 }
 
 static void
-parse_incoming_control_ch=
annel_command(struct context *c, struct buffer *buf)
+parse_incoming_contro=
l_channel_command(struct context *c, const struct buffer *buf)
 {
     if (=
buf_string_match_head_str(buf, "AUTH_FAILED"))
     {
@@ -501,7 +501,7 @@
 =
}
 
 int
-get_server_poll_remaining_time(struct event_timeout *server_poll_=
timeout)
+get_server_poll_remaining_time(const struct event_timeout *server=
_poll_timeout)
 {
     update_time();
     int remaining =3D event_timeout_=
remaining(server_poll_timeout);
@@ -598,7 +598,7 @@
  * Buffer reallocation=
, for use with null encryption=2E
  */
 static inline void
-buffer_turnover=
(const uint8_t *orig_buf, struct buffer *dest_stub, struct buffer *src_stub=
,
+buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, const=
 struct buffer *src_stub,
                 struct buffer *storage)
 {
     =
if (orig_buf =3D=3D src_stub->data && src_stub->data !=3D storage->data)
@@=
 -885,7 +885,7 @@
  */
 
 static inline void
-socks_postprocess_incoming_li=
nk(struct context *c, struct link_socket *sock)
+socks_postprocess_incoming=
_link(struct context *c, const struct link_socket *sock)
 {
     if (sock->=
socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
     {
@@ -984,7 +984,7=
 @@
 }
 
 bool
-process_incoming_link_part1(struct context *c, struct link_=
socket_info *lsi, bool floated)
+process_incoming_link_part1(struct context=
 *c, const struct link_socket_info *lsi, bool floated)
 {
     struct gc_ar=
ena gc =3D gc_new();
     bool decrypt_status =3D false;
@@ -1534,7 +1534,7=
 @@
  * @param client    Determines whether to the send packet back via tun=
 or link
  */
 void
-ipv6_send_icmp_unreachable(struct context *c, struct b=
uffer *buf, bool client)
+ipv6_send_icmp_unreachable(struct context *c, con=
st struct buffer *buf, bool client)
 {
 #define MAX_ICMPV6LEN 1280
     str=
uct openvpn_icmp6hdr icmp6out;
diff --git a/src/openvpn/forward=2Eh b/src/o=
penvpn/forward=2Eh
index 0d3e492=2E=2Ed8e07fa 100644
--- a/src/openvpn/forw=
ard=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -112,7 +112,7 @@
  */
 void encryp=
t_sign(struct context *c, bool comp_frag);
 
-int get_server_poll_remaining=
_time(struct event_timeout *server_poll_timeout);
+int get_server_poll_rema=
ining_time(const struct event_timeout *server_poll_timeout);
 
 /**********=
************************************************************/
 /**
@@ -163,=
7 +163,7 @@
  *
  * @return true if packet is authenticated, false otherwis=
e=2E
  */
-bool process_incoming_link_part1(struct context *c, struct link_=
socket_info *lsi, bool floated);
+bool process_incoming_link_part1(struct c=
ontext *c, const struct link_socket_info *lsi, bool floated);
 
 /**
  * Co=
ntinues processing a packet read from the external network interface=2E
dif=
f --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 0861cb5=2E=2E41=
fa557 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -817,=
7 +817,7 @@
 }
 
 static void
-init_port_share(struct context *c)
+init_por=
t_share(const struct context *c)
 {
     if (!port_share && (c->options=2Ep=
ort_share_host && c->options=2Eport_share_port))
     {
@@ -1269,7 +1269,7 =
@@
  * prepending to msg() output=2E
  */
 const char *
-format_common_name=
(struct context *c, struct gc_arena *gc)
+format_common_name(const struct c=
ontext *c, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(=
256, gc);
     if (c->c2=2Etls_multi)
@@ -1755,7 +1755,7 @@
 
 
 static boo=
l
-can_preserve_tun(struct tuntap *tt)
+can_preserve_tun(const struct tunta=
p *tt)
 {
     if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@=
 -1777,7 +1777,7 @@
  * @param c pointer to the connection context
  */
 st=
atic void
-add_wfp_block(struct context *c)
+add_wfp_block(const struct con=
text *c)
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gateway block-lo=
cal' with firewall rules? */
@@ -1803,7 +1803,7 @@
  * @param adapter_index=
 the VPN adapter index
  */
 static void
-del_wfp_block(struct context *c, =
unsigned long adapter_index)
+del_wfp_block(const struct context *c, unsign=
ed long adapter_index)
 {
 #if defined(_WIN32)
     if (c->options=2Eblock_=
outside_dns || block_local_needed(c->c1=2Eroute_list))
diff --git a/src/ope=
nvpn/init=2Eh b/src/openvpn/init=2Eh
index 9d5050d=2E=2Eaf4393c 100644
--- =
a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -91,7 +91,7 @@
 
 unsi=
gned int pull_permission_mask(const struct context *c);
 
-const char *form=
at_common_name(struct context *c, struct gc_arena *gc);
+const char *format=
_common_name(const struct context *c, struct gc_arena *gc);
 
 void reset_c=
oarse_timers(struct context *c);
 
diff --git a/src/openvpn/interval=2Eh b/=
src/openvpn/interval=2Eh
index 59051bd=2E=2E0cfe202 100644
--- a/src/openvp=
n/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -89,7 +89,7 @@
 }
 
 stati=
c inline void
-interval_schedule_wakeup(struct interval *top, interval_t *w=
akeup)
+interval_schedule_wakeup(const struct interval *top, interval_t *wa=
keup)
 {
     const time_t local_now =3D now;
     interval_earliest_wakeup=
(wakeup, top->last_test_true + top->refresh, local_now);
@@ -214,7 +214,7 @=
@
  * This function does not check if the timeout is actually valid=2E
  */=

 static inline interval_t
-event_timeout_remaining(struct event_timeout *e=
t)
+event_timeout_remaining(const struct event_timeout *et)
 {
     return =
(interval_t)((et->last + et->n) - now);
 }
diff --git a/src/openvpn/list=2E=
c b/src/openvpn/list=2Ec
index 2e1cf05=2E=2Ec04ee4f 100644
--- a/src/openvp=
n/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -162,7 +162,7 @@
 }
 
 void
-hash_=
remove_by_value(struct hash *hash, void *value)
+hash_remove_by_value(struc=
t hash *hash, const void *value)
 {
     struct hash_iterator hi;
     cons=
t struct hash_element *he;
diff --git a/src/openvpn/list=2Eh b/src/openvpn/=
list=2Eh
index 04cc3ab=2E=2E089637d 100644
--- a/src/openvpn/list=2Eh
+++ b=
/src/openvpn/list=2Eh
@@ -73,7 +73,7 @@
 
 bool hash_remove_fast(struct has=
h *hash, struct hash_bucket *bucket, const void *key, uint32_t hv);
 
-void=
 hash_remove_by_value(struct hash *hash, void *value);
+void hash_remove_by=
_value(struct hash *hash, const void *value);
 
 struct hash_iterator
 {
di=
ff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 604bbcd=2E=
=2E17abfd8 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec=

@@ -330,7 +330,7 @@
 }
 
 static void
-man_delete_unix_socket(struct manag=
ement *man)
+man_delete_unix_socket(const struct management *man)
 {
 #if U=
NIX_SOCK_SUPPORT
     if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNE=
CT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -675,7 +675,7 @@
  * for the log and=
 echo commands=2E
  */
 static void
-man_history(struct management *man, co=
nst char *parm, const char *type, struct log_history *log,
+man_history(str=
uct management *man, const char *parm, const char *type, const struct log_h=
istory *log,
             bool *realtime, const unsigned int lep_flags)
 {
=
     struct gc_arena gc =3D gc_new();
@@ -843,7 +843,7 @@
 }
 
 static void=

-man_forget_passwords(struct management *man)
+man_forget_passwords(const =
struct management *man)
 {
     ssl_purge_auth(false);
     (void)ssl_clean=
_auth_token();
@@ -851,7 +851,7 @@
 }
 
 static void
-man_net(struct manage=
ment *man)
+man_net(const struct management *man)
 {
     if (man->persist=
=2Ecallback=2Eshow_net)
     {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_PKCS11
 
=
 static void
-man_pkcs11_id_count(struct management *man)
+man_pkcs11_id_co=
unt(const struct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d=
", pkcs11_management_id_count());
 }
@@ -1350,7 +1350,7 @@
  * @return     =
     Return whether p has n (or at least n) parameters
  */
 static bool
-m=
an_need(struct management *man, const char **p, const int n, unsigned int f=
lags)
+man_need(const struct management *man, const char **p, const int n, =
unsigned int flags)
 {
     int i;
     ASSERT(p[0]);
@@ -2365,7 +2365,7 @@=

  * the route/ifconfig/open tun command=2E   See doc/android=2Etxt for det=
ails=2E
  */
 bool
-management_android_control(struct management *man, cons=
t char *command, const char *msg)
+management_android_control(const struct =
management *man, const char *command, const char *msg)
 {
     if (!man)
  =
   {
@@ -3013,7 +3013,7 @@
 }
 
 void
-management_up_down(struct management=
 *man, const char *updown, const struct env_set *es)
+management_up_down(co=
nst struct management *man, const char *updown, const struct env_set *es)
 =
{
     if (man->settings=2Eflags & MF_UP_DOWN)
     {
@@ -3023,13 +3023,13 =
@@
 }
 
 void
-management_notify(struct management *man, const char *severi=
ty, const char *type, const char *text)
+management_notify(const struct man=
agement *man, const char *severity, const char *type, const char *text)
 {
=
     msg(M_CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }
 
 void
-m=
anagement_notify_generic(struct management *man, const char *str)
+manageme=
nt_notify_generic(const struct management *man, const char *str)
 {
     ms=
g(M_CLIENT, "%s", str);
 }
@@ -3115,7 +3115,8 @@
 }
 
 void
-management_not=
ify_client_close(struct management *management, struct man_def_auth_context=
 *mdac,
+management_notify_client_close(const struct management *management=
,
+                               struct man_def_auth_context *mdac,
      =
                          const struct env_set *es)
 {
     if ((mdac->flag=
s & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
@@ -3206,7=
 +3207,7 @@
 }
 
 void
-management_auth_failure(struct management *man, con=
st char *type, const char *reason)
+management_auth_failure(const struct ma=
nagement *man, const char *type, const char *reason)
 {
     if (reason)
  =
   {
@@ -3219,7 +3220,7 @@
 }
 
 void
-management_auth_token(struct managem=
ent *man, const char *token)
+management_auth_token(const struct management=
 *man, const char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", =
token);
 }
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
ind=
ex 1be3549=2E=2Eab68968 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openv=
pn/manage=2Eh
@@ -376,12 +376,12 @@
 
 void management_event_loop_n_seconds=
(struct management *man, int sec);
 
-void management_up_down(struct manage=
ment *man, const char *updown, const struct env_set *es);
+void management_=
up_down(const struct management *man, const char *updown, const struct env_=
set *es);
 
-void management_notify(struct management *man, const char *sev=
erity, const char *type,
+void management_notify(const struct management *m=
an, const char *severity, const char *type,
                        const c=
har *text);
 
-void management_notify_generic(struct management *man, const=
 char *str);
+void management_notify_generic(const struct management *man, =
const char *str);
 
 void management_notify_client_needing_auth(struct mana=
gement *management,
                                            const unsig=
ned int auth_id,
@@ -391,7 +391,7 @@
 void management_connection_establishe=
d(struct management *management,
                                        st=
ruct man_def_auth_context *mdac, const struct env_set *es);
 
-void managem=
ent_notify_client_close(struct management *management,
+void management_not=
ify_client_close(const struct management *management,
                     =
                struct man_def_auth_context *mdac, const struct env_set *es=
);
 
 void management_learn_addr(struct management *management, struct man_=
def_auth_context *mdac,
@@ -476,12 +476,12 @@
  * OpenVPN calls here to ind=
icate a password failure
  */
 
-void management_auth_failure(struct manage=
ment *man, const char *type, const char *reason);
+void management_auth_fai=
lure(const struct management *man, const char *type, const char *reason);
 =

 /*
  * Echo an authentication token to management interface
  */
-void ma=
nagement_auth_token(struct management *man, const char *token);
+void manag=
ement_auth_token(const struct management *man, const char *token);
 
 /*
  =
* These functions drive the bytecount in/out counters=2E
diff --git a/src/o=
penvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 5e1b585=2E=2E39f85ba 100644
--=
- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -160,7 +160,7 @@
 }
=
 
 void
-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instan=
ce *mi)
+mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_=
instance *mi)
 {
     if (ms)
     {
diff --git a/src/openvpn/mbuf=2Eh b/sr=
c/openvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 100644
--- a/src/openvpn/mbuf=
=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_item=
(struct mbuf_set *ms, struct mbuf_item *item);
 
-void mbuf_dereference_ins=
tance(struct mbuf_set *ms, struct multi_instance *mi);
+void mbuf_dereferen=
ce_instance(struct mbuf_set *ms, const struct multi_instance *mi);
 
 stati=
c inline bool
 mbuf_defined(const struct mbuf_set *ms)
diff --git a/src/ope=
nvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=2E=2Ea7242a8 100644
--- a/=
src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -43,7 +43,7 @@
  *        =
      if yes, hand to mss_fixup_dowork()
  */
 void
-mss_fixup_ipv4(struct =
buffer *buf, uint16_t maxmss)
+mss_fixup_ipv4(const struct buffer *buf, uin=
t16_t maxmss)
 {
     const struct openvpn_iphdr *pip;
     int hlen;
@@ -8=
0,7 +80,7 @@
  *              (IPv6 header structure is sufficiently differ=
ent from IPv4=2E=2E=2E)
  */
 void
-mss_fixup_ipv6(struct buffer *buf, uint=
16_t maxmss)
+mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss)
 {
=
     const struct openvpn_ipv6hdr *pip6;
     struct buffer newbuf;
@@ -136=
,7 +136,7 @@
  */
 
 void
-mss_fixup_dowork(struct buffer *buf, uint16_t ma=
xmss)
+mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss)
 {
     =
int olen, optlen;
     uint8_t *opt;
@@ -239,8 +239,8 @@
 }
 
 static void
=
-frame_calculate_fragment(struct frame *frame, struct key_type *kt, const s=
truct options *options,
-                         struct link_socket_info *=
lsi)
+frame_calculate_fragment(struct frame *frame, const struct key_type *=
kt, const struct options *options,
+                         const struct l=
ink_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     size_t overhead=
;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_calculate_mssfix(struct fram=
e *frame, struct key_type *kt, const struct options *options,
-            =
           struct link_socket_info *lsi)
+frame_calculate_mssfix(struct fra=
me *frame, const struct key_type *kt, const struct options *options,
+     =
                  const struct link_socket_info *lsi)
 {
     if (options->=
ce=2Emssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void
-frame_calculate_d=
ynamic(struct frame *frame, struct key_type *kt, const struct options *opti=
ons,
-                        struct link_socket_info *lsi)
+frame_calculat=
e_dynamic(struct frame *frame, const struct key_type *kt, const struct opti=
ons *options,
+                        const struct link_socket_info *lsi)
=
 {
     if (options->ce=2Efragment > 0)
     {
diff --git a/src/openvpn/mss=
=2Eh b/src/openvpn/mss=2Eh
index 1d092bb=2E=2E6b832a2 100644
--- a/src/open=
vpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -29,15 +29,15 @@
 #include "socket=
=2Eh"
 #include "ssl_common=2Eh"
 
-void mss_fixup_ipv4(struct buffer *buf,=
 uint16_t maxmss);
+void mss_fixup_ipv4(const struct buffer *buf, uint16_t =
maxmss);
 
-void mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss);
+void=
 mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss);
 
-void mss_fix=
up_dowork(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_dowork(cons=
t struct buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix option=2E *=
/
-void frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
-=
                             const struct options *options, struct link_soc=
ket_info *lsi);
+void frame_calculate_dynamic(struct frame *frame, const st=
ruct key_type *kt,
+                             const struct options *opti=
ons, const struct link_socket_info *lsi);
 
 /**
  * Checks and adjusts the=
 fragment and mssfix value according to the
diff --git a/src/openvpn/mtcp=
=2Ec b/src/openvpn/mtcp=2Ec
index df94a70=2E=2Ed9f14b3 100644
--- a/src/ope=
nvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -91,7 +91,7 @@
 }
 
 bool
-mult=
i_tcp_instance_specific_init(struct multi_context *m, struct multi_instance=
 *mi)
+multi_tcp_instance_specific_init(const struct multi_context *m, stru=
ct multi_instance *mi)
 {
     /* buffer for queued TCP socket output packe=
ts */
     mi->tcp_link_out_deferred =3D mbuf_init(m->top=2Eoptions=2En_bca=
st_buf);
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index 9b7=
d1d2=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=
=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_instance(struct multi_=
io *multi_io, struct multi_instance *mi);
 
-bool multi_tcp_instance_specif=
ic_init(struct multi_context *m, struct multi_instance *mi);
+bool multi_tc=
p_instance_specific_init(const struct multi_context *m, struct multi_instan=
ce *mi);
 
 void multi_tcp_instance_specific_free(struct multi_instance *mi=
);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 50d72d5=
=2E=2E4828a17 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -39,7 +39,7 @@
 
 static void
 send_hmac_reset_packet(struct multi_conte=
xt *m, struct tls_pre_decrypt_state *state,
-                       struct =
tls_auth_standalone *tas, struct session_id *sid,
+                       c=
onst struct tls_auth_standalone *tas, const struct session_id *sid,
       =
                 bool request_resend_wkc)
 {
     reset_packet_id_send(&sta=
te->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
@@ -69,7 +69,7 @@
 
     enum f=
irst_packet_verdict verdict;
 
-    struct tls_auth_standalone *tas =3D m->=
top=2Ec2=2Etls_auth_standalone;
+    const struct tls_auth_standalone *tas =
=3D m->top=2Ec2=2Etls_auth_standalone;
 
     verdict =3D tls_pre_decrypt_l=
ite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index c72c4b2=2E=2Edd4d61d 1006=
44
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -57,7 +57,7 @=
@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const char *
-id(struct multi_in=
stance *mi)
+id(const struct multi_instance *mi)
 {
     if (mi)
     {
@@ =
-1315,7 +1315,7 @@
  * same common name=2E
  */
 static void
-multi_delete_=
dup(struct multi_context *m, struct multi_instance *new_mi)
+multi_delete_d=
up(struct multi_context *m, const struct multi_instance *new_mi)
 {
     if=
 (new_mi)
     {
@@ -2260,7 +2260,7 @@
 }
 
 static bool
-multi_client_setu=
p_dco_initial(struct multi_context *m, struct multi_instance *mi,
+multi_cl=
ient_setup_dco_initial(const struct multi_context *m, struct multi_instance=
 *mi,
                                struct gc_arena *gc)
 {
     if (!dco=
_enabled(&mi->context=2Eoptions))
@@ -3195,7 +3195,7 @@
 
 #if defined(ENAB=
LE_DCO)
 static void
-process_incoming_del_peer(struct multi_context *m, st=
ruct multi_instance *mi, dco_context_t *dco)
+process_incoming_del_peer(str=
uct multi_context *m, struct multi_instance *mi, const dco_context_t *dco)
=
 {
     const char *reason =3D "ovpn-dco: unknown reason";
     switch (dco=
->dco_del_peer_reason)
@@ -4226,7 +4226,7 @@
 
 /* Searches for the address=
 and deletes it if it is owned by the multi_instance */
 static void
-multi=
_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const str=
uct mroute_addr *addr)
+multi_unlearn_addr(struct multi_context *m, const s=
truct multi_instance *mi, const struct mroute_addr *addr)
 {
     struct ha=
sh_element *he;
     const uint32_t hv =3D hash_value(m->vhash, addr);
@@ -=
4261,7 +4261,7 @@
  * @param a     The new IPv4 address in network byte ord=
er
  */
 static void
-multi_unlearn_in_addr_t(struct multi_context *m, stru=
ct multi_instance *mi, in_addr_t a)
+multi_unlearn_in_addr_t(struct multi_c=
ontext *m, const struct multi_instance *mi, in_addr_t a)
 {
     struct mro=
ute_addr addr;
     CLEAR(addr);
@@ -4279,7 +4279,7 @@
  * @param a6    The=
 new IPv6 address
  */
 static void
-multi_unlearn_in6_addr(struct multi_co=
ntext *m, struct multi_instance *mi, struct in6_addr a6)
+multi_unlearn_in6=
_addr(struct multi_context *m, const struct multi_instance *mi, struct in6_=
addr a6)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4395,7 +439=
5,7 @@
 
 bool
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_ins=
tance *mi,
-                                           struct in6_addr *des=
t)
+                                           const struct in6_addr *dest)=

 {
     const struct options *o =3D &mi->context=2Eoptions;
 
diff --git a=
/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3ed08d4=2E=2Ecd7aa3e 1=
00644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -520,7 +52=
0,7 @@
  */
 
 static inline void
-set_prefix(struct multi_instance *mi)
+s=
et_prefix(const struct multi_instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOO=
P
     if (mi->msg_prefix[0])
@@ -694,7 +694,7 @@
  */
 bool
 multi_check_p=
ush_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                 =
                          struct in6_addr *dest);
+                        =
                   const struct in6_addr *dest);
 
 /*
  * Check for signal=
s=2E
diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
i=
ndex bce0c19=2E=2E25233c8 100644
--- a/src/openvpn/networking=2Eh
+++ b/src=
/openvpn/networking=2Eh
@@ -44,7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE=
)
 static inline int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ct=
x)
+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     (=
void)c;
     (void)ctx;
@@ -75,7 +75,7 @@
  *
  * @return          0 on suc=
cess, a negative error code otherwise
  */
-int net_ctx_init(struct context=
 *c, openvpn_net_ctx_t *ctx);
+int net_ctx_init(const struct context *c, op=
envpn_net_ctx_t *ctx);
 
 /**
  * Release resources allocated by the intern=
al garbage collector
@@ -102,7 +102,7 @@
  * @return          0 on success,=
 negative error code on error
  */
 int net_iface_new(openvpn_net_ctx_t *ct=
x, const openvpn_net_iface_t *iface, const char *type,
-                  v=
oid *arg);
+                  const void *arg);
 
 /**
  * Retrieve the int=
erface type
diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/=
networking_iproute2=2Ec
index a1f3525=2E=2Ef091fb3 100644
--- a/src/openvpn=
/networking_iproute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -36,7=
 +36,7 @@
 #include <netinet/in=2Eh>
 
 int
-net_ctx_init(struct context *c=
, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct context *c, openvpn_ne=
t_ctx_t *ctx)
 {
     ctx->es =3D NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
=
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *=
type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, =
const char *type, const void *arg)
 {
     struct argv argv =3D argv_new();=

 
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_s=
itnl=2Ec
index e6e72d0=2E=2Ea1d220f 100644
--- a/src/openvpn/networking_sit=
nl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -987,7 +987,7 @@
 }
 
 sta=
tic int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_addr=
ess_t *addr, int prefixlen)
+sitnl_addr_del(sa_family_t af_family, const ch=
ar *iface, const inet_address_t *addr, int prefixlen)
 {
     int ifindex;
=
 
@@ -1230,8 +1230,8 @@
 }
 
 static int
-sitnl_route_del(const char *iface=
, sa_family_t af_family, inet_address_t *dst, int prefixlen,
-             =
   inet_address_t *gw, uint32_t table, int metric)
+sitnl_route_del(const c=
har *iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen=
,
+                const inet_address_t *gw, uint32_t table, int metric)
 {=

     int ifindex =3D 0;
 
@@ -1308,7 +1308,7 @@
 
 
 int
-net_iface_new(op=
envpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)
+net_=
iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, cons=
t void *arg)
 {
     struct sitnl_link_req req =3D {};
     int ret =3D -1;=

diff --git a/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh
index bda4f18=2E=2E=
49def4d 100644
--- a/src/openvpn/occ=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,=
7 +156,7 @@
  * via control channel=2E
  * @return control channel exit mes=
sage should be used */
 static inline bool
-cc_exit_notify_enabled(struct c=
ontext *c)
+cc_exit_notify_enabled(const struct context *c)
 {
     /* Chec=
k if we have TLS active at all */
     if (!c->c2=2Etls_multi)
diff --git a=
/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 3494=
ce6=2E=2E32e0b6f 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/open=
vpn/openssl_compat=2Eh
@@ -124,7 +124,7 @@
 /* Mimics the functions but onl=
y when the default context without
  * options is chosen */
 static inline =
const EVP_CIPHER *
-EVP_CIPHER_fetch(void *ctx, const char *algorithm, cons=
t char *properties)
+EVP_CIPHER_fetch(const void *ctx, const char *algorith=
m, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
=
@@ -132,7 +132,7 @@
 }
 
 static inline const EVP_MD *
-EVP_MD_fetch(void *=
ctx, const char *algorithm, const char *properties)
+EVP_MD_fetch(const voi=
d *ctx, const char *algorithm, const char *properties)
 {
     ASSERT(!ctx)=
;
     ASSERT(!properties);
diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec
index fd0d3fc=2E=2E6d85a23 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3050,7 +3050,7 @@
 }
 
 static void
=
-options_postprocess_mutate_le(struct connection_entry *ce, struct local_en=
try *le, int mode)
+options_postprocess_mutate_le(const struct connection_e=
ntry *ce, struct local_entry *le, int mode)
 {
     /* use the global port =
if none is specified */
     if (!le->port)
@@ -4980,7 +4980,7 @@
 static b=
ool
 verify_permission(const char *name, const char *file, int line, const =
uint64_t type,
                   const uint64_t allowed, uint64_t *found, =
const msglvl_t msglevel,
-                  struct options *options, bool i=
s_inline)
+                  const struct options *options, bool is_inline)=

 {
     if (!(type & allowed))
     {
@@ -5547,7 +5547,7 @@
 }
 
 static v=
oid
-show_compression_warning(struct compress_options *info)
+show_compress=
ion_warning(const struct compress_options *info)
 {
     if (comp_non_stub_=
enabled(info))
     {
diff --git a/src/openvpn/options_parse=2Ec b/src/open=
vpn/options_parse=2Ec
index 88ab4d2=2E=2E0e94522 100644
--- a/src/openvpn/o=
ptions_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -258,7 +258,7 @@
 }=

 
 static char *
-read_inline_file(struct in_src *is, const char *close_ta=
g, int *num_lines, struct gc_arena *gc)
+read_inline_file(const struct in_s=
rc *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
 {
    =
 char line[OPTION_LINE_SIZE];
     struct buffer buf =3D alloc_buf(8 * OPTI=
ON_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 static int
-check_inline_file(stru=
ct in_src *is, char *p[], struct gc_arena *gc)
+check_inline_file(const str=
uct in_src *is, char *p[], struct gc_arena *gc)
 {
     int num_inline_line=
s =3D 0;
 
diff --git a/src/openvpn/otime=2Ec b/src/openvpn/otime=2Ec
index=
 1608458=2E=2E5d3633c 100644
--- a/src/openvpn/otime=2Ec
+++ b/src/openvpn/=
otime=2Ec
@@ -66,7 +66,7 @@
 }
 
 void
-update_now_usec(struct timeval *tv)=

+update_now_usec(const struct timeval *tv)
 {
     const time_t last =3D n=
ow;
     update_now(tv->tv_sec);
diff --git a/src/openvpn/otime=2Eh b/src/o=
penvpn/otime=2Eh
index 84e315b=2E=2Eb5a9f7c 100644
--- a/src/openvpn/otime=
=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -65,7 +65,7 @@
 void update_now(const t=
ime_t system_time);
 
 extern time_t now_usec;
-void update_now_usec(struct=
 timeval *tv);
+void update_now_usec(const struct timeval *tv);
 
 static i=
nline int
 openvpn_gettimeofday(struct timeval *tv, void *tz)
diff --git a/=
src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 3570582=2E=2E33bf4ea 10=
0644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -248,7 +248=
,7 @@
  * and offset of IP header (via parameter)=2E
  */
 static inline in=
t
-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)
=
+get_tun_ip_ver(int tunnel_type, const struct buffer *buf, int *ip_hdr_offs=
et)
 {
     int ip_ver =3D -1;
 
diff --git a/src/openvpn/proxy=2Ec b/src/o=
penvpn/proxy=2Ec
index 4de7615=2E=2Ed4e0a8b 100644
--- a/src/openvpn/proxy=
=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -527,8 +527,9 @@
 }
 
 static bool
-add=
_proxy_headers(struct http_proxy_info *p, socket_descriptor_t sd, /* alread=
y open to proxy */
-                  const char *host                     =
              /* openvpn server remote */
+add_proxy_headers(const struct h=
ttp_proxy_info *p,
+                  socket_descriptor_t sd, /* already op=
en to proxy */
+                  const char *host        /* openvpn server=
 remote */
 )
 {
     char buf[512];
@@ -597,8 +598,8 @@
                  =
             socket_descriptor_t sd, /* already open to proxy */
          =
                     const char *host,       /* openvpn server remote */
  =
                             const char *port,       /* openvpn server port=
 */
-                              struct event_timeout *server_poll_timeou=
t, struct buffer *lookahead,
-                              struct signal_i=
nfo *sig_info)
+                              const struct event_timeout *s=
erver_poll_timeout,
+                              struct buffer *lookahead=
, struct signal_info *sig_info)
 {
     struct gc_arena gc =3D gc_new();
  =
   char buf[512];
diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2E=
h
index e662e7d=2E=2Ea2f4e47 100644
--- a/src/openvpn/proxy=2Eh
+++ b/src/o=
penvpn/proxy=2Eh
@@ -89,7 +89,7 @@
                                    sock=
et_descriptor_t sd, /* already open to proxy */
                           =
         const char *host,       /* openvpn server remote */
              =
                      const char *port,       /* openvpn server port */
-  =
                                 struct event_timeout *server_poll_timeout,=

+                                   const struct event_timeout *server_pol=
l_timeout,
                                    struct buffer *lookahead, st=
ruct signal_info *sig_info);
 
 uint8_t *make_base64_string2(const uint8_t =
*str, int str_len, struct gc_arena *gc);
diff --git a/src/openvpn/ps=2Ec b/=
src/openvpn/ps=2Ec
index 57afacd=2E=2E0e581e5 100644
--- a/src/openvpn/ps=
=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -332,7 +332,7 @@
  * the proxy can determi=
ne true client origin=2E
  */
 static void
-journal_add(const char *journal=
_dir, struct proxy_connection *pc, struct proxy_connection *cp)
+journal_ad=
d(const char *journal_dir, const struct proxy_connection *pc, struct proxy_=
connection *cp)
 {
     struct openvpn_sockaddr from, to;
 
@@ -410,7 +410,=
7 @@
 static bool
 proxy_entry_new(struct proxy_connection **list, struct e=
vent_set *es,
                 const struct openvpn_sockaddr server_addr, c=
onst socket_descriptor_t sd_client,
-                struct buffer *initial=
_data, const char *journal_dir)
+                const struct buffer *initi=
al_data, const char *journal_dir)
 {
     socket_descriptor_t sd_server;
  =
   int status;
@@ -1013,7 +1013,7 @@
  * call=2E
  */
 void
-port_share_red=
irect(struct port_share *ps, const struct buffer *head, socket_descriptor_t=
 sd)
+port_share_redirect(const struct port_share *ps, const struct buffer =
*head, socket_descriptor_t sd)
 {
     if (ps)
     {
diff --git a/src/open=
vpn/ps=2Eh b/src/openvpn/ps=2Eh
index 557ecf5=2E=2E918ceb6 100644
--- a/src=
/openvpn/ps=2Eh
+++ b/src/openvpn/ps=2Eh
@@ -49,7 +49,7 @@
 
 bool is_openv=
pn_protocol(const struct buffer *buf);
 
-void port_share_redirect(struct p=
ort_share *ps, const struct buffer *head, socket_descriptor_t sd);
+void po=
rt_share_redirect(const struct port_share *ps, const struct buffer *head, s=
ocket_descriptor_t sd);
 
 #endif /* if PORT_SHARE */
 #endif /* ifndef PS_=
H */
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index a030acd=
=2E=2E373272f 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
=
@@ -435,7 +435,7 @@
 #endif
 
 bool
-send_auth_pending_messages(struct tls_=
multi *tls_multi, struct tls_session *session,
+send_auth_pending_messages(=
const struct tls_multi *tls_multi, struct tls_session *session,
           =
                 const char *extra, unsigned int timeout)
 {
     struct ke=
y_state *ks =3D &session->key[KS_PRIMARY];
diff --git a/src/openvpn/push=2E=
h b/src/openvpn/push=2Eh
index dff945f=2E=2E39302f6 100644
--- a/src/openvp=
n/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -117,7 +117,7 @@
  * doc/managemen=
t-notes=2Etxt under client-pending-auth for
  * more details on message for=
mat
  */
-bool send_auth_pending_messages(struct tls_multi *tls_multi, stru=
ct tls_session *session,
+bool send_auth_pending_messages(const struct tls_=
multi *tls_multi, struct tls_session *session,
                            =
     const char *extra, unsigned int timeout);
 
 void send_restart(struct =
context *c, const char *kill_msg);
diff --git a/src/openvpn/push_util=2Ec b=
/src/openvpn/push_util=2Ec
index af22af5=2E=2E008d45f 100644
--- a/src/open=
vpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -222,7 +222,7 @@
 
 /*=
 Return true if the client supports push-update */
 static bool
-support_pu=
sh_update(struct multi_instance *mi)
+support_push_update(const struct mult=
i_instance *mi)
 {
     ASSERT(mi->context=2Ec2=2Etls_multi);
     const un=
signed int iv_proto_peer =3D extract_iv_proto(mi->context=2Ec2=2Etls_multi-=
>peer_info);
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec
index 52adacf=2E=2E3588483 100644
--- a/src/openvpn/reliable=2Ec
+++ b=
/src/openvpn/reliable=2Ec
@@ -92,7 +92,7 @@
 
 /* check if a particular pac=
ket_id is present in ack */
 static inline bool
-reliable_ack_packet_id_pre=
sent(struct reliable_ack *ack, packet_id_type pid)
+reliable_ack_packet_id_=
present(const struct reliable_ack *ack, packet_id_type pid)
 {
     for (in=
t i =3D 0; i < ack->len; ++i)
     {
@@ -733,7 +733,7 @@
  */
 
 void
-reli=
able_mark_active_incoming(struct reliable *rel, struct buffer *buf, packet_=
id_type pid,
+reliable_mark_active_incoming(struct reliable *rel, const str=
uct buffer *buf, packet_id_type pid,
                               int opc=
ode)
 {
     for (int i =3D 0; i < rel->size; ++i)
@@ -793,7 +793,7 @@
 
 /=
* delete a buffer previously activated by reliable_mark_active() */
 void
-=
reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
+reliable_m=
ark_deleted(struct reliable *rel, const struct buffer *buf)
 {
     for (in=
t i =3D 0; i < rel->size; ++i)
     {
diff --git a/src/openvpn/reliable=2Eh=
 b/src/openvpn/reliable=2Eh
index a5ed75c=2E=2E8d9e2e3 100644
--- a/src/ope=
nvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -173,7 +173,7 @@
  * @l=
i False, if there are packet IDs to be acknowledged=2E
  */
 static inline =
bool
-reliable_ack_empty(struct reliable_ack *ack)
+reliable_ack_empty(cons=
t struct reliable_ack *ack)
 {
     return !ack->len;
 }
@@ -186,7 +186,7 @=
@
  * @returns the number of outstanding acks
  */
 static inline int
-reli=
able_ack_outstanding(struct reliable_ack *ack)
+reliable_ack_outstanding(co=
nst struct reliable_ack *ack)
 {
     return ack->len;
 }
@@ -336,7 +336,7 =
@@
  * @param pid The packet's packet ID=2E
  * @param opcode The packet's =
opcode=2E
  */
-void reliable_mark_active_incoming(struct reliable *rel, st=
ruct buffer *buf, packet_id_type pid,
+void reliable_mark_active_incoming(s=
truct reliable *rel, const struct buffer *buf, packet_id_type pid,
        =
                            int opcode);
 
 /**
@@ -389,7 +389,7 @@
  * @pa=
ram rel The reliable structure associated with the given buffer=2E
  * @par=
am buf The buffer of the reliable entry which is to be removed=2E
  */
-voi=
d reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
+void re=
liable_mark_deleted(struct reliable *rel, const struct buffer *buf);
 
 /**=
 @} name Functions for extracting incoming packets */
 
diff --git a/src/op=
envpn/route=2Ec b/src/openvpn/route=2Ec
index 1d3ea86=2E=2E590d844 100644
-=
-- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -898,8 +898,9 @@
=
 }
 
 static bool
-add_bypass_routes(struct route_bypass *rb, in_addr_t gat=
eway, const struct tuntap *tt,
-                  unsigned int flags, const=
 struct route_gateway_info *rgi,
+add_bypass_routes(const struct route_bypa=
ss *rb, in_addr_t gateway,
+                  const struct tuntap *tt, unsi=
gned int flags,
+                  const struct route_gateway_info *rgi,
  =
                 const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     =
int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 static void
-del_bypass_routes(=
struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-     =
             unsigned int flags, const struct route_gateway_info *rgi,
+del=
_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,
+         =
         const struct tuntap *tt, unsigned int flags,
+                  co=
nst struct route_gateway_info *rgi,
                   const struct env_set=
 *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ -3942,7 +3944,7 @@
 #else  =
/* if defined(_WIN32) */
 
 static void
-get_bypass_addresses(struct route_=
bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */
+get_bypass_a=
ddresses(struct route_bypass *rb, const unsigned int flags)
 {
 }
 
diff --=
git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6d9bb62=2E=
=2Ec29009e 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=
=2Ec
@@ -501,7 +501,7 @@
 }
 
 int
-schedule_debug(struct schedule *s, int =
*count, struct timeval *least)
+schedule_debug(const struct schedule *s, in=
t *count, struct timeval *least)
 {
     struct timeval min;
     struct ti=
meval max;
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
ind=
ex 0382aea=2E=2E5474e94 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openv=
pn/socket=2Ec
@@ -647,7 +647,7 @@
 }
 
 static void
-bind_local(struct link=
_socket *sock, const sa_family_t ai_family)
+bind_local(const struct link_s=
ocket *sock, const sa_family_t ai_family)
 {
     /* bind to local address/=
port */
     if (sock->bind_local)
@@ -914,8 +914,8 @@
 }
 
 void
-socket_b=
ind(socket_descriptor_t sd, struct addrinfo *local, int ai_family, const ch=
ar *prefix,
-            bool ipv6only)
+socket_bind(socket_descriptor_t sd=
, const struct addrinfo *local, int ai_family,
+            const char *pre=
fix, bool ipv6only)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -1123,8 +=
1123,8 @@
  * such as TCP=2E
  */
 
-static void stream_buf_init(struct str=
eam_buf *sb, struct buffer *buf, const unsigned int sockflags,
-           =
                 const int proto);
+static void stream_buf_init(struct stre=
am_buf *sb, const struct buffer *buf,
+                            const un=
signed int sockflags, const int proto);
 
 static void stream_buf_close(str=
uct stream_buf *sb);
 
@@ -1481,7 +1481,7 @@
 }
 
 static void
-phase2_set_=
socket_flags(struct link_socket *sock)
+phase2_set_socket_flags(const struc=
t link_socket *sock)
 {
     /* set misc socket parameters */
     socket_s=
et_flags(sock->sd, sock->sockflags);
@@ -2073,7 +2073,7 @@
 }
 
 static voi=
d
-stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigne=
d int sockflags,
+stream_buf_init(struct stream_buf *sb, const struct buffe=
r *buf, const unsigned int sockflags,
                 const int proto)
 {
=
     sb->buf_init =3D *buf;
@@ -2337,7 +2337,7 @@
 #endif
 
 static socklen=
_t
-link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct buf=
fer *buf,
+link_socket_read_udp_posix_recvmsg(const struct link_socket *soc=
k, struct buffer *buf,
                                    struct link_sock=
et_actual *from)
 {
     struct iovec iov;
@@ -2405,7 +2405,7 @@
 #endif /*=
 if ENABLE_IP_PKTINFO */
 
 int
-link_socket_read_udp_posix(struct link_soc=
ket *sock, struct buffer *buf,
+link_socket_read_udp_posix(const struct lin=
k_socket *sock, struct buffer *buf,
                            struct link=
_socket_actual *from)
 {
     socklen_t fromlen =3D sizeof(from->dest=2Eadd=
r);
@@ -2462,7 +2462,7 @@
 #if ENABLE_IP_PKTINFO
 
 ssize_t
-link_socket_wr=
ite_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,
+link_s=
ocket_write_udp_posix_sendmsg(const struct link_socket *sock, const struct =
buffer *buf,
                                     struct link_socket_actual=
 *to)
 {
     struct iovec iov;
@@ -2656,7 +2656,7 @@
 }
 
 int
-socket_sen=
d_queue(struct link_socket *sock, struct buffer *buf, const struct link_soc=
ket_actual *to)
+socket_send_queue(struct link_socket *sock, const struct b=
uffer *buf, const struct link_socket_actual *to)
 {
     if (sock->writes=
=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -2756,8 +2756,8 @@
     return=
 sock->writes=2Eiostate;
 }
 
-void
-read_sockaddr_from_overlapped(struct o=
verlapped_io *io, struct sockaddr *dst, int overlapped_ret)
+static void
+r=
ead_sockaddr_from_overlapped(const struct overlapped_io *io, struct sockadd=
r *dst, int overlapped_ret)
 {
     if (overlapped_ret >=3D 0 && io->addr_d=
efined)
     {
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh=

index 71a3595=2E=2E6771ec5 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/o=
penvpn/socket=2Eh
@@ -267,7 +267,7 @@
 
 int socket_recv_queue(struct link_=
socket *sock, int maxsize);
 
-int socket_send_queue(struct link_socket *so=
ck, struct buffer *buf,
+int socket_send_queue(struct link_socket *sock, co=
nst struct buffer *buf,
                       const struct link_socket_act=
ual *to);
 
 typedef struct
@@ -347,8 +347,8 @@
 
 struct link_socket *link=
_socket_new(void);
 
-void socket_bind(socket_descriptor_t sd, struct addri=
nfo *local, int af_family, const char *prefix,
-                 bool ipv6o=
nly);
+void socket_bind(socket_descriptor_t sd, const struct addrinfo *loca=
l, int af_family,
+                 const char *prefix, bool ipv6only);
 
 =
int openvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, =
int connect_timeout,
                     volatile int *signal_received);
@=
@ -484,7 +484,7 @@
 }
 
 static inline bool
-link_socket_verify_incoming_ad=
dr(struct buffer *buf, const struct link_socket_info *info,
+link_socket_ve=
rify_incoming_addr(const struct buffer *buf, const struct link_socket_info =
*info,
                                  const struct link_socket_actual *f=
rom_addr)
 {
     if (buf->len > 0)
@@ -608,7 +608,7 @@
 
 #else  /* ifdef =
_WIN32 */
 
-int link_socket_read_udp_posix(struct link_socket *sock, struc=
t buffer *buf,
+int link_socket_read_udp_posix(const struct link_socket *so=
ck, struct buffer *buf,
                                struct link_socket_=
actual *from);
 
 #endif /* ifdef _WIN32 */
@@ -694,12 +694,12 @@
 
 #else =
/* ifdef _WIN32 */
 
-ssize_t link_socket_write_udp_posix_sendmsg(struct li=
nk_socket *sock, struct buffer *buf,
+ssize_t link_socket_write_udp_posix_s=
endmsg(const struct link_socket *sock, const struct buffer *buf,
          =
                                   struct link_socket_actual *to);
 
 
 sta=
tic inline ssize_t
-link_socket_write_udp_posix(struct link_socket *sock, s=
truct buffer *buf,
+link_socket_write_udp_posix(const struct link_socket *s=
ock, const struct buffer *buf,
                             struct link_soc=
ket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@ -715,7 +715,7 @@
 }
 
 static =
inline ssize_t
-link_socket_write_tcp_posix(struct link_socket *sock, struc=
t buffer *buf)
+link_socket_write_tcp_posix(const struct link_socket *sock,=
 const struct buffer *buf)
 {
     return send(sock->sd, BPTR(buf), BLENZ(b=
uf), MSG_NOSIGNAL);
 }
@@ -773,7 +773,7 @@
  * from tunnel packet=2E
  */
 =
static inline void
-link_socket_set_tos(struct link_socket *sock)
+link_soc=
ket_set_tos(const struct link_socket *sock)
 {
     if (sock && sock->ptos_=
defined)
     {
@@ -819,6 +819,8 @@
     }
 }
 
+/* cppcheck-suppress const=
ParameterPointer
+ * sock is modified on Windows via &sock->listen_handle *=
/
 static inline void
 socket_reset_listen_persistent(struct link_socket *s=
ock)
 {
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=
=2Eh
index 13f5962=2E=2Eadd08ba 100644
--- a/src/openvpn/socket_util=2Eh
++=
+ b/src/openvpn/socket_util=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool=

-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *=
addr_list, const int proto)
+addrlist_match_proto(const struct openvpn_sock=
addr *a1, const struct addrinfo *addr_list, const int proto)
 {
     return=
 link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, addr_lis=
t)
                                                         : addrlist_port=
_match(a1, addr_list);
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/soc=
ks=2Ec
index 19f3d54=2E=2E77ca863 100644
--- a/src/openvpn/socks=2Ec
+++ b/=
src/openvpn/socks=2Ec
@@ -82,7 +82,7 @@
 
 static bool
 socks_proxy_recv_ch=
ar(uint8_t *c, const char *name, socket_descriptor_t sd,
-                 =
     struct event_timeout *server_poll_timeout,
+                      cons=
t struct event_timeout *server_poll_timeout,
                       volatil=
e int *signal_received)
 {
     fd_set reads;
@@ -97,8 +97,8 @@
 }
 
 stati=
c bool
-socks_username_password_auth(struct socks_proxy_info *p, socket_des=
criptor_t sd,
-                             struct event_timeout *server_po=
ll_timeout,
+socks_username_password_auth(const struct socks_proxy_info *p,=
 socket_descriptor_t sd,
+                             const struct event_t=
imeout *server_poll_timeout,
                              volatile int *si=
gnal_received)
 {
     char to_send[516];
@@ -156,8 +156,8 @@
 }
 
 static =
bool
-socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,
-=
                struct event_timeout *server_poll_timeout, volatile int *si=
gnal_received)
+socks_handshake(const struct socks_proxy_info *p, socket_de=
scriptor_t sd,
+                const struct event_timeout *server_poll_tim=
eout, volatile int *signal_received)
 {
     uint8_t buf[2];
     int len =
=3D 0;
@@ -231,7 +231,7 @@
 
 static bool
 recv_socks_reply(socket_descript=
or_t sd, struct openvpn_sockaddr *addr,
-                 struct event_time=
out *server_poll_timeout, volatile int *signal_received)
+                 =
const struct event_timeout *server_poll_timeout, volatile int *signal_recei=
ved)
 {
     uint8_t atyp =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@=

 }
 
 void
-establish_socks_proxy_passthru(struct socks_proxy_info *p,
+es=
tablish_socks_proxy_passthru(const struct socks_proxy_info *p,
            =
                    socket_descriptor_t sd, /* already open to proxy */
   =
                             const char *host,       /* openvpn server remo=
te */
                                const char *servname,   /* openvpn se=
rver port */
-                               struct event_timeout *server_p=
oll_timeout,
+                               const struct event_timeout *se=
rver_poll_timeout,
                                struct signal_info *sig_=
info)
 {
     char buf[270];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_so=
cks_proxy_udpassoc(struct socks_proxy_info *p,
+establish_socks_proxy_udpas=
soc(const struct socks_proxy_info *p,
                                socke=
t_descriptor_t ctrl_sd, /* already open to proxy */
                       =
         struct openvpn_sockaddr *relay_addr,
-                            =
   struct event_timeout *server_poll_timeout,
+                            =
   const struct event_timeout *server_poll_timeout,
                       =
         struct signal_info *sig_info)
 {
     if (!socks_handshake(p, ctrl=
_sd, server_poll_timeout, &sig_info->signal_received))
diff --git a/src/ope=
nvpn/socks=2Eh b/src/openvpn/socks=2Eh
index 846113d=2E=2Ef7c93b6 100644
--=
- a/src/openvpn/socks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -47,17 +47,17 @@
 =

 void socks_proxy_close(struct socks_proxy_info *sp);
 
-void establish_so=
cks_proxy_passthru(struct socks_proxy_info *p,
+void establish_socks_proxy_=
passthru(const struct socks_proxy_info *p,
                                =
     socket_descriptor_t sd, /* already open to proxy */
                  =
                   const char *host,       /* openvpn server remote */
    =
                                 const char *servname,   /* openvpn server =
port */
-                                    struct event_timeout *server_p=
oll_timeout,
+                                    const struct event_timeou=
t *server_poll_timeout,
                                     struct signal_=
info *sig_info);
 
-void establish_socks_proxy_udpassoc(struct socks_proxy_=
info *p,
+void establish_socks_proxy_udpassoc(const struct socks_proxy_info=
 *p,
                                     socket_descriptor_t ctrl_sd, /* a=
lready open to proxy */
                                     struct openvpn=
_sockaddr *relay_addr,
-                                    struct event_ti=
meout *server_poll_timeout,
+                                    const stru=
ct event_timeout *server_poll_timeout,
                                    =
 struct signal_info *sig_info);
 
 void socks_process_incoming_udp(struct b=
uffer *buf, struct link_socket_actual *from);
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 7f3b4dc=2E=2E262522b 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1159,7 +1159,7 @@
 }
 
 struct tl=
s_multi *
-tls_multi_init(struct tls_options *tls_options)
+tls_multi_init(=
const struct tls_options *tls_options)
 {
     struct tls_multi *ret;
 
@@ =
-1188,7 +1188,7 @@
  */
 
 struct tls_auth_standalone *
-tls_auth_standalon=
e_init(struct tls_options *tls_options, struct gc_arena *gc)
+tls_auth_stan=
dalone_init(const struct tls_options *tls_options, struct gc_arena *gc)
 {
=
     struct tls_auth_standalone *tas;
 
@@ -1336,7 +1336,7 @@
 
 static voi=
d
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,
-                bool server, struct key2 *key2)
+ =
               bool server, const struct key2 *key2)
 {
     /* For now we =
hardcode this to be 16 for the software based data channel
      * DCO base=
d implementations/HW implementation might adjust this number
@@ -1375,7 +13=
75,7 @@
 
 static void
 init_key_contexts(struct key_state *ks, struct tls_=
multi *multi, const struct key_type *key_type,
-                  bool serv=
er, struct key2 *key2, bool dco_enabled)
+                  bool server, co=
nst struct key2 *key2, bool dco_enabled)
 {
     struct key_ctx_bi *key =3D=
 &ks->crypto_options=2Ekey_ctx_bi;
 
@@ -1573,8 +1573,9 @@
 
 bool
 tls_ses=
sion_update_crypto_params_do_work(struct tls_multi *multi, struct tls_sessi=
on *session,
-                                         struct options *opti=
ons, struct frame *frame,
-                                         struct =
frame *frame_fragment, struct link_socket_info *lsi,
+                     =
                    const struct options *options, struct frame *frame,
+  =
                                       struct frame *frame_fragment,
+     =
                                    const struct link_socket_info *lsi,
   =
                                       dco_context_t *dco)
 {
     if (sess=
ion->key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1643,=
7 +1644,7 @@
 bool
 tls_session_update_crypto_params(struct tls_multi *mult=
i, struct tls_session *session,
                                  struct op=
tions *options, struct frame *frame,
-                                 stru=
ct frame *frame_fragment, struct link_socket_info *lsi,
+                  =
               struct frame *frame_fragment, const struct link_socket_info =
*lsi,
                                  dco_context_t *dco)
 {
     if (!ch=
eck_session_cipher(session, options))
@@ -2495,8 +2496,8 @@
 }
 
 bool
-ses=
sion_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_=
state *state,
-                          struct link_socket_actual *from)
+=
session_skip_to_pre_start(struct tls_session *session, const struct tls_pre=
_decrypt_state *state,
+                          const struct link_socket_=
actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
 =
    ks->session_id_remote =3D state->peer_session_id;
@@ -4011,7 +4012,7 @@=

 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)
=
+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)
 {
   =
  struct key_state *ks =3D multi->save_ks;
     multi->save_ks =3D NULL;
@@=
 -4142,7 +4143,7 @@
  * into a garbage collectable string which is returned=
=2E
  */
 const char *
-protocol_dump(struct buffer *buffer, unsigned int f=
lags, struct gc_arena *gc)
+protocol_dump(const struct buffer *buffer, unsi=
gned int flags, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_bu=
f_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --git a/src/openvpn=
/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5822336=2E=2E3370321 100644
--- a/src/=
openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 @@
  *
  * @retu=
rn A newly allocated and initialized \c tls_multi structure=2E
  */
-struct=
 tls_multi *tls_multi_init(struct tls_options *tls_options);
+struct tls_mu=
lti *tls_multi_init(const struct tls_options *tls_options);
 
 /**
  * Fina=
lize initialization of a \c tls_multi structure=2E
@@ -187,7 +187,7 @@
 /*
=
  * Initialize a standalone tls-auth verification object=2E
  */
-struct tl=
s_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_options=
,
+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls_op=
tions *tls_options,
                                                      s=
truct gc_arena *gc);
 
 /**
@@ -371,7 +371,7 @@
  * @param multi - The TLS =
state for this packet's destination VPN tunnel=2E
  * @param buf - The buff=
er containing the outgoing packet=2E
  */
-void tls_post_encrypt(struct tls=
_multi *multi, struct buffer *buf);
+void tls_post_encrypt(struct tls_multi=
 *multi, const struct buffer *buf);
 
 /** @} name Functions for managing s=
ecurity parameter state for data channel packets */
 
@@ -461,7 +461,8 @@
 =
 */
 bool tls_session_update_crypto_params(struct tls_multi *multi, struct =
tls_session *session,
                                       struct options=
 *options, struct frame *frame,
-                                      stru=
ct frame *frame_fragment, struct link_socket_info *lsi,
+                  =
                    struct frame *frame_fragment,
+                        =
              const struct link_socket_info *lsi,
                         =
              dco_context_t *dco);
 
 /*
@@ -525,7 +526,7 @@
 #define PD_VE=
RBOSE                 (1 << 10)
 #define PD_TLS_CRYPT               (1 << 1=
1)
 
-const char *protocol_dump(struct buffer *buffer, unsigned int flags, =
struct gc_arena *gc);
+const char *protocol_dump(const struct buffer *buffe=
r, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debugging code
@@ -5=
73,7 +574,7 @@
 /* Special method to skip the three way handshake RESET sta=
ges=2E This is
  * used by the HMAC code when seeing a packet that matches =
the previous
  * HMAC based stateless server state */
-bool session_skip_to=
_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state=
,
-                               struct link_socket_actual *from);
+bool s=
ession_skip_to_pre_start(struct tls_session *session, const struct tls_pre_=
decrypt_state *state,
+                               const struct link_soc=
ket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/op=
envpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index 816fb9c=2E=2Eed39=
5e7 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backend=
=2Eh
@@ -144,7 +144,7 @@
  *
  * @return      true if the context is initia=
lised, false if not=2E
  */
-bool tls_ctx_initialised(struct tls_root_ctx *=
ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *ctx);
 
 /**
  *=
 Set any library specific options=2E
@@ -177,7 +177,7 @@
  * @param ciphers=
       String containing : delimited cipher names, or NULL to use
  *      =
                                sane defaults=2E
  */
-void tls_ctx_restric=
t_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers);
+void tls_c=
tx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciphe=
rs);
 
 /**
  * Set the TLS certificate profile=2E  The profile defines whi=
ch crypto
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtl=
s=2Ec
index 9d408c0=2E=2E7893be0 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+=
++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -161,7 +161,7 @@
 }
 
 bool
-tls_ctx_in=
itialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_r=
oot_ctx *ctx)
 {
     /* either this should be NULL or should be non-null a=
nd then have a
      * valid TLS ctx inside as well */
@@ -284,7 +284,7 @@
=
 }
 
 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const =
char *ciphers)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *c=
tx, const char *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
diff --git=
 a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 306f85cd=
=2E=2E706d78d 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ss=
l_openssl=2Ec
@@ -147,7 +147,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tl=
s_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
  =
   /* either this should be NULL or should be non-null and then have a
    =
  * valid TLS ctx inside as well */
@@ -509,7 +509,7 @@
 #endif
 
 void
-tl=
s_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)=

+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char=
 *ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
@@ -1165,7 +1165,7 @@
 }=

 
 static void
-tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const =
char *uri)
+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, const=
 char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE_API)
     X509 *x =3D NULL;
=
@@ -2078,7 +2078,7 @@
 }
 
 static void
-bio_debug_data(const char *mode, B=
IO *bio, const uint8_t *buf, int len, const char *desc)
+bio_debug_data(con=
st char *mode, const BIO *bio, const uint8_t *buf, int len, const char *des=
c)
 {
     struct gc_arena gc =3D gc_new();
     if (len > 0)
@@ -2092,7 +2=
092,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_d=
ebug_oc(const char *mode, const BIO *bio)
 {
     open_biofp();
     fprint=
f(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t=
)time(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec=

index 1805995=2E=2E6b53e7e 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/=
openvpn/ssl_pkt=2Ec
@@ -57,7 +57,7 @@
  *  @return         if the swap was =
successful (buf was large enough)
  */
 static bool
-swap_hmac(struct buffe=
r *buf, const struct crypto_options *co, bool incoming)
+swap_hmac(const st=
ruct buffer *buf, const struct crypto_options *co, bool incoming)
 {
     A=
SSERT(co);
 
@@ -117,7 +117,7 @@
  */
 static void
 tls_wrap_control(struct=
 tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-                 s=
truct session_id *session_id)
+                 const struct session_id *se=
ssion_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=3D TL=
S_WRAP_NONE)
     {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-tls_reset_stand=
alone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-         =
            struct session_id *own_sid, struct session_id *remote_sid, uint=
8_t header,
-                     bool request_resend_wkc)
+tls_reset_stand=
alone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+   =
                  const struct session_id *own_sid, const struct session_id=
 *remote_sid,
+                     uint8_t header, bool request_resend_wkc=
)
 {
     /* Copy buffer here to point at the same data but allow tls_wrap_=
control
      * to potentially change buf to point to another buffer withou=
t
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index ac9d=
4be=2E=2Effd34f4 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl=
_pkt=2Eh
@@ -220,8 +220,9 @@
  * from the tls pre decrypt state=2E
  *
  */=

-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_a=
uth_standalone *tas,
-                                   struct session_id =
*own_sid, struct session_id *remote_sid,
+struct buffer tls_reset_standalon=
e(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+       =
                            const struct session_id *own_sid,
+            =
                       const struct session_id *remote_sid,
               =
                     uint8_t header, bool request_resend_wkc);
 
 
diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index e5b55a1=
=2E=2E0298106 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -1137,7 +1137,7 @@
  * cache=2E
  */
 static bool
-tls_authe=
ntication_status_use_cache(struct tls_multi *multi)
+tls_authentication_sta=
tus_use_cache(const struct tls_multi *multi)
 {
     unsigned int idx =3D m=
in_uint(multi->tas_cache_num_updates, SIZE(cache_intervals) - 1);
     time=
_t latency =3D cache_intervals[idx];
@@ -1281,7 +1281,7 @@
  * Check if the=
 script/plugin left a message in the auth failed message
  * file and relay=
 it to the user */
 static void
-check_for_client_reason(struct tls_multi *=
multi, struct auth_deferred_status *status)
+check_for_client_reason(struct=
 tls_multi *multi, const struct auth_deferred_status *status)
 {
     struc=
t gc_arena gc =3D gc_new();
     const char *msg =3D key_state_check_auth_f=
ailed_message_file(status, &gc);
@@ -1550,7 +1550,7 @@
 #endif /* ifdef ENA=
BLE_MANAGEMENT */
 
 static bool
-set_verify_user_pass_env(struct user_pass=
 *up, struct tls_multi *multi, struct tls_session *session)
+set_verify_use=
r_pass_env(const struct user_pass *up, struct tls_multi *multi, struct tls_=
session *session)
 {
     /* Is username defined? */
     if ((session->opt=
->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
@@ -15=
78,7 +1578,7 @@
 }
 
 bool
-ssl_verify_username_length(struct tls_session *=
session, const char *username)
+ssl_verify_username_length(const struct tls=
_session *session, const char *username)
 {
     if ((session->opt->ssl_fla=
gs & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(username) > TLS_USERN=
AME_LEN)
diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=
=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--- a/src/openvpn/ssl_verify=2Eh
+++=
 b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +202,7 @@
  * @return              =
true if name is under limit or username-as-common-name
  *                 =
     is not active
  */
-bool ssl_verify_username_length(struct tls_session=
 *session, const char *username);
+bool ssl_verify_username_length(const st=
ruct tls_session *session, const char *username);
 
 /**
  * Runs the --cli=
ent-crresponse script if one is defined=2E
@@ -275,7 +275,7 @@
 void auth_s=
et_client_reason(struct tls_multi *multi, const char *client_reason);
 
 st=
atic inline const char *
-tls_client_reason(struct tls_multi *multi)
+tls_c=
lient_reason(const struct tls_multi *multi)
 {
     return multi->client_re=
ason;
 }
diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index=
 c7d375b=2E=2Ecfbc38d 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn=
/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset(struct status_outp=
ut *so)
+status_reset(const struct status_output *so)
 {
     if (so && so-=
>fd >=3D 0)
     {
diff --git a/src/openvpn/status=2Eh b/src/openvpn/status=
=2Eh
index 7953a4e=2E=2E4c01d75 100644
--- a/src/openvpn/status=2Eh
+++ b/s=
rc/openvpn/status=2Eh
@@ -69,7 +69,7 @@
 
 bool status_trigger(struct statu=
s_output *so);
 
-void status_reset(struct status_output *so);
+void status=
_reset(const struct status_output *so);
 
 void status_flush(struct status_=
output *so);
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index=
 bc262cd=2E=2E97491a9 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tu=
n=2Ec
@@ -835,7 +835,7 @@
          const char *ifconfig_ipv6_local_parm,  =
   /* --ifconfig parm 1 IPv6 */
          int ifconfig_ipv6_netbits_parm,
 =
         const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv=
6 */
-         struct addrinfo *local_public, struct addrinfo *remote_publi=
c, const bool strict_warn,
+         const struct addrinfo *local_public, c=
onst struct addrinfo *remote_public, const bool strict_warn,
          stru=
ct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)
 {
     if (!tt)=

@@ -978,7 +978,7 @@
  * -> helper function to simplify code below
  */
 st=
atic void
-add_route_connected_v6_net(struct tuntap *tt, const struct env_s=
et *es)
+add_route_connected_v6_net(const struct tuntap *tt, const struct e=
nv_set *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +1020,7 @@
  */
 
 i=
n_addr_t
-create_arbitrary_remote(struct tuntap *tt)
+create_arbitrary_remo=
te(const struct tuntap *tt)
 {
     in_addr_t remote;
 
@@ -1592,7 +1592,7 =
@@
 }
 
 static void
-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx=
_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ct=
x)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D netmask_to_netbits2(t=
t->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static void
-undo_ifconfig_=
ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv6(const s=
truct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
   =
  if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, tt->netbits_ip=
v6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx)
 {
     if (tt->backend_driver !=3D DRIVER_NULL && tt->backen=
d_driver !=3D DRIVER_AFUNIX)
     {
@@ -1729,7 +1729,7 @@
 #endif
 
 static=
 ssize_t
-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+write=
_tun_header(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     i=
f (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1746,9 +1746,11 @@
            =
 type =3D htonl(AF_INET);
         }
 
+	/* argument to writev is a pointer=
 to const but we still need to drop
+	 * the const from buf pointer here */=

         iv[0]=2Eiov_base =3D &type;
         iv[0]=2Eiov_len =3D sizeof(t=
ype);
-        iv[1]=2Eiov_base =3D buf;
+        iv[1]=2Eiov_base =3D (voi=
d *)buf;
         iv[1]=2Eiov_len =3D len;
 
         return header_modify_=
read_write_return(writev(tt->fd, iv, 2));
@@ -1760,7 +1762,7 @@
 }
 
 stati=
c ssize_t
-read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
+read_=
tun_header(const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->=
type =3D=3D DEV_TYPE_TUN)
     {
@@ -1786,13 +1788,13 @@
  */
 #if !defined=
(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int le=
n)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
    =
 return write_tun_header(tt, buf, len);
 }
 
 ssize_t
-read_tun(struct tunt=
ap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *=
buf, int len)
 {
     return read_tun_header(tt, buf, len);
 }
@@ -1808,7 +=
1810,7 @@
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 static b=
ool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_enabled(const struct tunta=
p *tt)
 {
     return tt->backend_driver =3D=3D DRIVER_DCO;
 }
@@ -2055,13 =
+2057,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int l=
en)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
   =
  return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt=
, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, const uint8_t *=
buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2260,13 +2262,1=
3 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+wr=
ite_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     retur=
n write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8=
_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)=

 {
     return read(tt->fd, buf, len);
 }
@@ -2596,7 +2598,7 @@
 }
 
 ssiz=
e_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const s=
truct tuntap *tt, const uint8_t *buf, int len)
 {
     struct strbuf sbuf;
=
     sbuf=2Elen =3D len;
@@ -2605,7 +2607,7 @@
 }
 
 ssize_t
-read_tun(stru=
ct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, ui=
nt8_t *buf, int len)
 {
     struct strbuf sbuf;
     int f =3D 0;
@@ -3320=
,7 +3322,7 @@
 }
 
 int
-tun_write_queue(struct tuntap *tt, struct buffer *=
buf)
+tun_write_queue(struct tuntap *tt, const struct buffer *buf)
 {
     =
if (tt->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -3375,7 +3377,7 =
@@
 }
 
 int
-tun_write_win32(struct tuntap *tt, struct buffer *buf)
+tun_w=
rite_win32(struct tuntap *tt, const struct buffer *buf)
 {
     int err =3D=
 0;
     int status =3D 0;
@@ -5383,7 +5385,7 @@
 }
 
 void
-fork_register_=
dns_action(struct tuntap *tt)
+fork_register_dns_action(const struct tuntap=
 *tt)
 {
     if (tt && tt->options=2Eregister_dns && tt->options=2Emsg_cha=
nnel)
     {
@@ -5473,7 +5475,7 @@
 }
 
 static void
-tuntap_get_mtu(struct=
 tuntap *tt)
+tuntap_get_mtu(const struct tuntap *tt)
 {
     ULONG mtu =3D=
 0;
     DWORD len;
@@ -6048,7 +6050,7 @@
 }
 
 void
-tun_show_debug(struct=
 tuntap *tt)
+tun_show_debug(const struct tuntap *tt)
 {
     if (tt->backe=
nd_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
diff --git a/src/openv=
pn/tun=2Eh b/src/openvpn/tun=2Eh
index 6a7af85=2E=2E41b93cb 100644
--- a/sr=
c/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -272,9 +272,9 @@
 
 void clo=
se_tun_handle(struct tuntap *tt);
 
-ssize_t write_tun(struct tuntap *tt, u=
int8_t *buf, int len);
+ssize_t write_tun(const struct tuntap *tt, const ui=
nt8_t *buf, int len);
 
-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, =
int len);
+ssize_t read_tun(const struct tuntap *tt, uint8_t *buf, int len)=
;
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const =
char *dev_type, const char *dev_node, int persist_mode,
@@ -293,7 +293,7 @@=

                         const char *ifconfig_ipv6_local_parm,     /* --if=
config parm 1 / IPv6 */
                         int ifconfig_ipv6_netbits_=
parm,           /* --ifconfig parm 1 / bits */
                         con=
st char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
-    =
                    struct addrinfo *local_public, struct addrinfo *remote_=
public,
+                        const struct addrinfo *local_public, const=
 struct addrinfo *remote_public,
                         const bool strict=
_warn, struct env_set *es, openvpn_net_ctx_t *ctx,
                        =
 struct tuntap *tt);
 
@@ -320,7 +320,7 @@
  * @param tt    the tuntap inte=
rface context
  * @param ctx   the networking API opaque context
  */
-void=
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void undo_ifcon=
fig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 bool is_dev_type(c=
onst char *dev, const char *dev_type, const char *match_type);
 
@@ -351,7 =
+351,7 @@
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN
 
 static inlin=
e int
-ifconfig_order(struct tuntap *tt)
+ifconfig_order(const struct tunta=
p *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,=
7 +381,7 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inline i=
nt
-route_order(struct tuntap *tt)
+route_order(const struct tuntap *tt)
 {=

     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -454,13 +454,1=
3 @@
 
 const char *tap_win_getinfo(const struct tuntap *tt, struct gc_aren=
a *gc);
 
-void tun_show_debug(struct tuntap *tt);
+void tun_show_debug(con=
st struct tuntap *tt);
 
 bool dhcp_release_by_adapter_index(const DWORD ad=
apter_index);
 
 bool dhcp_renew_by_adapter_index(const DWORD adapter_index=
);
 
-void fork_register_dns_action(struct tuntap *tt);
+void fork_register=
_dns_action(const struct tuntap *tt);
 
 void ipconfig_register_dns(const s=
truct env_set *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read_queue(struct tunt=
ap *tt, int maxsize);
 
-int tun_write_queue(struct tuntap *tt, struct buff=
er *buf);
+int tun_write_queue(struct tuntap *tt, const struct buffer *buf)=
;
 
 static inline bool
 tuntap_stop(int status)
@@ -499,7 +499,7 @@
     r=
eturn false;
 }
 
-int tun_write_win32(struct tuntap *tt, struct buffer *bu=
f);
+int tun_write_win32(struct tuntap *tt, const struct buffer *buf);
 
 s=
tatic inline bool
 is_ip_packet_valid(const struct buffer *buf)
@@ -529,13 =
+529,13 @@
 }
 
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+=
tuntap_is_dco_win(const struct tuntap *tt)
 {
     return tt && tt->backend=
_driver =3D=3D DRIVER_DCO;
 }
 
 static inline bool
-tuntap_is_dco_win_time=
out(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(const struct =
tuntap *tt, int status)
 {
     return tuntap_is_dco_win(tt) && (status < 0=
) && (openvpn_errno() =3D=3D ERROR_NETNAME_DELETED);
 }
@@ -555,25 +555,25 =
@@
 }
 
 static inline void
-tun_standby_init(struct tuntap *tt)
+tun_stand=
by_init(const struct tuntap *tt)
 {
 }
 
 static inline bool
-tun_standby(s=
truct tuntap *tt)
+tun_standby(const struct tuntap *tt)
 {
     return true=
;
 }
 
 
 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_=
is_dco_win(const struct tuntap *tt)
 {
     return false;
 }
 
 static inli=
ne bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_i=
s_dco_win_timeout(const struct tuntap *tt, int status)
 {
     return false=
;
 }
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
i=
ndex a67a472=2E=2Ee9223bc 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src=
/openvpn/tun_afunix=2Ec
@@ -48,7 +48,7 @@
 
 
 static void
-tun_afunix_exec=
_child(const char *dev_node, struct tuntap *tt, struct env_set *env)
+tun_a=
funix_exec_child(const char *dev_node, struct tuntap *tt, const struct env_=
set *env)
 {
     const char *msgprefix =3D "ERROR: failure executing proce=
ss for tun:";
     struct argv argv =3D argv_new();
@@ -73,7 +73,7 @@
 }
 
=
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struc=
t env_set *orig_env)
+open_tun_afunix(const struct options *o, int mtu, str=
uct tuntap *tt, const struct env_set *orig_env)
 {
     struct gc_arena gc =
=3D gc_new();
 
diff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_a=
funix=2Eh
index 5b6a8e0=2E=2Efb88eb2 100644
--- a/src/openvpn/tun_afunix=2E=
h
+++ b/src/openvpn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user provided =
taking care of implementing the actual tun
  * device=2E
  */
-void open_tu=
n_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *env=
);
+void open_tun_afunix(const struct options *o, int mtu, struct tuntap *t=
t, const struct env_set *env);
 
 
 /**
diff --git a/src/openvpn/vlan=2Ec b=
/src/openvpn/vlan=2Ec
index bffc60e=2E=2Ecd32a9b 100644
--- a/src/openvpn/v=
lan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_pro=
cess_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
+vlan=
_process_outgoing_tun(const struct multi_context *m, struct multi_instance =
*mi)
 {
     if (!m->top=2Eoptions=2Evlan_tagging)
     {
diff --git a/src/=
openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh
index 9389f89=2E=2Ecd2f66f 100644
-=
-- a/src/openvpn/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 b=
ool vlan_is_tagged(const struct buffer *buf);
 
-void vlan_process_outgoing=
_tun(struct multi_context *m, struct multi_instance *mi);
+void vlan_proces=
s_outgoing_tun(const struct multi_context *m, struct multi_instance *mi);
 =

 #endif /* VLAN_H */
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win3=
2=2Eh
index ef32062=2E=2Ebcbfa67 100644
--- a/src/openvpn/win32=2Eh
+++ b/s=
rc/openvpn/win32=2Eh
@@ -226,7 +226,7 @@
 void overlapped_io_close(struct o=
verlapped_io *o);
 
 static inline bool
-overlapped_io_active(struct overla=
pped_io *o)
+overlapped_io_active(const struct overlapped_io *o)
 {
     re=
turn o->iostate =3D=3D IOSTATE_QUEUED || o->iostate =3D=3D IOSTATE_IMMEDIAT=
E_RETURN;
 }
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnms=
ica/openvpnmsica=2Ec
index a861e8a=2E=2E25fa1e4 100644
--- a/src/openvpnmsi=
ca/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -77,7 +77,7 =
@@
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 stat=
ic UINT
-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty,=
 _In_ struct msica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hInstall, _=
In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *seq)
 {
     UIN=
T uiResult;
     LPWSTR szSequence =3D msica_arg_seq_join(seq);
diff --git =
a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 6=
28ec85=2E=2E1fff6af 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/=
openvpnserv/interactive=2Ec
@@ -521,7 +521,7 @@
 
 
 static SOCKADDR_INET
-=
sockaddr_inet(short family, inet_address_t *addr)
+sockaddr_inet(short fami=
ly, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMem=
ory(&sa_inet, sizeof(sa_inet));
@@ -3733,7 +3733,7 @@
 
 static DWORD
 Upda=
teWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE=
 exit_event,
-                  list_item_t *threads)
+                  co=
nst list_item_t *threads)
 {
     static DWORD size =3D 10;
     static LPH=
ANDLE handles =3D NULL;
diff --git a/tests/unit_tests/openvpn/mock_manageme=
nt=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Eff=
f4c2b 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
+++ b/tests=
/unit_tests/openvpn/mock_management=2Ec
@@ -36,7 +36,7 @@
 struct managemen=
t *management; /* GLOBAL */
 
 void
-management_auth_failure(struct managem=
ent *man, const char *type, const char *reason)
+management_auth_failure(co=
nst struct management *man, const char *type, const char *reason)
 {
     A=
SSERT(false);
 }
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/test=
s/unit_tests/openvpn/test_misc=2Ec
index 4a055e7=2E=2Eaf96764 100644
--- a/=
tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_=
misc=2Ec
@@ -146,7 +146,7 @@
 }
 
 static struct hash_element *
-hash_looku=
p_by_value(struct hash *hash, void *value)
+hash_lookup_by_value(struct has=
h *hash, const void *value)
 {
     struct hash_iterator hi;
     struct ha=
sh_element *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/=
tests/unit_tests/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636a33 1006=
44
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests=
/openvpn/test_user_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 }
 void
=
-management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+management_auth_failure(const struct management *man, const ch=
ar *type, const char *reason)
 {
     assert_true(0);
 }

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b=
116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 6
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--djs6V/gVuFc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
move instances of constParameterPointer cppcheck warnings<br><br>This requi=
res a few suppressions since cppcheck<br>doesn&#39;t quite understand the d=
ifferent code-paths<br>implemented by preprocessor defines=2E<br><br>Change=
-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-supp=
ression<br>M sample/sample-plugins/client-connect/sample-client-connect=2Ec=
<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/sample-plugins=
/keying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M src/openvpn/=
buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M src=
/openvpn/clinat=2Eh<br>M src/openvpn/comp=2Ec<br>M src/openvpn/comp=2Eh<br>=
M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/dco=
=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_freebsd=2Ec<br>M src/ope=
nvpn/dco_internal=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_w=
in=2Ec<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/dhcp=2Eh<br>M src/openvpn=
/event=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M s=
rc/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>M src/openvpn/interval=2Eh=
<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/manag=
e=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mbuf=2Ec<br>M src/openvp=
n/mbuf=2Eh<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mss=2Eh<br>M src/openv=
pn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/op=
envpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/networking=2Eh<=
br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=
=2Ec<br>M src/openvpn/occ=2Eh<br>M src/openvpn/openssl_compat=2Eh<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/oti=
me=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/proto=2Eh<br>M src/openv=
pn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<br>M src/op=
envpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/o=
penvpn/push_util=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliabl=
e=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/ope=
nvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/socket_util=2E=
h<br>M src/openvpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/openvpn/ss=
l=2Ec<br>M src/openvpn/ssl=2Eh<br>M src/openvpn/ssl_backend=2Eh<br>M src/op=
envpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl=
_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>M =
src/openvpn/ssl_verify=2Eh<br>M src/openvpn/status=2Ec<br>M src/openvpn/sta=
tus=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/=
tun_afunix=2Ec<br>M src/openvpn/tun_afunix=2Eh<br>M src/openvpn/vlan=2Ec<br=
>M src/openvpn/vlan=2Eh<br>M src/openvpn/win32=2Eh<br>M src/openvpnmsica/op=
envpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/o=
penvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>M=
 tests/unit_tests/openvpn/test_user_pass=2Ec<br>88 files changed, 329 inser=
tions(+), 287 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/6</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><=
span>index 900e03c=2E=2Ead05f34 100644</span><br><span>--- a/dev-tools/cppc=
heck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span=
><br><span>@@ -2,7 +2,6 @@</span><br><span> # occurences right now=2E They =
still should be fixed at some point</span><br><span> constParameter</span><=
br><span> constParameterCallback</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-constParameterPointer</span><br><span> invalidPrintfArgType_sint=
</span><br><span> invalidPrintfArgType_uint</span><br><span> usleepCalled</=
span><br><span>@@ -33,6 +32,37 @@</span><br><span> badBitmaskCheck:tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span> # IGN: we store integers in =
pointers</span><br><span> CastAddressToIntegerAtReturn:src/openvpn/multi=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoin=
ter:/usr/include/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 IGN: test files provide mocks/stubs that match prototypes from headers exa=
ctly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterP=
ointer:tests/unit_tests/openvpn/mock_*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/test_*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:=
tests/unit_tests/openvpnserv/test_*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# FP: different crypto implementations but same API</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/o=
penvpn/crypto_mbedtls_legacy=2Ec:85</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_openssl=2Ec:172</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:=
src/openvpn/crypto_openssl=2Ec:1456</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+constParameterPointer:src/openvpn/cryptoapi=2Ec:58</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/op=
envpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+constParameterPointer:src/openvpn/ssl_openssl=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ssl_ver=
ify_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IG=
N: too many different implementations, not worth it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/dco*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:=
src/openvpn/socket=2E*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# FP: parameters are modified on some platform only</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/dns=2E=
c:859</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:src/openvpn/error=2Ec:223</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+constParameterPointer:src/openvpn/forward=2Ec:1247</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/manage=2Ec:344</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onstParameterPointer:src/openvpn/manage=2Ec:3332</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/misc=2Ec:792=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPoint=
er:src/openvpn/misc=2Ec:812</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+constParameterPointer:src/openvpn/options=2Ec:3205</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/ro=
ute=2Ec:3947</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constPa=
rameterPointer:src/openvpn/tun=2Ec:560</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+constParameterPointer:src/openvpn/tun=2Ec:2188</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/ope=
nvpn/tun_afunix=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# IGN: not a FP but the documentation for the FP_ISSET claims this is not c=
onst=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constP=
arameterPointer:src/openvpn/event=2Ec:1015</span><br><span> # IGN: event co=
de uses a pointer to store integers</span><br><span> intToPointerCast:src/o=
penvpn/forward=2Ec</span><br><span> intToPointerCast:src/openvpn/multi_io=
=2Ec</span><br><span>diff --git a/sample/sample-plugins/client-connect/samp=
le-client-connect=2Ec b/sample/sample-plugins/client-connect/sample-client-=
connect=2Ec</span><br><span>index 420de61=2E=2Ecbd98e8 100644</span><br><sp=
an>--- a/sample/sample-plugins/client-connect/sample-client-connect=2Ec</sp=
an><br><span>+++ b/sample/sample-plugins/client-connect/sample-client-conne=
ct=2Ec</span><br><span>@@ -344,7 +344,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-openvpn_plugin_client_connect(struct plugin_context *context, const cha=
r **argv, const char **envp)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+openvpn_plugin_client_connect(const struct plugin_context *context=
, const char **argv, const char **envp)</span><br><span> {</span><br><span>=
     /* log environment variables handed to us by OpenVPN, but</span><br><s=
pan>      * only if &quot;setenv verb&quot; is 3 or higher (arbitrary numbe=
r)</span><br><span>@@ -465,7 +465,7 @@</span><br><span> </span><br><span> i=
nt</span><br><span> openvpn_plugin_client_connect_defer_v2(struct plugin_co=
ntext *context,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                 struct plugin_per_client_context *pcc,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                const struct plugin_per_client_context *pcc,</span><br><spa=
n>                                        struct openvpn_plugin_string_list=
 **return_list)</span><br><span> {</span><br><span>     time_t time_left =
=3D pcc-&gt;sleep_until - time(NULL);</span><br><span>diff --git a/sample/s=
ample-plugins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=
=2Ec</span><br><span>index bacf557=2E=2Ecdd616f 100644</span><br><span>--- =
a/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/s=
ample-plugins/defer/multi-auth=2Ec</span><br><span>@@ -255,7 +255,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-do_auth_user_pass(struct plugin_con=
text *context, const char *username, const char *password)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+do_auth_user_pass(const struct plugi=
n_context *context, const char *username, const char *password)</span><br><=
span> {</span><br><span>     plog(context, PLOG_NOTE, &quot;expect_user=3D%=
s, received_user=3D%s, expect_passw=3D%s, received_passw=3D%s&quot;,</span>=
<br><span>          np(context-&gt;test_valid_user), np(username), np(conte=
xt-&gt;test_valid_pass), np(password));</span><br><span>@@ -279,7 +279,7 @@=
</span><br><span> </span><br><span> </span><br><span> static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-auth_user_pass_verify(struct plu=
gin_context *context, struct plugin_per_client_context *pcc,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+auth_user_pass_verify(const struct=
 plugin_context *context, struct plugin_per_client_context *pcc,</span><br>=
<span>                       const char *argv[], const char *envp[])</span>=
<br><span> {</span><br><span>     /* get username/password from envp string=
 array */</span><br><span>diff --git a/sample/sample-plugins/keying-materia=
l-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-m=
aterial-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>index 25c9=
ff5=2E=2E512861a 100644</span><br><span>--- a/sample/sample-plugins/keying-=
material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sam=
ple/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec=
</span><br><span>@@ -186,7 +186,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-file_store(char *file, char *content)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+file_store(const char *file, const char *content)</=
span><br><span> {</span><br><span>     FILE *f;</span><br><span>     if (!(=
f =3D fopen(file, &quot;w+&quot;)))</span><br><span>@@ -202,7 +202,7 @@</sp=
an><br><span> server_store(struct openvpn_plugin_args_func_in const *args)<=
/span><br><span> {</span><br><span>     struct plugin *plugin =3D (struct p=
lugin *)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct session *sess =3D (struct session *)args-&gt;per_client_conte=
xt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 session *sess =3D (struct session *)args-&gt;per_client_context;</span><br=
><span> </span><br><span>     char file[MAXPATH];</span><br><span>     snpr=
intf(file, sizeof(file) - 1, &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt;key)=
;</span><br><span>@@ -214,7 +214,7 @@</span><br><span> client_store(struct =
openvpn_plugin_args_func_in const *args)</span><br><span> {</span><br><span=
>     struct plugin *plugin =3D (struct plugin *)args-&gt;handle;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct session *sess =3D (s=
truct session *)args-&gt;per_client_context;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct session *sess =3D (struct session=
 *)args-&gt;per_client_context;</span><br><span> </span><br><span>     char=
 *file =3D &quot;/tmp/openvpn_sso_user&quot;;</span><br><span>     ovpn_not=
e(&quot;app session file: %s&quot;, file);</span><br><span>diff --git a/src=
/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 131e1d6=
=2E=2Ef9990d6 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br=
><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -290,7 +290,7 @@</sp=
an><br><span>  * truncated by buf_printf</span><br><span>  */</span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_catrunc(s=
truct buffer *buf, const char *str)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+buf_catrunc(const struct buffer *buf, const char *str)</spa=
n><br><span> {</span><br><span>     if (buf_forward_capacity(buf) &lt;=3D 1=
)</span><br><span>     {</span><br><span>@@ -1091,7 +1091,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-string_check_buf(struct buffer *buf, const unsigne=
d int inclusive, const unsigned int exclusive)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+string_check_buf(const struct buffer *buf, const=
 unsigned int inclusive, const unsigned int exclusive)</span><br><span> {</=
span><br><span>     ASSERT(buf);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index =
6a751ad=2E=2E0d3b202 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</s=
pan><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -487,7 +487,7=
 @@</span><br><span>  * write a string to the end of a buffer that was</spa=
n><br><span>  * truncated by buf_printf</span><br><span>  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void buf_catrunc(struct buffer *buf,=
 const char *str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid buf_catrunc(const struct buffer *buf, const char *str);</span><br><span=
> </span><br><span> /*</span><br><span>  * Parse a string based on a given =
delimiter char</span><br><span>@@ -774,7 +774,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static inline int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *buf)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const struct buffer *buf)=
</span><br><span> {</span><br><span>     int ret;</span><br><span>     if (=
BLEN(buf) &lt; 1)</span><br><span>@@ -923,7 +923,7 @@</span><br><span>  * @=
param exclusive Character classes that are not allowed even if they are als=
o in inclusive=2E</span><br><span>  * @return True if the string consists o=
nly of allowed characters, false otherwise=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool string_check_buf(struct b=
uffer *buf, const unsigned int inclusive,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool string_check_buf(const struct buffer *buf, const=
 unsigned int inclusive,</span><br><span>                       const unsig=
ned int exclusive);</span><br><span> </span><br><span> /**</span><br><span>=
@@ -1102,7 +1102,7 @@</span><br><span>     }</span><br><span> </span><br><s=
pan> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-check_malloc_return(void *p)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_malloc_return(const void *p)</span><br><span> {</span><br>=
<span>     if (!p)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index 32c1325=
=2E=2Eb465950 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br=
><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -159,7 +159,7 @@</sp=
an><br><span> #endif</span><br><span> </span><br><span> static void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphd=
r *iph, const char *prefix, const int direction, const msglvl_t msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkt(const struc=
t openvpn_iphdr *iph, const char *prefix, const int direction, const msglvl=
_t msglevel)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span> </span><br><span>@@ -181,7 +181,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-client_nat_transform(const struct client_nat_opt=
ion_list *list, struct buffer *ipbuf,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+client_nat_transform(const struct client_nat_option_list =
*list, const struct buffer *ipbuf,</span><br><span>                      co=
nst int direction)</span><br><span> {</span><br><span>     struct ip_tcp_ud=
p_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);</span><br><span>diff --g=
it a/src/openvpn/clinat=2Eh b/src/openvpn/clinat=2Eh</span><br><span>index =
1e8ceb3=2E=2Ebc56037 100644</span><br><span>--- a/src/openvpn/clinat=2Eh</s=
pan><br><span>+++ b/src/openvpn/clinat=2Eh</span><br><span>@@ -60,7 +60,7 @=
@</span><br><span>                                    const char *network, =
const char *netmask,</span><br><span>                                    co=
nst char *foreign_network, msglvl_t msglevel);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void client_nat_transform(const =
struct client_nat_option_list *list, struct buffer *ipbuf,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void client_nat_transform(const stru=
ct client_nat_option_list *list, const struct buffer *ipbuf,</span><br><spa=
n>                           const int direction);</span><br><span> </span>=
<br><span> #endif /* if !defined(CLINAT_H) */</span><br><span>diff --git a/=
src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><span>index b88b79f=
=2E=2E387a7c4 100644</span><br><span>--- a/src/openvpn/comp=2Ec</span><br><=
span>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><=
br><span> #endif /* USE_COMP */</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-check_compression_setting=
s_valid(struct compress_options *info, msglvl_t msglevel)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+check_compression_settings_valid(cons=
t struct compress_options *info, msglvl_t msglevel)</span><br><span> {</spa=
n><br><span>     /*</span><br><span>      * We also allow comp-stub-v2 here=
 as it technically allows escaping of</span><br><span>diff --git a/src/open=
vpn/comp=2Eh b/src/openvpn/comp=2Eh</span><br><span>index 29a90a2=2E=2Ead80=
243 100644</span><br><span>--- a/src/openvpn/comp=2Eh</span><br><span>+++ b=
/src/openvpn/comp=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  *=
 flags of allow-compression and also the whether algorithms are compiled</s=
pan><br><span>  * in</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool check_compression_settings_valid(struct compress_o=
ptions *info, msglvl_t msglevel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool check_compression_settings_valid(const struct compress_o=
ptions *info, msglvl_t msglevel);</span><br><span> </span><br><span> #ifdef=
 USE_COMP</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span>=
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><spa=
n>index a9a33c0=2E=2Ee04eedf 100644</span><br><span>--- a/src/openvpn/crypt=
o=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1105=
,7 +1105,7 @@</span><br><span> }</span><br><span> </span><br><span> static =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_is_zero(struc=
t key *key, const struct key_type *kt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+key_is_zero(const struct key *key, const struct key_type=
 *kt)</span><br><span> {</span><br><span>     size_t cipher_length =3D ciph=
er_kt_key_size(kt-&gt;cipher);</span><br><span>     for (size_t i =3D 0; i =
&lt; cipher_length; ++i)</span><br><span>@@ -1123,7 +1123,7 @@</span><br><s=
pan>  * Make sure that cipher key is a valid key for current key_type=2E</s=
pan><br><span>  */</span><br><span> bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-check_key(struct key *key, const struct key_type *kt)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+check_key(const struct=
 key *key, const struct key_type *kt)</span><br><span> {</span><br><span>  =
   if (cipher_defined(kt-&gt;cipher))</span><br><span>     {</span><br><spa=
n>@@ -1196,7 +1196,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_crypto(st=
ruct crypto_options *co, struct frame *frame)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_crypto(struct crypto_options *co, const stru=
ct frame *frame)</span><br><span> {</span><br><span>     int i, j;</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/=
src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index fbca2=
a0=2E=2E044f2d2 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><=
br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</=
span><br><span>  */</span><br><span> int write_key_file(const int nkeys, co=
nst char *filename);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool check_key(struct key *key, const struct key_type *kt)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_key(con=
st struct key *key, const struct key_type *kt);</span><br><span> </span><br=
><span> /**</span><br><span>  * Initialize a key_type structure with=2E</sp=
an><br><span>@@ -609,7 +609,7 @@</span><br><span> /** Print a cipher list e=
ntry */</span><br><span> void print_cipher(const char *cipher);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void test_crypt=
o(struct crypto_options *co, struct frame *f);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void test_crypto(struct crypto_options *co, cons=
t struct frame *f);</span><br><span> </span><br><span> </span><br><span> /*=
 key direction functions */</span><br><span>diff --git a/src/openvpn/dco=2E=
c b/src/openvpn/dco=2Ec</span><br><span>index 69ce1d7=2E=2Ef509a29 100644</=
span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/=
dco=2Ec</span><br><span>@@ -556,7 +556,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_multi_get_localaddr(struct multi_context *m, struct multi_=
instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_mu=
lti_get_localaddr(const struct multi_context *m, const struct multi_instanc=
e *mi,</span><br><span>                         struct sockaddr_storage *lo=
cal)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><s=
pan>@@ -568,7 +568,7 @@</span><br><span>         return false;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socke=
t_infos[0]-&gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct link_socket_actual *actual =3D &amp;c-&gt;c2=2E=
link_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span>=
     switch (actual-&gt;dest=2Eaddr=2Esa=2Esa_family)</span><br><span>     =
{</span><br><span>@@ -606,7 +606,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-d=
co_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_pee=
r(const struct multi_context *m, struct multi_instance *mi)</span><br><span=
> {</span><br><span>     const struct context *c =3D &amp;mi-&gt;context;</=
span><br><span> </span><br><span>@@ -660,7 +660,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-dco_install_iroute(struct multi_context *m, struct multi_ins=
tance *mi, struct mroute_addr *addr)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+dco_install_iroute(struct multi_context *m, struct multi_i=
nstance *mi, const struct mroute_addr *addr)</span><br><span> {</span><br><=
span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN3=
2)</span><br><span>     if (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><=
br><span>@@ -779,7 +779,7 @@</span><br><span>         /* Checked if we adde=
d a host route as the assigned client IP address was</span><br><span>      =
    * outside the --ifconfig-ipv6 tun interface config */</span><br><span> =
#if !defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_i=
pv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst struct in6_addr *dest =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv=
6_local;</span><br><span>         if (multi_check_push_ifconfig_ipv6_extra_=
route(mi, dest))</span><br><span>         {</span><br><span>             /*=
 On windows we do not install these routes, so we also do not need to delet=
e them */</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dc=
o=2Eh</span><br><span>index 4e5aad5=2E=2E694875c 100644</span><br><span>---=
 a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br>=
<span>@@ -204,7 +204,7 @@</span><br><span>  * @param mi        the client i=
nstance</span><br><span>  * @return          0 on success or a negative err=
or code otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-int dco_multi_add_new_peer(struct multi_context *m, struct=
 multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int dco_multi_add_new_peer(const struct multi_context *m, struct multi_in=
stance *mi);</span><br><span> </span><br><span> /**</span><br><span>  * Ins=
tall an iroute in DCO, which means adding a route to the system routing</sp=
an><br><span>@@ -215,7 +215,7 @@</span><br><span>  * @param addr      the r=
oute to add</span><br><span>  */</span><br><span> void dco_install_iroute(s=
truct multi_context *m, struct multi_instance *mi,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        struct mroute_addr *ad=
dr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         const struct mroute_addr *addr);</span><br><span> </span><br><span=
> /**</span><br><span>  * Remove all routes added through the specified cli=
ent</span><br><span>@@ -253,7 +253,7 @@</span><br><span>  * a 64 bit packet=
 counter and AEAD tag at the end=2E</span><br><span>  */</span><br><span> b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch=
_data(struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+dco_supports_epoch_data(const struct context *c);</span><br><span> #e=
lse  /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span> typede=
f void *dco_context_t;</span><br><span>@@ -350,7 +350,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static inline int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_conte=
xt *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_multi_add_new_peer(const struct multi_context *m, struct =
multi_instance *mi)</span><br><span> {</span><br><span>     return 0;</span=
><br><span> }</span><br><span>@@ -384,7 +384,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static inline bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(co=
nst struct context *c)</span><br><span> {</span><br><span>     return false=
;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_freebsd=
=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index d933aaf=2E=2E73469=
03 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span=
>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -930,7 +930,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_=
data(const struct context *c)</span><br><span> {</span><br><span>     retur=
n false;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_in=
ternal=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>index fcf8aca=2E=
=2E1022e66 100644</span><br><span>--- a/src/openvpn/dco_internal=2Eh</span>=
<br><span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@ -59,8 +59,9=
 @@</span><br><span>  * They are implemented by dco_linux=2Ec</span><br><sp=
an>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descri=
ptor_t sd, struct sockaddr *localaddr,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                 struct sockaddr *remoteaddr, const struct=
 in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, socket_descriptor_t sd,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                 struct sockaddr *localaddr, struct so=
ckaddr *remoteaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6);</span><br><span> </span><br><span> int dco_del_peer(dco_context_t *=
dco, unsigned int peerid);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index =
56f6259=2E=2E31bbe87 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec=
</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -114,7 =
+114,7 @@</span><br><span> }</span><br><span> </span><br><span> static stru=
ct nl_msg *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_n=
lmsg_create(dco_context_t *dco, uint8_t cmd)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_create(const dco_context_t *dco, ui=
nt8_t cmd)</span><br><span> {</span><br><span>     struct nl_msg *nl_msg =
=3D nlmsg_alloc();</span><br><span>     if (!nl_msg)</span><br><span>@@ -80=
4,7 +804,7 @@</span><br><span> </span><br><span> /* libnl &lt; 3=2E11=2E0 d=
oes not implement nla_get_uint() */</span><br><span> static uint64_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nla_get_uint(struct nla=
ttr *attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_=
get_uint(const struct nlattr *attr)</span><br><span> {</span><br><span>    =
 if (nla_len(attr) =3D=3D sizeof(uint32_t))</span><br><span>     {</span><b=
r><span>@@ -916,7 +916,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovp=
n_iface_check(dco_context_t *dco, struct nlattr *attrs[])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_iface_check(const dco_context_t =
*dco, struct nlattr *attrs[])</span><br><span> {</span><br><span>     /* we=
 must know which interface this message is referring to in order to</span><=
br><span>      * avoid mixing messages for other instances</span><br><span>=
@@ -1340,7 +1340,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epo=
ch_data(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_supports_epoch_data(const struct context *c)</span><br><span> {<=
/span><br><span>     return false;</span><br><span> }</span><br><span>diff =
--git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>i=
ndex b3268bc=2E=2E8deb9d8 100644</span><br><span>--- a/src/openvpn/dco_win=
=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -1100=
,7 +1100,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(=
struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_supports_epoch_data(const struct context *c)</span><br><span> {</span><b=
r><span>     OVPN_VERSION ver =3D { 0 };</span><br><span>     return dco_ge=
t_version(&amp;ver) &amp;&amp; ((ver=2EMajor =3D=3D 2 &amp;&amp; ver=2EMino=
r &gt;=3D 8) || (ver=2EMajor &gt; 2));</span><br><span>diff --git a/src/ope=
nvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index a54ab3f=2E=2E681=
73e6 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ =
b/src/openvpn/dhcp=2Ec</span><br><span>@@ -145,7 +145,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> in_addr_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-dhcp_extract_router_msg(struct buffer *ipbuf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dhcp_extract_router_msg=
(const struct buffer *ipbuf)</span><br><span> {</span><br><span>     struct=
 dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);</span><br><span>     co=
nst int optlen =3D</span><br><span>diff --git a/src/openvpn/dhcp=2Eh b/src/=
openvpn/dhcp=2Eh</span><br><span>index 38ebf8d=2E=2Eed8a0c9 100644</span><b=
r><span>--- a/src/openvpn/dhcp=2Eh</span><br><span>+++ b/src/openvpn/dhcp=
=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br><span> </span><br><span> #=
pragma pack()</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t dhcp_extract_route=
r_msg(const struct buffer *ipbuf);</span><br><span> </span><br><span> #if d=
efined(_WIN32) || defined(DHCP_UNIT_TEST)</span><br><span> #include &quot;t=
un=2Eh&quot;</span><br><span>diff --git a/src/openvpn/event=2Eh b/src/openv=
pn/event=2Eh</span><br><span>index b784dfe=2E=2E0940a1d 100644</span><br><s=
pan>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/src/openvpn/event=2Eh=
</span><br><span>@@ -204,7 +204,7 @@</span><br><span> #else /* ifdef _WIN32=
 */</span><br><span> </span><br><span> static inline void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-wait_signal(struct event_set *es, void =
*arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wait_signal(co=
nst struct event_set *es, const void *arg)</span><br><span> {</span><br><sp=
an> }</span><br><span> </span><br><span>diff --git a/src/openvpn/forward=2E=
c b/src/openvpn/forward=2Ec</span><br><span>index 887d7d7=2E=2E1d76859 1006=
44</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/=
openvpn/forward=2Ec</span><br><span>@@ -231,7 +231,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-parse_incoming_control_channel_command(struct cont=
ext *c, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+parse_incoming_control_channel_command(struct context *c, const str=
uct buffer *buf)</span><br><span> {</span><br><span>     if (buf_string_mat=
ch_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br><span>     {</span><br=
><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_server_p=
oll_remaining_time(struct event_timeout *server_poll_timeout)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+get_server_poll_remaining_time(co=
nst struct event_timeout *server_poll_timeout)</span><br><span> {</span><br=
><span>     update_time();</span><br><span>     int remaining =3D event_tim=
eout_remaining(server_poll_timeout);</span><br><span>@@ -598,7 +598,7 @@</s=
pan><br><span>  * Buffer reallocation, for use with null encryption=2E</spa=
n><br><span>  */</span><br><span> static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const uint8_t *orig_buf, st=
ruct buffer *dest_stub, struct buffer *src_stub,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+buffer_turnover(const uint8_t *orig_buf, struc=
t buffer *dest_stub, const struct buffer *src_stub,</span><br><span>       =
          struct buffer *storage)</span><br><span> {</span><br><span>     i=
f (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-&gt;data !=3D stor=
age-&gt;data)</span><br><span>@@ -885,7 +885,7 @@</span><br><span>  */</spa=
n><br><span> </span><br><span> static inline void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-socks_postprocess_incoming_link(struct context =
*c, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+socks_postprocess_incoming_link(struct context *c, const struct l=
ink_socket *sock)</span><br><span> {</span><br><span>     if (sock-&gt;sock=
s_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span>=
     {</span><br><span>@@ -984,7 +984,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-process_incoming_link_part1(struct context *c, struct link_socket_info=
 *lsi, bool floated)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+process_incoming_link_part1(struct context *c, const struct link_socket_in=
fo *lsi, bool floated)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>     bool decrypt_status =3D false;</s=
pan><br><span>@@ -1534,7 +1534,7 @@</span><br><span>  * @param client    De=
termines whether to the send packet back via tun or link</span><br><span>  =
*/</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool c=
lient)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_send_icm=
p_unreachable(struct context *c, const struct buffer *buf, bool client)</sp=
an><br><span> {</span><br><span> #define MAX_ICMPV6LEN 1280</span><br><span=
>     struct openvpn_icmp6hdr icmp6out;</span><br><span>diff --git a/src/op=
envpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 0d3e492=
=2E=2Ed8e07fa 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><b=
r><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -112,7 +112,7 @@</=
span><br><span>  */</span><br><span> void encrypt_sign(struct context *c, b=
ool comp_frag);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int get_server_poll_remaining_time(struct event_timeout *server=
_poll_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int =
get_server_poll_remaining_time(const struct event_timeout *server_poll_time=
out);</span><br><span> </span><br><span> /*********************************=
*************************************/</span><br><span> /**</span><br><span=
>@@ -163,7 +163,7 @@</span><br><span>  *</span><br><span>  * @return true i=
f packet is authenticated, false otherwise=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool process_incoming_link_par=
t1(struct context *c, struct link_socket_info *lsi, bool floated);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool process_incoming_link_p=
art1(struct context *c, const struct link_socket_info *lsi, bool floated);<=
/span><br><span> </span><br><span> /**</span><br><span>  * Continues proces=
sing a packet read from the external network interface=2E</span><br><span>d=
iff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>ind=
ex 0861cb5=2E=2E41fa557 100644</span><br><span>--- a/src/openvpn/init=2Ec</=
span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -817,7 +817,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-init_port_share(struct conte=
xt *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_port_sha=
re(const struct context *c)</span><br><span> {</span><br><span>     if (!po=
rt_share &amp;&amp; (c-&gt;options=2Eport_share_host &amp;&amp; c-&gt;optio=
ns=2Eport_share_port))</span><br><span>     {</span><br><span>@@ -1269,7 +1=
269,7 @@</span><br><span>  * prepending to msg() output=2E</span><br><span>=
  */</span><br><span> const char *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-format_common_name(struct context *c, struct gc_arena *gc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+format_common_name(cons=
t struct context *c, struct gc_arena *gc)</span><br><span> {</span><br><spa=
n>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     if=
 (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1755,7 +1755,7 @@</span><br><sp=
an> </span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct tuntap *tt)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+can_preserve_tun(const stru=
ct tuntap *tt)</span><br><span> {</span><br><span>     if (tt &amp;&amp; tt=
-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br>=
<span>@@ -1777,7 +1777,7 @@</span><br><span>  * @param c pointer to the con=
nection context</span><br><span>  */</span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_block(struct context *c=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block(cons=
t struct context *c)</span><br><span> {</span><br><span> #if defined(_WIN32=
)</span><br><span>     /* Fortify &#39;redirect-gateway block-local&#39; wi=
th firewall rules? */</span><br><span>@@ -1803,7 +1803,7 @@</span><br><span=
>  * @param adapter_index the VPN adapter index</span><br><span>  */</span>=
<br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-del_wfp_block(struct context *c, unsigned long adapter_index)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(const struct conte=
xt *c, unsigned long adapter_index)</span><br><span> {</span><br><span> #if=
 defined(_WIN32)</span><br><span>     if (c-&gt;options=2Eblock_outside_dns=
 || block_local_needed(c-&gt;c1=2Eroute_list))</span><br><span>diff --git a=
/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index 9d5050d=
=2E=2Eaf4393c 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><=
span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -91,7 +91,7 @@</span><br=
><span> </span><br><span> unsigned int pull_permission_mask(const struct co=
ntext *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-const char *format_common_name(struct context *c, struct gc_arena *g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *form=
at_common_name(const struct context *c, struct gc_arena *gc);</span><br><sp=
an> </span><br><span> void reset_coarse_timers(struct context *c);</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/interval=2Eh b/src/openv=
pn/interval=2Eh</span><br><span>index 59051bd=2E=2E0cfe202 100644</span><br=
><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b/src/openvpn/int=
erval=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static inline void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-interval_schedule_wakeup(struct interval *top, interval=
_t *wakeup)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+interval=
_schedule_wakeup(const struct interval *top, interval_t *wakeup)</span><br>=
<span> {</span><br><span>     const time_t local_now =3D now;</span><br><sp=
an>     interval_earliest_wakeup(wakeup, top-&gt;last_test_true + top-&gt;r=
efresh, local_now);</span><br><span>@@ -214,7 +214,7 @@</span><br><span>  *=
 This function does not check if the timeout is actually valid=2E</span><br=
><span>  */</span><br><span> static inline interval_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-event_timeout_remaining(struct event_timeou=
t *et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+event_timeout=
_remaining(const struct event_timeout *et)</span><br><span> {</span><br><sp=
an>     return (interval_t)((et-&gt;last + et-&gt;n) - now);</span><br><spa=
n> }</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=
=2Ec</span><br><span>index 2e1cf05=2E=2Ec04ee4f 100644</span><br><span>--- =
a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br=
><span>@@ -162,7 +162,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_remove=
_by_value(struct hash *hash, void *value)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash, const void *v=
alue)</span><br><span> {</span><br><span>     struct hash_iterator hi;</spa=
n><br><span>     const struct hash_element *he;</span><br><span>diff --git =
a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 04cc3ab=
=2E=2E089637d 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><=
span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -73,7 +73,7 @@</span><br=
><span> </span><br><span> bool hash_remove_fast(struct hash *hash, struct h=
ash_bucket *bucket, const void *key, uint32_t hv);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_remove_by_value(st=
ruct hash *hash, void *value);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void hash_remove_by_value(struct hash *hash, const void *value);=
</span><br><span> </span><br><span> struct hash_iterator</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index 604bbcd=2E=2E17abfd8 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -330,7 +330,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
man_delete_unix_socket(struct management *man)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+man_delete_unix_socket(const struct management *=
man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><s=
pan>     if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_=
CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -675,7 +675,7 @@</span><br=
><span>  * for the log and echo commands=2E</span><br><span>  */</span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man=
_history(struct management *man, const char *parm, const char *type, struct=
 log_history *log,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
an_history(struct management *man, const char *parm, const char *type, cons=
t struct log_history *log,</span><br><span>             bool *realtime, con=
st unsigned int lep_flags)</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span>@@ -843,7 +843,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_forget_passwords(struct management *man=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_forget_passwor=
ds(const struct management *man)</span><br><span> {</span><br><span>     ss=
l_purge_auth(false);</span><br><span>     (void)ssl_clean_auth_token();</sp=
an><br><span>@@ -851,7 +851,7 @@</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-man_net(struct management *man)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+man_net(const struct management *man)</span><br><span> {</spa=
n><br><span>     if (man-&gt;persist=2Ecallback=2Eshow_net)</span><br><span=
>     {</span><br><span>@@ -887,7 +887,7 @@</span><br><span> #ifdef ENABLE_=
PKCS11</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_pkcs11_id_count(struct management *man)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11_id_count=
(const struct management *man)</span><br><span> {</span><br><span>     msg(=
M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_count());=
</span><br><span> }</span><br><span>@@ -1350,7 +1350,7 @@</span><br><span> =
 * @return          Return whether p has n (or at least n) parameters</span=
><br><span>  */</span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-man_need(struct management *man, const char **p, con=
st int n, unsigned int flags)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+man_need(const struct management *man, const char **p, const int =
n, unsigned int flags)</span><br><span> {</span><br><span>     int i;</span=
><br><span>     ASSERT(p[0]);</span><br><span>@@ -2365,7 +2365,7 @@</span><=
br><span>  * the route/ifconfig/open tun command=2E   See doc/android=2Etxt=
 for details=2E</span><br><span>  */</span><br><span> bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-management_android_control(struct mana=
gement *man, const char *command, const char *msg)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+management_android_control(const struct mana=
gement *man, const char *command, const char *msg)</span><br><span> {</span=
><br><span>     if (!man)</span><br><span>     {</span><br><span>@@ -3013,7=
 +3013,7 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-management_up_down(struct =
management *man, const char *updown, const struct env_set *es)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+management_up_down(const struct =
management *man, const char *updown, const struct env_set *es)</span><br><s=
pan> {</span><br><span>     if (man-&gt;settings=2Eflags &amp; MF_UP_DOWN)<=
/span><br><span>     {</span><br><span>@@ -3023,13 +3023,13 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-management_notify(struct management *man, const ch=
ar *severity, const char *type, const char *text)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+management_notify(const struct management *ma=
n, const char *severity, const char *type, const char *text)</span><br><spa=
n> {</span><br><span>     msg(M_CLIENT, &quot;&gt;NOTIFY:%s,%s,%s&quot;, se=
verity, type, text);</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify=
_generic(struct management *man, const char *str)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+management_notify_generic(const struct manage=
ment *man, const char *str)</span><br><span> {</span><br><span>     msg(M_C=
LIENT, &quot;%s&quot;, str);</span><br><span> }</span><br><span>@@ -3115,7 =
+3115,8 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-management_notify_client_cl=
ose(struct management *management, struct man_def_auth_context *mdac,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+management_notify_client_=
close(const struct management *management,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                               struct man_def_auth_c=
ontext *mdac,</span><br><span>                                const struct =
env_set *es)</span><br><span> {</span><br><span>     if ((mdac-&gt;flags &a=
mp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF_CONNECTION_CLOS=
ED))</span><br><span>@@ -3206,7 +3207,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-management_auth_failure(struct management *man, const char *type, cons=
t char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mana=
gement_auth_failure(const struct management *man, const char *type, const c=
har *reason)</span><br><span> {</span><br><span>     if (reason)</span><br>=
<span>     {</span><br><span>@@ -3219,7 +3220,7 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-management_auth_token(struct management *man, const char *toke=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_auth_t=
oken(const struct management *man, const char *token)</span><br><span> {</s=
pan><br><span>     msg(M_CLIENT, &quot;&gt;PASSWORD:Auth-Token:%s&quot;, to=
ken);</span><br><span> }</span><br><span>diff --git a/src/openvpn/manage=2E=
h b/src/openvpn/manage=2Eh</span><br><span>index 1be3549=2E=2Eab68968 10064=
4</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/op=
envpn/manage=2Eh</span><br><span>@@ -376,12 +376,12 @@</span><br><span> </s=
pan><br><span> void management_event_loop_n_seconds(struct management *man,=
 int sec);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void management_up_down(struct management *man, const char *updown, =
const struct env_set *es);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void management_up_down(const struct management *man, const char *up=
down, const struct env_set *es);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void management_notify(struct management *man,=
 const char *severity, const char *type,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void management_notify(const struct management *man, c=
onst char *severity, const char *type,</span><br><span>                    =
    const char *text);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void management_notify_generic(struct management *man, c=
onst char *str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d management_notify_generic(const struct management *man, const char *str);=
</span><br><span> </span><br><span> void management_notify_client_needing_a=
uth(struct management *management,</span><br><span>                        =
                    const unsigned int auth_id,</span><br><span>@@ -391,7 +=
391,7 @@</span><br><span> void management_connection_established(struct man=
agement *management,</span><br><span>                                      =
  struct man_def_auth_context *mdac, const struct env_set *es);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management=
_notify_client_close(struct management *management,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void management_notify_client_close(const=
 struct management *management,</span><br><span>                           =
          struct man_def_auth_context *mdac, const struct env_set *es);</sp=
an><br><span> </span><br><span> void management_learn_addr(struct managemen=
t *management, struct man_def_auth_context *mdac,</span><br><span>@@ -476,1=
2 +476,12 @@</span><br><span>  * OpenVPN calls here to indicate a password =
failure</span><br><span>  */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void management_auth_failure(struct management *ma=
n, const char *type, const char *reason);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void management_auth_failure(const struct management =
*man, const char *type, const char *reason);</span><br><span> </span><br><s=
pan> /*</span><br><span>  * Echo an authentication token to management inte=
rface</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void management_auth_token(struct management *man, const char *token);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_aut=
h_token(const struct management *man, const char *token);</span><br><span> =
</span><br><span> /*</span><br><span>  * These functions drive the bytecoun=
t in/out counters=2E</span><br><span>diff --git a/src/openvpn/mbuf=2Ec b/sr=
c/openvpn/mbuf=2Ec</span><br><span>index 5e1b585=2E=2E39f85ba 100644</span>=
<br><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=
=2Ec</span><br><span>@@ -160,7 +160,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbuf_dereference_i=
nstance(struct mbuf_set *ms, const struct multi_instance *mi)</span><br><sp=
an> {</span><br><span>     if (ms)</span><br><span>     {</span><br><span>d=
iff --git a/src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</span><br><span>ind=
ex cfe698c=2E=2Ee368054 100644</span><br><span>--- a/src/openvpn/mbuf=2Eh</=
span><br><span>+++ b/src/openvpn/mbuf=2Eh</span><br><span>@@ -75,7 +75,7 @@=
</span><br><span> </span><br><span> bool mbuf_extract_item(struct mbuf_set =
*ms, struct mbuf_item *item);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void mbuf_dereference_instance(struct mbuf_set *m=
s, struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void mbuf_dereference_instance(struct mbuf_set *ms, const struct=
 multi_instance *mi);</span><br><span> </span><br><span> static inline bool=
</span><br><span> mbuf_defined(const struct mbuf_set *ms)</span><br><span>d=
iff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index=
 36bbb43=2E=2Ea7242a8 100644</span><br><span>--- a/src/openvpn/mss=2Ec</spa=
n><br><span>+++ b/src/openvpn/mss=2Ec</span><br><span>@@ -43,7 +43,7 @@</sp=
an><br><span>  *              if yes, hand to mss_fixup_dowork()</span><br>=
<span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv4(const struct buff=
er *buf, uint16_t maxmss)</span><br><span> {</span><br><span>     const str=
uct openvpn_iphdr *pip;</span><br><span>     int hlen;</span><br><span>@@ -=
80,7 +80,7 @@</span><br><span>  *              (IPv6 header structure is su=
fficiently different from IPv4=2E=2E=2E)</span><br><span>  */</span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup_ipv=
6(struct buffer *buf, uint16_t maxmss)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss=
)</span><br><span> {</span><br><span>     const struct openvpn_ipv6hdr *pip=
6;</span><br><span>     struct buffer newbuf;</span><br><span>@@ -136,7 +13=
6,7 @@</span><br><span>  */</span><br><span> </span><br><span> void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup_dowork(struct buffe=
r *buf, uint16_t maxmss)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss)</span><br>=
<span> {</span><br><span>     int olen, optlen;</span><br><span>     uint8_=
t *opt;</span><br><span>@@ -239,8 +239,8 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-frame_calculate_fragment(struct frame *frame, struct key_type =
*kt, const struct options *options,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                         struct link_socket_info *lsi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_fragment(s=
truct frame *frame, const struct key_type *kt, const struct options *option=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
        const struct link_socket_info *lsi)</span><br><span> {</span><br><s=
pan> #if defined(ENABLE_FRAGMENT)</span><br><span>     size_t overhead;</sp=
an><br><span>@@ -269,8 +269,8 @@</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-frame_calculate_mssfix(struct frame *frame, struct key_type *kt, const st=
ruct options *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                       struct link_socket_info *lsi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+frame_calculate_mssfix(struct frame *fram=
e, const struct key_type *kt, const struct options *options,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       const struc=
t link_socket_info *lsi)</span><br><span> {</span><br><span>     if (option=
s-&gt;ce=2Emssfix_fixed)</span><br><span>     {</span><br><span>@@ -314,8 +=
314,8 @@</span><br><span> }</span><br><span> </span><br><span> void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_dynamic(struc=
t frame *frame, struct key_type *kt, const struct options *options,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        struc=
t link_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+frame_calculate_dynamic(struct frame *frame, const struct key_type *kt=
, const struct options *options,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        const struct link_socket_info *lsi)</s=
pan><br><span> {</span><br><span>     if (options-&gt;ce=2Efragment &gt; 0)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/mss=2Eh b/=
src/openvpn/mss=2Eh</span><br><span>index 1d092bb=2E=2E6b832a2 100644</span=
><br><span>--- a/src/openvpn/mss=2Eh</span><br><span>+++ b/src/openvpn/mss=
=2Eh</span><br><span>@@ -29,15 +29,15 @@</span><br><span> #include &quot;so=
cket=2Eh&quot;</span><br><span> #include &quot;ssl_common=2Eh&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mss_fi=
xup_ipv4(struct buffer *buf, uint16_t maxmss);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void mss_fixup_ipv4(const struct buffer *buf, ui=
nt16_t maxmss);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void mss_fixup_ipv6(const=
 struct buffer *buf, uint16_t maxmss);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_dowork(struct buffer *buf=
, uint16_t maxmss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss);</span><br=
><span> </span><br><span> /** Set the --mssfix option=2E */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void frame_calculate_dynamic(struct f=
rame *frame, struct key_type *kt,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                             const struct options *options, str=
uct link_socket_info *lsi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void frame_calculate_dynamic(struct frame *frame, const struct key_=
type *kt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                   const struct options *options, const struct link_socket_=
info *lsi);</span><br><span> </span><br><span> /**</span><br><span>  * Chec=
ks and adjusts the fragment and mssfix value according to the</span><br><sp=
an>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span=
>index df94a70=2E=2Ed9f14b3 100644</span><br><span>--- a/src/openvpn/mtcp=
=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -91,7 +9=
1,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_instance_specific_ini=
t(struct multi_context *m, struct multi_instance *mi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_tcp_instance_specific_init(const st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span> {</span>=
<br><span>     /* buffer for queued TCP socket output packets */</span><br>=
<span>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m-&gt;top=2Eoptions=
=2En_bcast_buf);</span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/op=
envpn/mtcp=2Eh</span><br><span>index 9b7d1d2=2E=2Ebb117fa 100644</span><br>=
<span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh=
</span><br><span>@@ -35,7 +35,7 @@</span><br><span> </span><br><span> void =
multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_inst=
ance *mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool multi_tcp_instance_specific_init(struct multi_context *m, struc=
t multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool multi_tcp_instance_specific_init(const struct multi_context *m, str=
uct multi_instance *mi);</span><br><span> </span><br><span> void multi_tcp_=
instance_specific_free(struct multi_instance *mi);</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><b=
r><span>index 50d72d5=2E=2E4828a17 100644</span><br><span>--- a/src/openvpn=
/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -39=
,7 +39,7 @@</span><br><span> </span><br><span> static void</span><br><span>=
 send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_sta=
te *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
            struct tls_auth_standalone *tas, struct session_id *sid,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       con=
st struct tls_auth_standalone *tas, const struct session_id *sid,</span><br=
><span>                        bool request_resend_wkc)</span><br><span> {<=
/span><br><span>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=
=2Epacket_id=2Esend);</span><br><span>@@ -69,7 +69,7 @@</span><br><span> </=
span><br><span>     enum first_packet_verdict verdict;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_auth_stan=
dalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct tls_auth_standalone *tas=
 =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span><br><span> </span><br><spa=
n>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Ef=
rom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index c7=
2c4b2=2E=2Edd4d61d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span=
><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -57,7 +57,7 @@</s=
pan><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><s=
pan> static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-id(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+id(const struct multi_instance *mi)</span><br><span> {</span><=
br><span>     if (mi)</span><br><span>     {</span><br><span>@@ -1315,7 +13=
15,7 @@</span><br><span>  * same common name=2E</span><br><span>  */</span>=
<br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-multi_delete_dup(struct multi_context *m, struct multi_instance *new_mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(stru=
ct multi_context *m, const struct multi_instance *new_mi)</span><br><span> =
{</span><br><span>     if (new_mi)</span><br><span>     {</span><br><span>@=
@ -2260,7 +2260,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_clie=
nt_setup_dco_initial(struct multi_context *m, struct multi_instance *mi,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dco=
_initial(const struct multi_context *m, struct multi_instance *mi,</span><b=
r><span>                                struct gc_arena *gc)</span><br><spa=
n> {</span><br><span>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptions))<=
/span><br><span>@@ -3195,7 +3195,7 @@</span><br><span> </span><br><span> #i=
f defined(ENABLE_DCO)</span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-process_incoming_del_peer(struct multi_context=
 *m, struct multi_instance *mi, dco_context_t *dco)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+process_incoming_del_peer(struct multi_co=
ntext *m, struct multi_instance *mi, const dco_context_t *dco)</span><br><s=
pan> {</span><br><span>     const char *reason =3D &quot;ovpn-dco: unknown =
reason&quot;;</span><br><span>     switch (dco-&gt;dco_del_peer_reason)</sp=
an><br><span>@@ -4226,7 +4226,7 @@</span><br><span> </span><br><span> /* Se=
arches for the address and deletes it if it is owned by the multi_instance =
*/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_unlearn_addr(struct multi_context *m, struct multi_instance=
 *mi, const struct mroute_addr *addr)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_unlearn_addr(struct multi_context *m, const struct =
multi_instance *mi, const struct mroute_addr *addr)</span><br><span> {</spa=
n><br><span>     struct hash_element *he;</span><br><span>     const uint32=
_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><span>@@ -4261,7 +4261,7=
 @@</span><br><span>  * @param a     The new IPv4 address in network byte o=
rder</span><br><span>  */</span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi_conte=
xt *m, struct multi_instance *mi, in_addr_t a)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m,=
 const struct multi_instance *mi, in_addr_t a)</span><br><span> {</span><br=
><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr);</spa=
n><br><span>@@ -4279,7 +4279,7 @@</span><br><span>  * @param a6    The new =
IPv6 address</span><br><span>  */</span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct mult=
i_context *m, struct multi_instance *mi, struct in6_addr a6)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct mult=
i_context *m, const struct multi_instance *mi, struct in6_addr a6)</span><b=
r><span> {</span><br><span>     struct mroute_addr addr;</span><br><span>  =
   CLEAR(addr);</span><br><span>@@ -4395,7 +4395,7 @@</span><br><span> </sp=
an><br><span> bool</span><br><span> multi_check_push_ifconfig_ipv6_extra_ro=
ute(struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                           struct in6_addr *dest)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                       const struct in6_addr *dest)</span><br><span> {</spa=
n><br><span>     const struct options *o =3D &amp;mi-&gt;context=2Eoptions;=
</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Eh b/src=
/openvpn/multi=2Eh</span><br><span>index 3ed08d4=2E=2Ecd7aa3e 100644</span>=
<br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/mul=
ti=2Eh</span><br><span>@@ -520,7 +520,7 @@</span><br><span>  */</span><br><=
span> </span><br><span> static inline void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-set_prefix(struct multi_instance *mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+set_prefix(const struct multi_instan=
ce *mi)</span><br><span> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</=
span><br><span>     if (mi-&gt;msg_prefix[0])</span><br><span>@@ -694,7 +69=
4,7 @@</span><br><span>  */</span><br><span> bool</span><br><span> multi_ch=
eck_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
        struct in6_addr *dest);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                           const struct in6_add=
r *dest);</span><br><span> </span><br><span> /*</span><br><span>  * Check f=
or signals=2E</span><br><span>diff --git a/src/openvpn/networking=2Eh b/src=
/openvpn/networking=2Eh</span><br><span>index bce0c19=2E=2E25233c8 100644</=
span><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/o=
penvpn/networking=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br><span>  *=
/</span><br><span> #if !defined(ENABLE_IPROUTE)</span><br><span> static inl=
ine int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(s=
truct context *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+net_ctx_init(const struct context *c, openvpn_net_ctx=
_t *ctx)</span><br><span> {</span><br><span>     (void)c;</span><br><span> =
    (void)ctx;</span><br><span>@@ -75,7 +75,7 @@</span><br><span>  *</span>=
<br><span>  * @return          0 on success, a negative error code otherwis=
e</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+int net_ctx_init(const struct con=
text *c, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span> /**</s=
pan><br><span>  * Release resources allocated by the internal garbage colle=
ctor</span><br><span>@@ -102,7 +102,7 @@</span><br><span>  * @return       =
   0 on success, negative error code on error</span><br><span>  */</span><b=
r><span> int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_=
t *iface, const char *type,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                  void *arg);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                  const void *arg);</span><br><span> </span=
><br><span> /**</span><br><span>  * Retrieve the interface type</span><br><=
span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/network=
ing_iproute2=2Ec</span><br><span>index a1f3525=2E=2Ef091fb3 100644</span><b=
r><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src=
/openvpn/networking_iproute2=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><b=
r><span> #include &lt;netinet/in=2Eh&gt;</span><br><span> </span><br><span>=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(stru=
ct context *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t =
*ctx)</span><br><span> {</span><br><span>     ctx-&gt;es =3D NULL;</span><b=
r><span>     if (c)</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, con=
st char *type, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *=
type, const void *arg)</span><br><span> {</span><br><span>     struct argv =
argv =3D argv_new();</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><spa=
n>index e6e72d0=2E=2Ea1d220f 100644</span><br><span>--- a/src/openvpn/netwo=
rking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</spa=
n><br><span>@@ -987,7 +987,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *ad=
dr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
itnl_addr_del(sa_family_t af_family, const char *iface, const inet_address_=
t *addr, int prefixlen)</span><br><span> {</span><br><span>     int ifindex=
;</span><br><span> </span><br><span>@@ -1230,8 +1230,8 @@</span><br><span> =
}</span><br><span> </span><br><span> static int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, sa_family_t af=
_family, inet_address_t *dst, int prefixlen,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                inet_address_t *gw, uint32_t table, =
int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_ro=
ute_del(const char *iface, sa_family_t af_family, const inet_address_t *dst=
, int prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             const inet_address_t *gw, uint32_t table, int metric)</span><b=
r><span> {</span><br><span>     int ifindex =3D 0;</span><br><span> </span>=
<br><span>@@ -1308,7 +1308,7 @@</span><br><span> </span><br><span> </span><=
br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ifac=
e_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, void *ar=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(ope=
nvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)<=
/span><br><span> {</span><br><span>     struct sitnl_link_req req =3D {};</=
span><br><span>     int ret =3D -1;</span><br><span>diff --git a/src/openvp=
n/occ=2Eh b/src/openvpn/occ=2Eh</span><br><span>index bda4f18=2E=2E49def4d =
100644</span><br><span>--- a/src/openvpn/occ=2Eh</span><br><span>+++ b/src/=
openvpn/occ=2Eh</span><br><span>@@ -156,7 +156,7 @@</span><br><span>  * via=
 control channel=2E</span><br><span>  * @return control channel exit messag=
e should be used */</span><br><span> static inline bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-cc_exit_notify_enabled(struct context *c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cc_exit_notify_enab=
led(const struct context *c)</span><br><span> {</span><br><span>     /* Che=
ck if we have TLS active at all */</span><br><span>     if (!c-&gt;c2=2Etls=
_multi)</span><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/o=
penvpn/openssl_compat=2Eh</span><br><span>index 3494ce6=2E=2E32e0b6f 100644=
</span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b=
/src/openvpn/openssl_compat=2Eh</span><br><span>@@ -124,7 +124,7 @@</span><=
br><span> /* Mimics the functions but only when the default context without=
</span><br><span>  * options is chosen */</span><br><span> static inline co=
nst EVP_CIPHER *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_C=
IPHER_fetch(void *ctx, const char *algorithm, const char *properties)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_fetch(const vo=
id *ctx, const char *algorithm, const char *properties)</span><br><span> {<=
/span><br><span>     ASSERT(!ctx);</span><br><span>     ASSERT(!properties)=
;</span><br><span>@@ -132,7 +132,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static inline const EVP_MD *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-EVP_MD_fetch(void *ctx, const char *algorithm, cons=
t char *properties)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
EVP_MD_fetch(const void *ctx, const char *algorithm, const char *properties=
)</span><br><span> {</span><br><span>     ASSERT(!ctx);</span><br><span>   =
  ASSERT(!properties);</span><br><span>diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec</span><br><span>index fd0d3fc=2E=2E6d85a23 10064=
4</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/o=
penvpn/options=2Ec</span><br><span>@@ -3050,7 +3050,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(struct connection_e=
ntry *ce, struct local_entry *le, int mode)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+options_postprocess_mutate_le(const struct connecti=
on_entry *ce, struct local_entry *le, int mode)</span><br><span> {</span><b=
r><span>     /* use the global port if none is specified */</span><br><span=
>     if (!le-&gt;port)</span><br><span>@@ -4980,7 +4980,7 @@</span><br><sp=
an> static bool</span><br><span> verify_permission(const char *name, const =
char *file, int line, const uint64_t type,</span><br><span>                =
   const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                  struct opt=
ions *options, bool is_inline)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  const struct options *options, bool is_inline)=
</span><br><span> {</span><br><span>     if (!(type &amp; allowed))</span><=
br><span>     {</span><br><span>@@ -5547,7 +5547,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-show_compression_warning(struct compress_options *in=
fo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_compression=
_warning(const struct compress_options *info)</span><br><span> {</span><br>=
<span>     if (comp_non_stub_enabled(info))</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_pa=
rse=2Ec</span><br><span>index 88ab4d2=2E=2E0e94522 100644</span><br><span>-=
-- a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/option=
s_parse=2Ec</span><br><span>@@ -258,7 +258,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static char *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-read_inline_file(struct in_src *is, const char *close_ta=
g, int *num_lines, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+read_inline_file(const struct in_src *is, const char *c=
lose_tag, int *num_lines, struct gc_arena *gc)</span><br><span> {</span><br=
><span>     char line[OPTION_LINE_SIZE];</span><br><span>     struct buffer=
 buf =3D alloc_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-check_inline_file(struct in_s=
rc *is, char *p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+check_inline_file(const struct in_src *is, char *p[], s=
truct gc_arena *gc)</span><br><span> {</span><br><span>     int num_inline_=
lines =3D 0;</span><br><span> </span><br><span>diff --git a/src/openvpn/oti=
me=2Ec b/src/openvpn/otime=2Ec</span><br><span>index 1608458=2E=2E5d3633c 1=
00644</span><br><span>--- a/src/openvpn/otime=2Ec</span><br><span>+++ b/src=
/openvpn/otime=2Ec</span><br><span>@@ -66,7 +66,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-update_now_usec(struct timeval *tv)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+update_now_usec(const struct timeval *tv)</s=
pan><br><span> {</span><br><span>     const time_t last =3D now;</span><br>=
<span>     update_now(tv-&gt;tv_sec);</span><br><span>diff --git a/src/open=
vpn/otime=2Eh b/src/openvpn/otime=2Eh</span><br><span>index 84e315b=2E=2Eb5=
a9f7c 100644</span><br><span>--- a/src/openvpn/otime=2Eh</span><br><span>++=
+ b/src/openvpn/otime=2Eh</span><br><span>@@ -65,7 +65,7 @@</span><br><span=
> void update_now(const time_t system_time);</span><br><span> </span><br><s=
pan> extern time_t now_usec;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void update_now_usec(struct timeval *tv);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void update_now_usec(const struct timeval *tv)=
;</span><br><span> </span><br><span> static inline int</span><br><span> ope=
nvpn_gettimeofday(struct timeval *tv, void *tz)</span><br><span>diff --git =
a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 35705=
82=2E=2E33bf4ea 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><b=
r><span>+++ b/src/openvpn/proto=2Eh</span><br><span>@@ -248,7 +248,7 @@</sp=
an><br><span>  * and offset of IP header (via parameter)=2E</span><br><span=
>  */</span><br><span> static inline int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int =
*ip_hdr_offset)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_=
tun_ip_ver(int tunnel_type, const struct buffer *buf, int *ip_hdr_offset)</=
span><br><span> {</span><br><span>     int ip_ver =3D -1;</span><br><span> =
</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec=
</span><br><span>index 4de7615=2E=2Ed4e0a8b 100644</span><br><span>--- a/sr=
c/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><=
span>@@ -527,8 +527,9 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_pr=
oxy_headers(struct http_proxy_info *p, socket_descriptor_t sd, /* already o=
pen to proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            const char *host                                   /* openvpn s=
erver remote */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_=
proxy_headers(const struct http_proxy_info *p,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  socket_descriptor_t sd, /* alr=
eady open to proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  const char *host        /* openvpn server remote */</sp=
an><br><span> )</span><br><span> {</span><br><span>     char buf[512];</spa=
n><br><span>@@ -597,8 +598,8 @@</span><br><span>                           =
    socket_descriptor_t sd, /* already open to proxy */</span><br><span>   =
                            const char *host,       /* openvpn server remot=
e */</span><br><span>                               const char *port,      =
 /* openvpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                              struct event_timeout *server_poll_timeou=
t, struct buffer *lookahead,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                              struct signal_info *sig_info)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  const struct event_timeout *server_poll_timeout,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              struct buffer =
*lookahead, struct signal_info *sig_info)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span>     char buf[512];=
</span><br><span>diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh=
</span><br><span>index e662e7d=2E=2Ea2f4e47 100644</span><br><span>--- a/sr=
c/openvpn/proxy=2Eh</span><br><span>+++ b/src/openvpn/proxy=2Eh</span><br><=
span>@@ -89,7 +89,7 @@</span><br><span>                                    =
socket_descriptor_t sd, /* already open to proxy */</span><br><span>       =
                             const char *host,       /* openvpn server remo=
te */</span><br><span>                                    const char *port,=
       /* openvpn server port */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                   struct event_timeout *server_=
poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                             const struct event_timeout *server_poll_timeou=
t,</span><br><span>                                    struct buffer *looka=
head, struct signal_info *sig_info);</span><br><span> </span><br><span> uin=
t8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_arena =
*gc);</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec<=
/span><br><span>index 57afacd=2E=2E0e581e5 100644</span><br><span>--- a/src=
/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@=
 -332,7 +332,7 @@</span><br><span>  * the proxy can determine true client o=
rigin=2E</span><br><span>  */</span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-journal_add(const char *journal_dir, s=
truct proxy_connection *pc, struct proxy_connection *cp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+journal_add(const char *journal_dir, c=
onst struct proxy_connection *pc, struct proxy_connection *cp)</span><br><s=
pan> {</span><br><span>     struct openvpn_sockaddr from, to;</span><br><sp=
an> </span><br><span>@@ -410,7 +410,7 @@</span><br><span> static bool</span=
><br><span> proxy_entry_new(struct proxy_connection **list, struct event_se=
t *es,</span><br><span>                 const struct openvpn_sockaddr serve=
r_addr, const socket_descriptor_t sd_client,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                struct buffer *initial_data, const c=
har *journal_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              const struct buffer *initial_data, const char *journal_dir)</=
span><br><span> {</span><br><span>     socket_descriptor_t sd_server;</span=
><br><span>     int status;</span><br><span>@@ -1013,7 +1013,7 @@</span><br=
><span>  * call=2E</span><br><span>  */</span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-port_share_redirect(struct port_sha=
re *ps, const struct buffer *head, socket_descriptor_t sd)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+port_share_redirect(const struct por=
t_share *ps, const struct buffer *head, socket_descriptor_t sd)</span><br><=
span> {</span><br><span>     if (ps)</span><br><span>     {</span><br><span=
>diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh</span><br><span>index=
 557ecf5=2E=2E918ceb6 100644</span><br><span>--- a/src/openvpn/ps=2Eh</span=
><br><span>+++ b/src/openvpn/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span=
><br><span> </span><br><span> bool is_openvpn_protocol(const struct buffer =
*buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void port_share_redirect(struct port_share *ps, const struct buffer *hea=
d, socket_descriptor_t sd);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void port_share_redirect(const struct port_share *ps, const struct =
buffer *head, socket_descriptor_t sd);</span><br><span> </span><br><span> #=
endif /* if PORT_SHARE */</span><br><span> #endif /* ifndef PS_H */</span><=
br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br=
><span>index a030acd=2E=2E373272f 100644</span><br><span>--- a/src/openvpn/=
push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -435=
,7 +435,7 @@</span><br><span> #endif</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_auth_pending_me=
ssages(struct tls_multi *tls_multi, struct tls_session *session,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+send_auth_pending_messages(con=
st struct tls_multi *tls_multi, struct tls_session *session,</span><br><spa=
n>                            const char *extra, unsigned int timeout)</spa=
n><br><span> {</span><br><span>     struct key_state *ks =3D &amp;session-&=
gt;key[KS_PRIMARY];</span><br><span>diff --git a/src/openvpn/push=2Eh b/src=
/openvpn/push=2Eh</span><br><span>index dff945f=2E=2E39302f6 100644</span><=
br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=
=2Eh</span><br><span>@@ -117,7 +117,7 @@</span><br><span>  * doc/management=
-notes=2Etxt under client-pending-auth for</span><br><span>  * more details=
 on message format</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool send_auth_pending_messages(struct tls_multi *tls_mul=
ti, struct tls_session *session,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool send_auth_pending_messages(const struct tls_multi *tls_mu=
lti, struct tls_session *session,</span><br><span>                         =
        const char *extra, unsigned int timeout);</span><br><span> </span><=
br><span> void send_restart(struct context *c, const char *kill_msg);</span=
><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=
=2Ec</span><br><span>index af22af5=2E=2E008d45f 100644</span><br><span>--- =
a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec=
</span><br><span>@@ -222,7 +222,7 @@</span><br><span> </span><br><span> /* =
Return true if the client supports push-update */</span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-support_push_updat=
e(struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+support_push_update(const struct multi_instance *mi)</span><br><sp=
an> {</span><br><span>     ASSERT(mi-&gt;context=2Ec2=2Etls_multi);</span><=
br><span>     const unsigned int iv_proto_peer =3D extract_iv_proto(mi-&gt;=
context=2Ec2=2Etls_multi-&gt;peer_info);</span><br><span>diff --git a/src/o=
penvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index 52adac=
f=2E=2E3588483 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span>=
<br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -92,7 +92,7 @@<=
/span><br><span> </span><br><span> /* check if a particular packet_id is pr=
esent in ack */</span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-reliable_ack_packet_id_present(struct relia=
ble_ack *ack, packet_id_type pid)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+reliable_ack_packet_id_present(const struct reliable_ack *ack=
, packet_id_type pid)</span><br><span> {</span><br><span>     for (int i =
=3D 0; i &lt; ack-&gt;len; ++i)</span><br><span>     {</span><br><span>@@ -=
733,7 +733,7 @@</span><br><span>  */</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active=
_incoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_mark_active_in=
coming(struct reliable *rel, const struct buffer *buf, packet_id_type pid,<=
/span><br><span>                               int opcode)</span><br><span>=
 {</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><=
br><span>@@ -793,7 +793,7 @@</span><br><span> </span><br><span> /* delete a=
 buffer previously activated by reliable_mark_active() */</span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_del=
eted(struct reliable *rel, struct buffer *buf)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+reliable_mark_deleted(struct reliable *rel, cons=
t struct buffer *buf)</span><br><span> {</span><br><span>     for (int i =
=3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><sp=
an>index a5ed75c=2E=2E8d9e2e3 100644</span><br><span>--- a/src/openvpn/reli=
able=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ =
-173,7 +173,7 @@</span><br><span>  * @li False, if there are packet IDs to =
be acknowledged=2E</span><br><span>  */</span><br><span> static inline bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(st=
ruct reliable_ack *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+reliable_ack_empty(const struct reliable_ack *ack)</span><br><span> {</=
span><br><span>     return !ack-&gt;len;</span><br><span> }</span><br><span=
>@@ -186,7 +186,7 @@</span><br><span>  * @returns the number of outstanding=
 acks</span><br><span>  */</span><br><span> static inline int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_outstanding(struct rel=
iable_ack *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reli=
able_ack_outstanding(const struct reliable_ack *ack)</span><br><span> {</sp=
an><br><span>     return ack-&gt;len;</span><br><span> }</span><br><span>@@=
 -336,7 +336,7 @@</span><br><span>  * @param pid The packet&#39;s packet ID=
=2E</span><br><span>  * @param opcode The packet&#39;s opcode=2E</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void reliab=
le_mark_active_incoming(struct reliable *rel, struct buffer *buf, packet_id=
_type pid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void reli=
able_mark_active_incoming(struct reliable *rel, const struct buffer *buf, p=
acket_id_type pid,</span><br><span>                                    int =
opcode);</span><br><span> </span><br><span> /**</span><br><span>@@ -389,7 +=
389,7 @@</span><br><span>  * @param rel The reliable structure associated w=
ith the given buffer=2E</span><br><span>  * @param buf The buffer of the re=
liable entry which is to be removed=2E</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_deleted(struct rel=
iable *rel, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void reliable_mark_deleted(struct reliable *rel, const struct =
buffer *buf);</span><br><span> </span><br><span> /** @} name Functions for =
extracting incoming packets */</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 1d3e=
a86=2E=2E590d844 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><=
br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -898,8 +898,9 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-add_bypass_routes(struct route_by=
pass *rb, in_addr_t gateway, const struct tuntap *tt,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  unsigned int flags, const=
 struct route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+add_bypass_routes(const struct route_bypass *rb, in_addr_t gat=
eway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
    const struct tuntap *tt, unsigned int flags,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  const struct route_gateway_i=
nfo *rgi,</span><br><span>                   const struct env_set *es, open=
vpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     int ret =3D tru=
e;</span><br><span>@@ -916,8 +917,9 @@</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-del_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const=
 struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                unsigned int flags, const struct route_gateway_info *rgi,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+del_bypass_routes(con=
st struct route_bypass *rb, in_addr_t gateway,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  const struct tuntap *tt, unsig=
ned int flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
             const struct route_gateway_info *rgi,</span><br><span>        =
           const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><spa=
n> {</span><br><span>     int i;</span><br><span>@@ -3942,7 +3944,7 @@</spa=
n><br><span> #else  /* if defined(_WIN32) */</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_b=
ypass_addresses(struct route_bypass *rb, const unsigned int flags) /* PLATF=
ORM-SPECIFIC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_=
bypass_addresses(struct route_bypass *rb, const unsigned int flags)</span><=
br><span> {</span><br><span> }</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>inde=
x 6d9bb62=2E=2Ec29009e 100644</span><br><span>--- a/src/openvpn/schedule=2E=
c</span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -501,7 =
+501,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_debug(struct schedul=
e *s, int *count, struct timeval *least)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+schedule_debug(const struct schedule *s, int *count, s=
truct timeval *least)</span><br><span> {</span><br><span>     struct timeva=
l min;</span><br><span>     struct timeval max;</span><br><span>diff --git =
a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 038=
2aea=2E=2E5474e94 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span=
><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -647,7 +647,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bind_local(struct link_socket =
*sock, const sa_family_t ai_family)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bind_local(const struct link_socket *sock, const sa_family_=
t ai_family)</span><br><span> {</span><br><span>     /* bind to local addre=
ss/port */</span><br><span>     if (sock-&gt;bind_local)</span><br><span>@@=
 -914,8 +914,8 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_bind(socket_d=
escriptor_t sd, struct addrinfo *local, int ai_family, const char *prefix,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bool ipv6o=
nly)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_bind(soc=
ket_descriptor_t sd, const struct addrinfo *local, int ai_family,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            const char *prefi=
x, bool ipv6only)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span> </span><br><span>@@ -1123,8 +1123,8 @@</sp=
an><br><span>  * such as TCP=2E</span><br><span>  */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static void stream_buf_ini=
t(struct stream_buf *sb, struct buffer *buf, const unsigned int sockflags,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      const int proto);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void stream_buf_init(struct stream_buf *sb, const struct buffer =
*buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
              const unsigned int sockflags, const int proto);</span><br><sp=
an> </span><br><span> static void stream_buf_close(struct stream_buf *sb);<=
/span><br><span> </span><br><span>@@ -1481,7 +1481,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-phase2_set_socket_flags(struct link_socket *sock)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+phase2_set_socket_fl=
ags(const struct link_socket *sock)</span><br><span> {</span><br><span>    =
 /* set misc socket parameters */</span><br><span>     socket_set_flags(soc=
k-&gt;sd, sock-&gt;sockflags);</span><br><span>@@ -2073,7 +2073,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-stream_buf_init(struct stream_buf *sb=
, struct buffer *buf, const unsigned int sockflags,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+stream_buf_init(struct stream_buf *sb, co=
nst struct buffer *buf, const unsigned int sockflags,</span><br><span>     =
            const int proto)</span><br><span> {</span><br><span>     sb-&gt=
;buf_init =3D *buf;</span><br><span>@@ -2337,7 +2337,7 @@</span><br><span> =
#endif</span><br><span> </span><br><span> static socklen_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-link_socket_read_udp_posix_recvmsg(str=
uct link_socket *sock, struct buffer *buf,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+link_socket_read_udp_posix_recvmsg(const struct link=
_socket *sock, struct buffer *buf,</span><br><span>                        =
            struct link_socket_actual *from)</span><br><span> {</span><br><=
span>     struct iovec iov;</span><br><span>@@ -2405,7 +2405,7 @@</span><br=
><span> #endif /* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_read=
_udp_posix(struct link_socket *sock, struct buffer *buf,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_posix(const struc=
t link_socket *sock, struct buffer *buf,</span><br><span>                  =
          struct link_socket_actual *from)</span><br><span> {</span><br><sp=
an>     socklen_t fromlen =3D sizeof(from-&gt;dest=2Eaddr);</span><br><span=
>@@ -2462,7 +2462,7 @@</span><br><span> #if ENABLE_IP_PKTINFO</span><br><sp=
an> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struc=
t buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_=
socket_write_udp_posix_sendmsg(const struct link_socket *sock, const struct=
 buffer *buf,</span><br><span>                                     struct l=
ink_socket_actual *to)</span><br><span> {</span><br><span>     struct iovec=
 iov;</span><br><span>@@ -2656,7 +2656,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-socket_send_queue(struct link_socket *sock, struct buffer *buf, const =
struct link_socket_actual *to)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+socket_send_queue(struct link_socket *sock, const struct buffer =
*buf, const struct link_socket_actual *to)</span><br><span> {</span><br><sp=
an>     if (sock-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><sp=
an>     {</span><br><span>@@ -2756,8 +2756,8 @@</span><br><span>     return=
 sock-&gt;writes=2Eiostate;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-read_sockaddr_from_overlapped(struct overlapped_i=
o *io, struct sockaddr *dst, int overlapped_ret)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+read_sockaddr_from_overlapped(const struct overlapped_=
io *io, struct sockaddr *dst, int overlapped_ret)</span><br><span> {</span>=
<br><span>     if (overlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/socket=2Eh=
 b/src/openvpn/socket=2Eh</span><br><span>index 71a3595=2E=2E6771ec5 100644=
</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/ope=
nvpn/socket=2Eh</span><br><span>@@ -267,7 +267,7 @@</span><br><span> </span=
><br><span> int socket_recv_queue(struct link_socket *sock, int maxsize);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int s=
ocket_send_queue(struct link_socket *sock, struct buffer *buf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int socket_send_queue(struct lin=
k_socket *sock, const struct buffer *buf,</span><br><span>                 =
      const struct link_socket_actual *to);</span><br><span> </span><br><sp=
an> typedef struct</span><br><span>@@ -347,8 +347,8 @@</span><br><span> </s=
pan><br><span> struct link_socket *link_socket_new(void);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void socket_bind(sock=
et_descriptor_t sd, struct addrinfo *local, int af_family, const char *pref=
ix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 b=
ool ipv6only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_fa=
mily,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   const char *prefix, bool ipv6only);</span><br><span> </span><br><span> i=
nt openvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, i=
nt connect_timeout,</span><br><span>                     volatile int *sign=
al_received);</span><br><span>@@ -484,7 +484,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static inline bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-link_socket_verify_incoming_addr(struct buffer *b=
uf, const struct link_socket_info *info,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+link_socket_verify_incoming_addr(const struct buffer *=
buf, const struct link_socket_info *info,</span><br><span>                 =
                 const struct link_socket_actual *from_addr)</span><br><spa=
n> {</span><br><span>     if (buf-&gt;len &gt; 0)</span><br><span>@@ -608,7=
 +608,7 @@</span><br><span> </span><br><span> #else  /* ifdef _WIN32 */</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int lin=
k_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int link_socket_read_udp_=
posix(const struct link_socket *sock, struct buffer *buf,</span><br><span> =
                               struct link_socket_actual *from);</span><br>=
<span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><span>@@ -694,=
12 +694,12 @@</span><br><span> </span><br><span> #else /* ifdef _WIN32 */</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize=
_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buf=
fer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t li=
nk_socket_write_udp_posix_sendmsg(const struct link_socket *sock, const str=
uct buffer *buf,</span><br><span>                                          =
   struct link_socket_actual *to);</span><br><span> </span><br><span> </spa=
n><br><span> static inline ssize_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-link_socket_write_udp_posix(struct link_socket *sock, struct b=
uffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_soc=
ket_write_udp_posix(const struct link_socket *sock, const struct buffer *bu=
f,</span><br><span>                             struct link_socket_actual *=
to)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><sp=
an>@@ -715,7 +715,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static inline ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_t=
cp_posix(const struct link_socket *sock, const struct buffer *buf)</span><b=
r><span> {</span><br><span>     return send(sock-&gt;sd, BPTR(buf), BLENZ(b=
uf), MSG_NOSIGNAL);</span><br><span> }</span><br><span>@@ -773,7 +773,7 @@<=
/span><br><span>  * from tunnel packet=2E</span><br><span>  */</span><br><s=
pan> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-link_socket_set_tos(struct link_socket *sock)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+link_socket_set_tos(const struct link_socket *s=
ock)</span><br><span> {</span><br><span>     if (sock &amp;&amp; sock-&gt;p=
tos_defined)</span><br><span>     {</span><br><span>@@ -819,6 +819,8 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* cppcheck-suppress constParameterPoi=
nter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sock is modi=
fied on Windows via &amp;sock-&gt;listen_handle */</span><br><span> static =
inline void</span><br><span> socket_reset_listen_persistent(struct link_soc=
ket *sock)</span><br><span> {</span><br><span>diff --git a/src/openvpn/sock=
et_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index 13f5962=2E=
=2Eadd08ba 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><=
br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -439,7 +439,7=
 @@</span><br><span> </span><br><span> </span><br><span> static inline bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-addrlist_match_proto(=
const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int pr=
oto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+addrlist_match_=
proto(const struct openvpn_sockaddr *a1, const struct addrinfo *addr_list, =
const int proto)</span><br><span> {</span><br><span>     return link_socket=
_proto_connection_oriented(proto) ? addrlist_match(a1, addr_list)</span><br=
><span>                                                         : addrlist_=
port_match(a1, addr_list);</span><br><span>diff --git a/src/openvpn/socks=
=2Ec b/src/openvpn/socks=2Ec</span><br><span>index 19f3d54=2E=2E77ca863 100=
644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/o=
penvpn/socks=2Ec</span><br><span>@@ -82,7 +82,7 @@</span><br><span> </span>=
<br><span> static bool</span><br><span> socks_proxy_recv_char(uint8_t *c, c=
onst char *name, socket_descriptor_t sd,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                      struct event_timeout *server_poll_=
timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
           const struct event_timeout *server_poll_timeout,</span><br><span=
>                       volatile int *signal_received)</span><br><span> {</=
span><br><span>     fd_set reads;</span><br><span>@@ -97,8 +97,8 @@</span><=
br><span> }</span><br><span> </span><br><span> static bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-socks_username_password_auth(struct so=
cks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                             struct event_timeout *ser=
ver_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+so=
cks_username_password_auth(const struct socks_proxy_info *p, socket_descrip=
tor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                   const struct event_timeout *server_poll_timeout,</span><=
br><span>                              volatile int *signal_received)</span=
><br><span> {</span><br><span>     char to_send[516];</span><br><span>@@ -1=
56,8 +156,8 @@</span><br><span> }</span><br><span> </span><br><span> static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_handshake(=
struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                struct event_timeout *serve=
r_poll_timeout, volatile int *signal_received)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+socks_handshake(const struct socks_proxy_info *p=
, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const struct event_timeout *server_poll_timeout, vola=
tile int *signal_received)</span><br><span> {</span><br><span>     uint8_t =
buf[2];</span><br><span>     int len =3D 0;</span><br><span>@@ -231,7 +231,=
7 @@</span><br><span> </span><br><span> static bool</span><br><span> recv_s=
ocks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                 struct event_t=
imeout *server_poll_timeout, volatile int *signal_received)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 const struct event=
_timeout *server_poll_timeout, volatile int *signal_received)</span><br><sp=
an> {</span><br><span>     uint8_t atyp =3D 0;</span><br><span>     int ale=
n =3D 0;</span><br><span>@@ -334,11 +334,11 @@</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-establish_socks_proxy_passthru(struct socks_proxy_info *p,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_passt=
hru(const struct socks_proxy_info *p,</span><br><span>                     =
           socket_descriptor_t sd, /* already open to proxy */</span><br><s=
pan>                                const char *host,       /* openvpn serv=
er remote */</span><br><span>                                const char *se=
rvname,   /* openvpn server port */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                               struct event_timeout *server_p=
oll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                        const struct event_timeout *server_poll_timeout,</s=
pan><br><span>                                struct signal_info *sig_info)=
</span><br><span> {</span><br><span>     char buf[270];</span><br><span>@@ =
-392,10 +392,10 @@</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_socks_pro=
xy_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+establish_socks_proxy_udpassoc(const struct socks_proxy=
_info *p,</span><br><span>                                socket_descriptor=
_t ctrl_sd, /* already open to proxy */</span><br><span>                   =
             struct openvpn_sockaddr *relay_addr,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                               struct event_tim=
eout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                               const struct event_timeout *server_po=
ll_timeout,</span><br><span>                                struct signal_i=
nfo *sig_info)</span><br><span> {</span><br><span>     if (!socks_handshake=
(p, ctrl_sd, server_poll_timeout, &amp;sig_info-&gt;signal_received))</span=
><br><span>diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span=
><br><span>index 846113d=2E=2Ef7c93b6 100644</span><br><span>--- a/src/open=
vpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=2Eh</span><br><span>@=
@ -47,17 +47,17 @@</span><br><span> </span><br><span> void socks_proxy_clos=
e(struct socks_proxy_info *sp);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void establish_socks_proxy_passthru(struct sock=
s_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d establish_socks_proxy_passthru(const struct socks_proxy_info *p,</span><b=
r><span>                                     socket_descriptor_t sd, /* alr=
eady open to proxy */</span><br><span>                                     =
const char *host,       /* openvpn server remote */</span><br><span>       =
                              const char *servname,   /* openvpn server por=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                   struct event_timeout *server_poll_timeout,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
   const struct event_timeout *server_poll_timeout,</span><br><span>       =
                              struct signal_info *sig_info);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void establish_soc=
ks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void establish_socks_proxy_udpassoc(const struct =
socks_proxy_info *p,</span><br><span>                                     s=
ocket_descriptor_t ctrl_sd, /* already open to proxy */</span><br><span>   =
                                  struct openvpn_sockaddr *relay_addr,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
          struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    const=
 struct event_timeout *server_poll_timeout,</span><br><span>               =
                      struct signal_info *sig_info);</span><br><span> </spa=
n><br><span> void socks_process_incoming_udp(struct buffer *buf, struct lin=
k_socket_actual *from);</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec</span><br><span>index 7f3b4dc=2E=2E262522b 100644</span=
><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
=2Ec</span><br><span>@@ -1159,7 +1159,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> struct tls_multi *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-tls_multi_init(struct tls_options *tls_options)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+tls_multi_init(const struct =
tls_options *tls_options)</span><br><span> {</span><br><span>     struct tl=
s_multi *ret;</span><br><span> </span><br><span>@@ -1188,7 +1188,7 @@</span=
><br><span>  */</span><br><span> </span><br><span> struct tls_auth_standalo=
ne *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_auth_standalo=
ne_init(struct tls_options *tls_options, struct gc_arena *gc)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+tls_auth_standalone_init(const st=
ruct tls_options *tls_options, struct gc_arena *gc)</span><br><span> {</spa=
n><br><span>     struct tls_auth_standalone *tas;</span><br><span> </span><=
br><span>@@ -1336,7 +1336,7 @@</span><br><span> </span><br><span> static vo=
id</span><br><span> init_epoch_keys(struct key_state *ks, struct tls_multi =
*multi, const struct key_type *key_type,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                bool server, struct key2 *key2)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                bool server,=
 const struct key2 *key2)</span><br><span> {</span><br><span>     /* For no=
w we hardcode this to be 16 for the software based data channel</span><br><=
span>      * DCO based implementations/HW implementation might adjust this =
number</span><br><span>@@ -1375,7 +1375,7 @@</span><br><span> </span><br><s=
pan> static void</span><br><span> init_key_contexts(struct key_state *ks, s=
truct tls_multi *multi, const struct key_type *key_type,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                  bool server, struct ke=
y2 *key2, bool dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                  bool server, const struct key2 *key2, bool dco_en=
abled)</span><br><span> {</span><br><span>     struct key_ctx_bi *key =3D &=
amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span> </span><br><span>@=
@ -1573,8 +1573,9 @@</span><br><span> </span><br><span> bool</span><br><spa=
n> tls_session_update_crypto_params_do_work(struct tls_multi *multi, struct=
 tls_session *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                         struct options *options, struct f=
rame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                                struct frame *frame_fragment, struct link_s=
ocket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                      const struct options *options, struct=
 frame *frame,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                    struct frame *frame_fragment,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
            const struct link_socket_info *lsi,</span><br><span>           =
                               dco_context_t *dco)</span><br><span> {</span=
><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ctx_=
bi=2Einitialized)</span><br><span>@@ -1643,7 +1644,7 @@</span><br><span> bo=
ol</span><br><span> tls_session_update_crypto_params(struct tls_multi *mult=
i, struct tls_session *session,</span><br><span>                           =
       struct options *options, struct frame *frame,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                 struct fra=
me *frame_fragment, struct link_socket_info *lsi,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                 struct frame=
 *frame_fragment, const struct link_socket_info *lsi,</span><br><span>     =
                             dco_context_t *dco)</span><br><span> {</span><=
br><span>     if (!check_session_cipher(session, options))</span><br><span>=
@@ -2495,8 +2496,8 @@</span><br><span> }</span><br><span> </span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-session_skip_to_=
pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
     struct link_socket_actual *from)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+session_skip_to_pre_start(struct tls_session *session, co=
nst struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                          const struct link_socket_act=
ual *from)</span><br><span> {</span><br><span>     struct key_state *ks =3D=
 &amp;session-&gt;key[KS_PRIMARY];</span><br><span>     ks-&gt;session_id_r=
emote =3D state-&gt;peer_session_id;</span><br><span>@@ -4011,7 +4012,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-tls_post_encrypt(struct tls_multi *mul=
ti, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)</sp=
an><br><span> {</span><br><span>     struct key_state *ks =3D multi-&gt;sav=
e_ks;</span><br><span>     multi-&gt;save_ks =3D NULL;</span><br><span>@@ -=
4142,7 +4143,7 @@</span><br><span>  * into a garbage collectable string whi=
ch is returned=2E</span><br><span>  */</span><br><span> const char *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-protocol_dump(struct buffer =
*buffer, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+protocol_dump(const struct buffer *buffer, un=
signed int flags, struct gc_arena *gc)</span><br><span> {</span><br><span> =
    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span>     struc=
t buffer buf =3D *buffer;</span><br><span>diff --git a/src/openvpn/ssl=2Eh =
b/src/openvpn/ssl=2Eh</span><br><span>index 5822336=2E=2E3370321 100644</sp=
an><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ss=
l=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><br><span>  *</span><br><sp=
an>  * @return A newly allocated and initialized \c tls_multi structure=2E<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct tls_multi *tls_multi_init(struct tls_options *tls_options);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi *tls_multi_i=
nit(const struct tls_options *tls_options);</span><br><span> </span><br><sp=
an> /**</span><br><span>  * Finalize initialization of a \c tls_multi struc=
ture=2E</span><br><span>@@ -187,7 +187,7 @@</span><br><span> /*</span><br><=
span>  * Initialize a standalone tls-auth verification object=2E</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tls_=
auth_standalone *tls_auth_standalone_init(struct tls_options *tls_options,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_auth_stan=
dalone *tls_auth_standalone_init(const struct tls_options *tls_options,</sp=
an><br><span>                                                      struct g=
c_arena *gc);</span><br><span> </span><br><span> /**</span><br><span>@@ -37=
1,7 +371,7 @@</span><br><span>  * @param multi - The TLS state for this pac=
ket&#39;s destination VPN tunnel=2E</span><br><span>  * @param buf - The bu=
ffer containing the outgoing packet=2E</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void tls_post_encrypt(struct tls_mult=
i *multi, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void tls_post_encrypt(struct tls_multi *multi, const struct buff=
er *buf);</span><br><span> </span><br><span> /** @} name Functions for mana=
ging security parameter state for data channel packets */</span><br><span> =
</span><br><span>@@ -461,7 +461,8 @@</span><br><span>  */</span><br><span> =
bool tls_session_update_crypto_params(struct tls_multi *multi, struct tls_s=
ession *session,</span><br><span>                                       str=
uct options *options, struct frame *frame,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                      struct frame *fr=
ame_fragment, struct link_socket_info *lsi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                      struct frame =
*frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                   const struct link_socket_info *lsi,</spa=
n><br><span>                                       dco_context_t *dco);</sp=
an><br><span> </span><br><span> /*</span><br><span>@@ -525,7 +526,7 @@</spa=
n><br><span> #define PD_VERBOSE                 (1 &lt;&lt; 10)</span><br><=
span> #define PD_TLS_CRYPT               (1 &lt;&lt; 11)</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *protocol_d=
ump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+const char *protocol_dump(=
const struct buffer *buffer, unsigned int flags, struct gc_arena *gc);</spa=
n><br><span> </span><br><span> /*</span><br><span>  * debugging code</span>=
<br><span>@@ -573,7 +574,7 @@</span><br><span> /* Special method to skip th=
e three way handshake RESET stages=2E This is</span><br><span>  * used by t=
he HMAC code when seeing a packet that matches the previous</span><br><span=
>  * HMAC based stateless server state */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool session_skip_to_pre_start(struct tls_session *sess=
ion, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                               struct link_socket_actua=
l *from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool sessi=
on_skip_to_pre_start(struct tls_session *session, const struct tls_pre_decr=
ypt_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                             const struct link_socket_actual *from);</span>=
<br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span><br><s=
pan>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh<=
/span><br><span>index 816fb9c=2E=2Eed395e7 100644</span><br><span>--- a/src=
/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_backend=2Eh<=
/span><br><span>@@ -144,7 +144,7 @@</span><br><span>  *</span><br><span>  *=
 @return      true if the context is initialised, false if not=2E</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool tls_c=
tx_initialised(struct tls_root_ctx *ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool tls_ctx_initialised(const struct tls_root_ctx *c=
tx);</span><br><span> </span><br><span> /**</span><br><span>  * Set any lib=
rary specific options=2E</span><br><span>@@ -177,7 +177,7 @@</span><br><spa=
n>  * @param ciphers       String containing : delimited cipher names, or N=
ULL to use</span><br><span>  *                                      sane de=
faults=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, cons=
t char *ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const cha=
r *ciphers);</span><br><span> </span><br><span> /**</span><br><span>  * Set=
 the TLS certificate profile=2E  The profile defines which crypto</span><br=
><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>index 9d408c0=2E=2E7893be0 100644</span><br><span>--- =
a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>@@ -161,7 +161,7 @@</span><br><span> }</span><br><span=
> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx =
*ctx)</span><br><span> {</span><br><span>     /* either this should be NULL=
 or should be non-null and then have a</span><br><span>      * valid TLS ct=
x inside as well */</span><br><span>@@ -284,7 +284,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, =
const char *ciphers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char =
*ciphers)</span><br><span> {</span><br><span>     if (ciphers =3D=3D NULL)<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_openssl=
=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 306f85cd=2E=2E706d=
78d 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><spa=
n>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -147,7 +147,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct tls_root_ctx *=
ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_initial=
ised(const struct tls_root_ctx *ctx)</span><br><span> {</span><br><span>   =
  /* either this should be NULL or should be non-null and then have a</span=
><br><span>      * valid TLS ctx inside as well */</span><br><span>@@ -509,=
7 +509,7 @@</span><br><span> #endif</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciph=
ers_tls13(struct tls_root_ctx *ctx, const char *ciphers)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restrict_ciphers_tls13(const s=
truct tls_root_ctx *ctx, const char *ciphers)</span><br><span> {</span><br>=
<span>     if (ciphers =3D=3D NULL)</span><br><span>     {</span><br><span>=
@@ -1165,7 +1165,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_l=
oad_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_load_cert_uri(const struct =
tls_root_ctx *tls_ctx, const char *uri)</span><br><span> {</span><br><span>=
 #if defined(HAVE_OPENSSL_STORE_API)</span><br><span>     X509 *x =3D NULL;=
</span><br><span>@@ -2078,7 +2078,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-bio_debug_data(const char *mode, BIO *bio, const uint8_t *buf, int =
len, const char *desc)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bio_debug_data(const char *mode, const BIO *bio, const uint8_t *buf, int=
 len, const char *desc)</span><br><span> {</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span>     if (len &gt; 0)</span><br><span>=
@@ -2092,7 +2092,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bio_debug=
_oc(const char *mode, BIO *bio)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bio_debug_oc(const char *mode, const BIO *bio)</span><br><span>=
 {</span><br><span>     open_biofp();</span><br><span>     fprintf(biofp, &=
quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&quot; ptr_format &quot;\n&q=
uot;, mode, (int64_t)time(NULL),</span><br><span>diff --git a/src/openvpn/s=
sl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 1805995=2E=2E6b5=
3e7e 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+=
++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -57,7 +57,7 @@</span><br><s=
pan>  *  @return         if the swap was successful (buf was large enough)<=
/span><br><span>  */</span><br><span> static bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-swap_hmac(struct buffer *buf, const struct cryp=
to_options *co, bool incoming)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+swap_hmac(const struct buffer *buf, const struct crypto_options =
*co, bool incoming)</span><br><span> {</span><br><span>     ASSERT(co);</sp=
an><br><span> </span><br><span>@@ -117,7 +117,7 @@</span><br><span>  */</sp=
an><br><span> static void</span><br><span> tls_wrap_control(struct tls_wrap=
_ctx *ctx, uint8_t header, struct buffer *buf,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                 struct session_id *session_id)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 struct session_id *session_id)</span><br><span> {</span><br><span>     if =
(ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE)</s=
pan><br><span>     {</span><br><span>@@ -403,9 +403,9 @@</span><br><span> <=
/span><br><span> </span><br><span> struct buffer</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-tls_reset_standalone(struct tls_wrap_ctx *ctx, s=
truct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                     struct session_id *own_sid, struct session_i=
d *remote_sid, uint8_t header,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                     bool request_resend_wkc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+tls_reset_standalone(struct tls_wrap_ctx=
 *ctx, const struct tls_auth_standalone *tas,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     const struct session_id *own=
_sid, const struct session_id *remote_sid,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     uint8_t header, bool request_re=
send_wkc)</span><br><span> {</span><br><span>     /* Copy buffer here to po=
int at the same data but allow tls_wrap_control</span><br><span>      * to =
potentially change buf to point to another buffer without</span><br><span>d=
iff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><sp=
an>index ac9d4be=2E=2Effd34f4 100644</span><br><span>--- a/src/openvpn/ssl_=
pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -2=
20,8 +220,9 @@</span><br><span>  * from the tls pre decrypt state=2E</span>=
<br><span>  *</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, s=
truct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                   struct session_id *own_sid, st=
ruct session_id *remote_sid,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const=
 struct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                   const struct session_id *o=
wn_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                       const struct session_id *remote_sid,</span><br><span=
>                                    uint8_t header, bool request_resend_wk=
c);</span><br><span> </span><br><span> </span><br><span>diff --git a/src/op=
envpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index e5b=
55a1=2E=2E0298106 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</=
span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1137,7 =
+1137,7 @@</span><br><span>  * cache=2E</span><br><span>  */</span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_aut=
hentication_status_use_cache(struct tls_multi *multi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_authentication_status_use_cache(const=
 struct tls_multi *multi)</span><br><span> {</span><br><span>     unsigned =
int idx =3D min_uint(multi-&gt;tas_cache_num_updates, SIZE(cache_intervals)=
 - 1);</span><br><span>     time_t latency =3D cache_intervals[idx];</span>=
<br><span>@@ -1281,7 +1281,7 @@</span><br><span>  * Check if the script/plu=
gin left a message in the auth failed message</span><br><span>  * file and =
relay it to the user */</span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_for_client_reason(struct tls_multi *m=
ulti, struct auth_deferred_status *status)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_for_client_reason(struct tls_multi *multi, con=
st struct auth_deferred_status *status)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     const char *msg =
=3D key_state_check_auth_failed_message_file(status, &amp;gc);</span><br><s=
pan>@@ -1550,7 +1550,7 @@</span><br><span> #endif /* ifdef ENABLE_MANAGEMEN=
T */</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-set_verify_user_pass_env(struct user_pass *=
up, struct tls_multi *multi, struct tls_session *session)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+set_verify_user_pass_env(const struct=
 user_pass *up, struct tls_multi *multi, struct tls_session *session)</span=
><br><span> {</span><br><span>     /* Is username defined? */</span><br><sp=
an>     if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTION=
AL) || strlen(up-&gt;username))</span><br><span>@@ -1578,7 +1578,7 @@</span=
><br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ssl_verify_username_length(struct tls_sessi=
on *session, const char *username)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ssl_verify_username_length(const struct tls_session *session=
, const char *username)</span><br><span> {</span><br><span>     if ((sessio=
n-&gt;opt-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span=
>         &amp;&amp; strlen(username) &gt; TLS_USERNAME_LEN)</span><br><spa=
n>diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh</spa=
n><br><span>index 3176d76=2E=2Ee77bc4a 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify=2Eh</span>=
<br><span>@@ -202,7 +202,7 @@</span><br><span>  * @return              true=
 if name is under limit or username-as-common-name</span><br><span>  *     =
                 is not active</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool ssl_verify_username_length(struct tls_=
session *session, const char *username);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool ssl_verify_username_length(const struct tls_sessi=
on *session, const char *username);</span><br><span> </span><br><span> /**<=
/span><br><span>  * Runs the --client-crresponse script if one is defined=
=2E</span><br><span>@@ -275,7 +275,7 @@</span><br><span> void auth_set_clie=
nt_reason(struct tls_multi *multi, const char *client_reason);</span><br><s=
pan> </span><br><span> static inline const char *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-tls_client_reason(struct tls_multi *multi)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_client_reason(const =
struct tls_multi *multi)</span><br><span> {</span><br><span>     return mul=
ti-&gt;client_reason;</span><br><span> }</span><br><span>diff --git a/src/o=
penvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><span>index c7d375b=2E=
=2Ecfbc38d 100644</span><br><span>--- a/src/openvpn/status=2Ec</span><br><s=
pan>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -135,7 +135,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-status_reset(struct status_output *so)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+status_reset(const struc=
t status_output *so)</span><br><span> {</span><br><span>     if (so &amp;&a=
mp; so-&gt;fd &gt;=3D 0)</span><br><span>     {</span><br><span>diff --git =
a/src/openvpn/status=2Eh b/src/openvpn/status=2Eh</span><br><span>index 795=
3a4e=2E=2E4c01d75 100644</span><br><span>--- a/src/openvpn/status=2Eh</span=
><br><span>+++ b/src/openvpn/status=2Eh</span><br><span>@@ -69,7 +69,7 @@</=
span><br><span> </span><br><span> bool status_trigger(struct status_output =
*so);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void status_reset(struct status_output *so);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void status_reset(const struct status_output *so=
);</span><br><span> </span><br><span> void status_flush(struct status_outpu=
t *so);</span><br><span> </span><br><span>diff --git a/src/openvpn/tun=2Ec =
b/src/openvpn/tun=2Ec</span><br><span>index bc262cd=2E=2E97491a9 100644</sp=
an><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tu=
n=2Ec</span><br><span>@@ -835,7 +835,7 @@</span><br><span>          const c=
har *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */</span><br><=
span>          int ifconfig_ipv6_netbits_parm,</span><br><span>          co=
nst char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         struct addrinfo *lo=
cal_public, struct addrinfo *remote_public, const bool strict_warn,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         const struct addri=
nfo *local_public, const struct addrinfo *remote_public, const bool strict_=
warn,</span><br><span>          struct env_set *es, openvpn_net_ctx_t *ctx,=
 struct tuntap *tt)</span><br><span> {</span><br><span>     if (!tt)</span>=
<br><span>@@ -978,7 +978,7 @@</span><br><span>  * -&gt; helper function to =
simplify code below</span><br><span>  */</span><br><span> static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-add_route_connected_v6_net(=
struct tuntap *tt, const struct env_set *es)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+add_route_connected_v6_net(const struct tuntap *tt=
, const struct env_set *es)</span><br><span> {</span><br><span>     struct =
route_ipv6 r6;</span><br><span> </span><br><span>@@ -1020,7 +1020,7 @@</spa=
n><br><span>  */</span><br><span> </span><br><span> in_addr_t</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-create_arbitrary_remote(struct tunt=
ap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+create_arbit=
rary_remote(const struct tuntap *tt)</span><br><span> {</span><br><span>   =
  in_addr_t remote;</span><br><span> </span><br><span>@@ -1592,7 +1592,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv4(struct tunt=
ap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *=
ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span><b=
r><span>     int netbits =3D netmask_to_netbits2(tt-&gt;remote_netmask);</s=
pan><br><span>@@ -1627,7 +1627,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6(const str=
uct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>=
 #if defined(TARGET_LINUX)</span><br><span>     if (net_addr_v6_del(ctx, tt=
-&gt;actual_name, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</spa=
n><br><span>@@ -1652,7 +1652,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo=
_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig(const struct tuntap *tt, op=
envpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     if (tt-&gt;ba=
ckend_driver !=3D DRIVER_NULL &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_=
AFUNIX)</span><br><span>     {</span><br><span>@@ -1729,7 +1729,7 @@</span>=
<br><span> #endif</span><br><span> </span><br><span> static ssize_t</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_header(struct tunta=
p *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+write_tun_header(const struct tuntap *tt, const uint8_t *buf, int=
 len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TY=
PE_TUN)</span><br><span>     {</span><br><span>@@ -1746,9 +1746,11 @@</span=
><br><span>             type =3D htonl(AF_INET);</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
/* argument to writev is a pointer to const but we still need to drop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	 * the const from buf po=
inter here */</span><br><span>         iv[0]=2Eiov_base =3D &amp;type;</spa=
n><br><span>         iv[0]=2Eiov_len =3D sizeof(type);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_base =3D buf;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        iv[1]=2Eiov_base =3D=
 (void *)buf;</span><br><span>         iv[1]=2Eiov_len =3D len;</span><br><=
span> </span><br><span>         return header_modify_read_write_return(writ=
ev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1760,7 +1762,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static ssize_t</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-read_tun_header(struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read=
_tun_header(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><sp=
an>     {</span><br><span>@@ -1786,13 +1788,13 @@</span><br><span>  */</spa=
n><br><span> #if !defined(TARGET_DARWIN)</span><br><span> ssize_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br>=
<span> {</span><br><span>     return write_tun_header(tt, buf, len);</span>=
<br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf,=
 int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(c=
onst struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br=
><span>     return read_tun_header(tt, buf, len);</span><br><span> }</span>=
<br><span>@@ -1808,7 +1810,7 @@</span><br><span> </span><br><span> #if defi=
ned(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_dco_enabled(struct =
tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_dco_=
enabled(const struct tuntap *tt)</span><br><span> {</span><br><span>     re=
turn tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span><br>=
<span>@@ -2055,13 +2057,13 @@</span><br><span> }</span><br><span> </span><b=
r><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write=
_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     return write(tt-&gt=
;fd, buf, len);</span><br><span> }</span><br><span> </span><br><span> ssize=
_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tun=
tap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+read_tun(const struct tuntap *tt, const uint8_t *buf, int len)<=
/span><br><span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</=
span><br><span> }</span><br><span>@@ -2260,13 +2262,13 @@</span><br><span> =
}</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const stru=
ct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><s=
pan>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><s=
pan> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, u=
int8_t *buf, int len)</span><br><span> {</span><br><span>     return read(t=
t-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -2596,7 +2598,7 =
@@</span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uin=
t8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     struct strbuf sbuf;</span><br><span>     sbuf=
=2Elen =3D len;</span><br><span>@@ -2605,7 +2607,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tun=
tap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     str=
uct strbuf sbuf;</span><br><span>     int f =3D 0;</span><br><span>@@ -3320=
,7 +3322,7 @@</span><br><span> }</span><br><span> </span><br><span> int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tu=
ntap *tt, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tun_write_queue(struct tuntap *tt, const struct buffer *buf)</spa=
n><br><span> {</span><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOST=
ATE_INITIAL)</span><br><span>     {</span><br><span>@@ -3375,7 +3377,7 @@</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struc=
t buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_w=
rite_win32(struct tuntap *tt, const struct buffer *buf)</span><br><span> {<=
/span><br><span>     int err =3D 0;</span><br><span>     int status =3D 0;<=
/span><br><span>@@ -5383,7 +5385,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
fork_register_dns_action(struct tuntap *tt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+fork_register_dns_action(const struct tuntap *tt)</=
span><br><span> {</span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Er=
egister_dns &amp;&amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {=
</span><br><span>@@ -5473,7 +5475,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tuntap_get_mtu(struct tuntap *tt)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tuntap_get_mtu(const struct tuntap *tt)</span><br><sp=
an> {</span><br><span>     ULONG mtu =3D 0;</span><br><span>     DWORD len;=
</span><br><span>@@ -6048,7 +6050,7 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-tun_show_debug(struct tuntap *tt)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tun_show_debug(const struct tuntap *tt)</span><br><span> {</=
span><br><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WIN=
DOWS6)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/tun=
=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 6a7af85=2E=2E41b93cb 10064=
4</span><br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openv=
pn/tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br><span> </span><br>=
<span> void close_tun_handle(struct tuntap *tt);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t write_tun(struct tunta=
p *tt, uint8_t *buf, int len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf, i=
nt len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(const struct =
tuntap *tt, uint8_t *buf, int len);</span><br><span> </span><br><span> #ifd=
ef ENABLE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *dev,=
 const char *dev_type, const char *dev_node, int persist_mode,</span><br><s=
pan>@@ -293,7 +293,7 @@</span><br><span>                         const char=
 *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */</span><br><s=
pan>                         int ifconfig_ipv6_netbits_parm,           /* -=
-ifconfig parm 1 / bits */</span><br><span>                         const c=
har *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        struct =
addrinfo *local_public, struct addrinfo *remote_public,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        const struct ad=
drinfo *local_public, const struct addrinfo *remote_public,</span><br><span=
>                         const bool strict_warn, struct env_set *es, openv=
pn_net_ctx_t *ctx,</span><br><span>                         struct tuntap *=
tt);</span><br><span> </span><br><span>@@ -320,7 +320,7 @@</span><br><span>=
  * @param tt    the tuntap interface context</span><br><span>  * @param ct=
x   the networking API opaque context</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(struct tuntap *tt, =
openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);</=
span><br><span> </span><br><span> bool is_dev_type(const char *dev, const c=
har *dev_type, const char *match_type);</span><br><span> </span><br><span>@=
@ -351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEFAULT IFCONFIG_AFTER=
_TUN_OPEN</span><br><span> </span><br><span> static inline int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(struct tuntap *tt)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(const=
 struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;back=
end_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ =
-381,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_T=
UN</span><br><span> </span><br><span> static inline int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-route_order(struct tuntap *tt)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+route_order(const struct tunta=
p *tt)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =
=3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -454,13 +45=
4,13 @@</span><br><span> </span><br><span> const char *tap_win_getinfo(cons=
t struct tuntap *tt, struct gc_arena *gc);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug(struct tuntap *t=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tun_show_de=
bug(const struct tuntap *tt);</span><br><span> </span><br><span> bool dhcp_=
release_by_adapter_index(const DWORD adapter_index);</span><br><span> </spa=
n><br><span> bool dhcp_renew_by_adapter_index(const DWORD adapter_index);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
fork_register_dns_action(struct tuntap *tt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void fork_register_dns_action(const struct tuntap =
*tt);</span><br><span> </span><br><span> void ipconfig_register_dns(const s=
truct env_set *es);</span><br><span> </span><br><span>@@ -470,7 +470,7 @@</=
span><br><span> </span><br><span> int tun_read_queue(struct tuntap *tt, int=
 maxsize);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-int tun_write_queue(struct tuntap *tt, struct buffer *buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_queue(struct t=
untap *tt, const struct buffer *buf);</span><br><span> </span><br><span> st=
atic inline bool</span><br><span> tuntap_stop(int status)</span><br><span>@=
@ -499,7 +499,7 @@</span><br><span>     return false;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int tu=
n_write_win32(struct tuntap *tt, struct buffer *buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int tun_write_win32(struct tuntap *tt, co=
nst struct buffer *buf);</span><br><span> </span><br><span> static inline b=
ool</span><br><span> is_ip_packet_valid(const struct buffer *buf)</span><br=
><span>@@ -529,13 +529,13 @@</span><br><span> }</span><br><span> </span><br=
><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br>=
<span> {</span><br><span>     return tt &amp;&amp; tt-&gt;backend_driver =
=3D=3D DRIVER_DCO;</span><br><span> }</span><br><span> </span><br><span> st=
atic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunta=
p_is_dco_win_timeout(struct tuntap *tt, int status)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct tu=
ntap *tt, int status)</span><br><span> {</span><br><span>     return tuntap=
_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openvpn_errno() =3D=
=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><span>@@ -555,25 +=
555,25 @@</span><br><span> }</span><br><span> </span><br><span> static inli=
ne void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_standby_in=
it(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+tun_standby_init(const struct tuntap *tt)</span><br><span> {</span><br><s=
pan> }</span><br><span> </span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-tun_standby(struct tuntap *tt)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_standby(const struct =
tuntap *tt)</span><br><span> {</span><br><span>     return true;</span><br>=
<span> }</span><br><span> </span><br><span> </span><br><span> static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_wi=
n(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+tuntap_is_dco_win(const struct tuntap *tt)</span><br><span> {</span><br><s=
pan>     return false;</span><br><span> }</span><br><span> </span><br><span=
> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-t=
untap_is_dco_win_timeout(struct tuntap *tt, int status)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct =
tuntap *tt, int status)</span><br><span> {</span><br><span>     return fals=
e;</span><br><span> }</span><br><span>diff --git a/src/openvpn/tun_afunix=
=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span>index a67a472=2E=2Ee9223b=
c 100644</span><br><span>--- a/src/openvpn/tun_afunix=2Ec</span><br><span>+=
++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@@ -48,7 +48,7 @@</span><br=
><span> </span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec_child(const char *dev_nod=
e, struct tuntap *tt, struct env_set *env)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+tun_afunix_exec_child(const char *dev_node, struct t=
untap *tt, const struct env_set *env)</span><br><span> {</span><br><span>  =
   const char *msgprefix =3D &quot;ERROR: failure executing process for tun=
:&quot;;</span><br><span>     struct argv argv =3D argv_new();</span><br><s=
pan>@@ -73,7 +73,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_tun_afunix(=
struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(const =
struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig_e=
nv)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new()=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/tun_afunix=2Eh=
 b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=2E=2Efb88eb2 10=
0644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span><br><span>+++ b=
/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 @@</span><br><sp=
an>  * the user provided taking care of implementing the actual tun</span><=
br><span>  * device=2E</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *o, int mtu, stru=
ct tuntap *tt, struct env_set *env);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void open_tun_afunix(const struct options *o, int mtu, str=
uct tuntap *tt, const struct env_set *env);</span><br><span> </span><br><sp=
an> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/vlan=2Ec=
 b/src/openvpn/vlan=2Ec</span><br><span>index bffc60e=2E=2Ecd32a9b 100644</=
span><br><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn=
/vlan=2Ec</span><br><span>@@ -288,7 +288,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-vlan_process_outgoing_tun(struct multi_context *m, struct multi_ins=
tance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vlan_proc=
ess_outgoing_tun(const struct multi_context *m, struct multi_instance *mi)<=
/span><br><span> {</span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tag=
ging)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/vlan=
=2Eh b/src/openvpn/vlan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 1006=
44</span><br><span>--- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/ope=
nvpn/vlan=2Eh</span><br><span>@@ -35,6 +35,6 @@</span><br><span> </span><br=
><span> bool vlan_is_tagged(const struct buffer *buf);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void vlan_process_outgoi=
ng_tun(struct multi_context *m, struct multi_instance *mi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void vlan_process_outgoing_tun(cons=
t struct multi_context *m, struct multi_instance *mi);</span><br><span> </s=
pan><br><span> #endif /* VLAN_H */</span><br><span>diff --git a/src/openvpn=
/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>index ef32062=2E=2Ebcbfa=
67 100644</span><br><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b=
/src/openvpn/win32=2Eh</span><br><span>@@ -226,7 +226,7 @@</span><br><span>=
 void overlapped_io_close(struct overlapped_io *o);</span><br><span> </span=
><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-overlapped_io_active(struct overlapped_io *o)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+overlapped_io_active(const struct overla=
pped_io *o)</span><br><span> {</span><br><span>     return o-&gt;iostate =
=3D=3D IOSTATE_QUEUED || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</sp=
an><br><span> }</span><br><span>diff --git a/src/openvpnmsica/openvpnmsica=
=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index a861e8a=2E=
=2E25fa1e4 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</=
span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -=
77,7 +77,7 @@</span><br><span>  * @return ERROR_SUCCESS on success; An erro=
r code otherwise</span><br><span>  */</span><br><span> static UINT</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE =
hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *seq)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHAN=
DLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *s=
eq)</span><br><span> {</span><br><span>     UINT uiResult;</span><br><span>=
     LPWSTR szSequence =3D msica_arg_seq_join(seq);</span><br><span>diff --=
git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>index 628ec85=2E=2E1fff6af 100644</span><br><span>--- a/src/op=
envpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -521,7 +521,7 @@</span><br><span> </span><br><span>=
 </span><br><span> static SOCKADDR_INET</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-sockaddr_inet(short family, inet_address_t *addr)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+sockaddr_inet(short family,=
 const inet_address_t *addr)</span><br><span> {</span><br><span>     SOCKAD=
DR_INET sa_inet;</span><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_in=
et));</span><br><span>@@ -3733,7 +3733,7 @@</span><br><span> </span><br><sp=
an> static DWORD</span><br><span> UpdateWaitHandles(LPHANDLE *handles_ptr, =
LPDWORD count, HANDLE io_event, HANDLE exit_event,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                  list_item_t *threads)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                  const li=
st_item_t *threads)</span><br><span> {</span><br><span>     static DWORD si=
ze =3D 10;</span><br><span>     static LPHANDLE handles =3D NULL;</span><br=
><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/un=
it_tests/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=2Efff=
4c2b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</sp=
an><br><span>@@ -36,7 +36,7 @@</span><br><span> struct management *manageme=
nt; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct managemen=
t *man, const char *type, const char *reason)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_auth_failure(const struct management *=
man, const char *type, const char *reason)</span><br><span> {</span><br><sp=
an>     ASSERT(false);</span><br><span> }</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec=
</span><br><span>index 4a055e7=2E=2Eaf96764 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static struct hash_element *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct ha=
sh *hash, void *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+hash_lookup_by_value(struct hash *hash, const void *value)</span><br><sp=
an> {</span><br><span>     struct hash_iterator hi;</span><br><span>     st=
ruct hash_element *he;</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><b=
r><span>index c0a0866=2E=2E7636a33 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_user_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span> =
    return mock();</span><br><span> }</span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct manage=
ment *man, const char *type, const char *reason)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+management_auth_failure(const struct managemen=
t *man, const char *type, const char *reason)</span><br><span> {</span><br>=
<span>     assert_true(0);</span><br><span> }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1663?usp=3Demail">change 1663</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1663 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--djs6V/gVuFc=--


--===============1128081481606787969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1128081481606787969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1128081481606787969==--

