Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA90AC5620A
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+Sq4Bfsq5AnHs3kKFDTo1+BNedzz8HJ1BBecSr701w=; b=i6PwkdQuFMS0q3TU2EFKnrS/sQ
	UA6Ul7yaVwzoFM6ivciwRWDEnqvV1HoGmLuGXu4uWJ+22qQEefd3HcWFIIAeGDiu7Y9+c0D3I97Sf
	FCs0Za+iZZxnZMCotBIdfXDJ6JHKv/ytejZLJCrZ6QAwI0xm0l7lbp2/DRUbNi5PUT/g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrv5W-0002AS-EQ;
	Thu, 06 Aug 2026 10:12:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrv5U-0002AK-TC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LsWyKjmLS7rYhIDyImFpL6YW9PLO5lBIvKtuY7Vtg+4=; b=hAew21Aq+uMCXe5C4KJrylSMqx
 +KiJ//GQls9NCJgpUTyLOUYQi4cp/w6vu3UENaTmD33uFzs4YZdhX0vXOK4w8oYclj9A2mnqreY9b
 JjRNLfl6q61Ty3Q/hlfbR+XwNRzaXqPWLaTXdvn+dKuB932oEBAGlClDU0tVXGyMLoYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LsWyKjmLS7rYhIDyImFpL6YW9PLO5lBIvKtuY7Vtg+4=; b=Z
 +LopKuRaH2fx2BjgT547Iag/jrRDVr+KS/2qd6ErJAkVMl6xYxzR8jAuoEAPXqip2h3fTuiqkndPq
 jO5nlw4BAcfug6r0WJhSOkwvm4FuEG49dqA7dyWiIt1a7hUi2GE6sJKjp0Z8duS2u++qZ5kUhPSS+
 HqO35i5XiDA45tHA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrv5R-0003m8-Ui for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:12:32 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1700838f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786011143; x=1786615943; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LsWyKjmLS7rYhIDyImFpL6YW9PLO5lBIvKtuY7Vtg+4=;
 b=T3KELMTu4XZU4kMGoMvYy528r6o0tNcGg6Nc36CfBfFrPZsD02CNP+3FZ8qtvz3y4p
 wSXB05DSgckB8IMWwyEYd90fIiHtAV5ZcGutN1ZObglvfKMhhv59iJqcD7ExjsVXYjfD
 WVE+ptbLqlM5r8iFXhcfIT+G3sPMe6qkVb6Eo18Qq2tb170gHCSQPCPXtPUjbJMd5hCX
 paT8j/56F4hSTzVQfeX0+qunls5gPz8+WW+NZ+6+n7ewBeZQym/EaMSk0FzlxR4pLjuT
 23ak8Wq/CusVRvvz9PtK67/lugjc5Hon0wXUM1U+gknU9SpIkAc+bYWDvezFB9fFU2do
 d63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011143; x=1786615943;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LsWyKjmLS7rYhIDyImFpL6YW9PLO5lBIvKtuY7Vtg+4=;
 b=XBfOK7s4EE2vME/KF1szAYoMhAAgyUhtjcCzqsDrJiHueb3Op2DeBxv6wCb6xzgUm/
 kO8DTryO83OPG0YhvvgrPobT+cpe3luKz5vhuM4W9RhgAPR3DoZ8AhGnve5rtTlF9Dkw
 BLe1CKGMcjWSplpediHf/SRB/MW1GEhH6XTFU9LmkY/Um/2bLDx7tC1M9RSXoY4gtVti
 EqaWAva7Owk3unorhT3sjgVtk79Jk6gKAxz1uLgD3N5ZgCDNePUp/8oivpAOflAf708/
 /2a5RRSNLEYUbgldjX4Pems0TPS+DfNlMhg1qxi1APWShTjT3H7rbPXgtYf+HWvIuTCk
 etpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgiQ+v7EoT5Bj23TTnOTBl7IX9DjoZDL83XnHjZekCxT/q1P8HpvtdPtzJTFlkjX0JtNmH/ETAgv8SlmaS@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzE5l9pwPawPlzsCmGxuc1wUbTaikck8l+5Fcd7Y1rwP4Xz+wWr
 sd29FGnVUjRueZVHISN+Du0EVl+n8brggIVNAMlqwy8G0EtPnYAd7mA1/JvvRz7ER9kHaAoKU4u
 2+/f4OK7HOH6vWnY7XSdRkKTIOLmzz9WpEKa/UFAbLlFZLUdH26daePovj0qAMXggM11i
X-Gm-Gg: AR+sD13BenGDwPdjn7zwG1jSHBWeiJc7wFMh+28rDezC2oq9a03tXecg3jVQy9kreGE
 HRJg8L+4Y3tsW6gSJ5mSopbzDc9SAdRzpY5YVth5kjM54FNdK2tafW/wB7nYgC++JbU5vc27UhQ
 iDxpMZsRa6nKgk1kvngT61eVEZfuiJa/0Gt+aCUFLmhwIkicn/Uq+vt5imRNw+Xa2jfpifW4iSc
 k/ShbRl0eagCqq9CRC7SZ2tq3DWGXIxHLNb6RyYx3rRuNgYwsiAKPq2+zn88G8FAzNBpoR75TEd
 nZ+O1PUQS4nfObkXHPNSGQAk9W5GD+/ACo3d3qOp0G4UOw/LNtdagxnPwHvaX23fsx50EZgnmB0
 GFoZrZCeokh+tOvMQLGKh5uJWQKnjjmUm8Y4APNcg+1O/r2/pE1YnvsqEtsJqfDTOTxOMdtu+C2
 jABo2ycryzkbpXAEPzP1zkuuXD87UpNZJ5PbkamUSESeMtSAR3/GXleX6LSMjtqN+M4SyUDrJi6
 VK7OgFz5xxG9hUKgRGjlLkE2+tthuygqFvhywYSeEh+IyFtgM+FiJDpKHpwc698xoCXRiDp1kAt
 0HLNuL2qV79hQ2Ni36+3dpjjiMQ4c9pGAi3n+2LQgN66hBUeVNo=
X-Received: by 2002:a05:6000:a92:b0:47f:943a:45fa with SMTP id
 ffacd0b85a97d-47fec63ebc2mr17079583f8f.29.1786011143152; 
 Thu, 06 Aug 2026 03:12:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b32487sm4771268f8f.34.2026.08.06.03.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:12:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 10:12:22 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
X-Gerrit-Change-Number: 1834
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1834?usp=email>
X-Gerrit-Commit: 5978a46e3db1013f327bb315d283d5816c3a4526
In-Reply-To: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
References: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzY2MjYwMDAwLkkzZGI3MDAwMWJlN2YzOWNmODRkNTYyNTE3NjQ3ZjFhMzA1OTYyYjQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6643407eb71b86989610e65be427b0b7fa19df79-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrv5R-0003m8-Ui
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove local
 get_random in test_misc.c
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2683953119304297833=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2683953119304297833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="35y6/iEzLDk="; charset=UTF-8

--35y6/iEzLDk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1834?usp=3Demail )

Change subject: Remove local get_random in test_mis=
c=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =
local get_random in test_misc=2Ec

The get_random in test_misc=2Ec conflict=
s
with the get_random function that OpenVPN defines in crypto=2Eh
Also adju=
st the implementation in mock_get_random=2Ec to match the
prototype in cryp=
to=2Eh

Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834
Message-Id: <202608060=
90951=2E20900-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38155=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/mock_=
get_random=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
2 files changed, 3 =
insertions(+), 9 deletions(-)




diff --git a/tests/unit_tests/openvpn/moc=
k_get_random=2Ec b/tests/unit_tests/openvpn/mock_get_random=2Ec
index 0840e=
31=2E=2E5cb768b 100644
--- a/tests/unit_tests/openvpn/mock_get_random=2Ec
+=
++ b/tests/unit_tests/openvpn/mock_get_random=2Ec
@@ -28,7 +28,7 @@
 #inclu=
de <stdint=2Eh>
 #include <cmocka=2Eh>
 
-unsigned long
+int64_t
 get_rando=
m(void)
 {
     /* rand() is not very random, but it's C99 and this is just=
 for testing */
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests=
/unit_tests/openvpn/test_misc=2Ec
index cd86fd2=2E=2E4d046ce 100644
--- a/t=
ests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_m=
isc=2Ec
@@ -38,6 +38,7 @@
 #include "test_common=2Eh"
 #include "list=2Eh"
=
 #include "mock_msg=2Eh"
+#include "crypto=2Eh"
 #ifdef _WIN32
 #include "w=
in32-util=2Eh"
 #endif
@@ -143,13 +144,6 @@
     return strcmp((const char =
*)key1, (const char *)key2) =3D=3D 0;
 }
 
-static uint32_t
-get_random(voi=
d)
-{
-    /* rand() is not very random, but it's C99 and this is just for =
testing */
-    return (uint32_t)rand();
-}
-
 static struct hash_element *=

 hash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -266,7 +260,7 =
@@
         {
             struct hash_iterator hi;
             struct has=
h_element *he;
-            inc =3D (get_random() % 3) + 1;
+            in=
c =3D ((uint32_t)get_random() % 3) + 1;
             hash_iterator_init_ran=
ge(hash, &hi, base, base + inc);
 
             while ((he =3D hash_iterato=
r_next(&hi)))

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1834?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merg=
ed
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3db7000=
1be7f39cf84d562517647f1a305962b42
Gerrit-Change-Number: 1834
Gerrit-PatchSe=
t: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: ordex <antonio@mand=
elbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--35y6/iEzLDk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1834?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Remove local get_random in test_misc=2Ec<b=
r><br>The get_random in test_misc=2Ec conflicts<br>with the get_random func=
tion that OpenVPN defines in crypto=2Eh<br>Also adjust the implementation i=
n mock_get_random=2Ec to match the<br>prototype in crypto=2Eh<br><br>Change=
-Id: I3db70001be7f39cf84d562517647f1a305962b42<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Eco=
m&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834<br>Mes=
sage-Id: &lt;20260806090951=2E20900-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
38155=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>---<br>M tests/unit_tests/openvpn/mock_get_random=2Ec<br>M tests/unit_t=
ests/openvpn/test_misc=2Ec<br>2 files changed, 3 insertions(+), 9 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/mock_get_random=
=2Ec b/tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>index 0=
840e31=2E=2E5cb768b 100644</span><br><span>--- a/tests/unit_tests/openvpn/m=
ock_get_random=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_get_=
random=2Ec</span><br><span>@@ -28,7 +28,7 @@</span><br><span> #include &lt;=
stdint=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned long</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int64_t</span><br><span> =
get_random(void)</span><br><span> {</span><br><span>     /* rand() is not v=
ery random, but it&#39;s C99 and this is just for testing */</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>index cd86fd2=2E=2E4d046ce 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -38,6 +38,7 @@=
</span><br><span> #include &quot;test_common=2Eh&quot;</span><br><span> #in=
clude &quot;list=2Eh&quot;</span><br><span> #include &quot;mock_msg=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;cr=
ypto=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><span> #include &qu=
ot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><span>@@ -143,13 =
+144,6 @@</span><br><span>     return strcmp((const char *)key1, (const cha=
r *)key2) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-get_random(void)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* rand() is not very random, but it&#39;s C99 and this is just for=
 testing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 (uint32_t)rand();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> stati=
c struct hash_element *</span><br><span> hash_lookup_by_value(struct hash *=
hash, void *value)</span><br><span> {</span><br><span>@@ -266,7 +260,7 @@</=
span><br><span>         {</span><br><span>             struct hash_iterator=
 hi;</span><br><span>             struct hash_element *he;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            inc =3D (get_random() % 3)=
 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            in=
c =3D ((uint32_t)get_random() % 3) + 1;</span><br><span>             hash_i=
terator_init_range(hash, &amp;hi, base, base + inc);</span><br><span> </spa=
n><br><span>             while ((he =3D hash_iterator_next(&amp;hi)))</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1834?usp=3Demail">change 1834</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I3db70001be7f39cf84d56251764=
7f1a305962b42 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 183=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--35y6/iEzLDk=--


--===============2683953119304297833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2683953119304297833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2683953119304297833==--

