Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC8FC982E6
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DOBRW75CoDSQfH5wFmhLh1htNAIOxbOnp/KBMqnbMIg=; b=j95sGZUz7x9so1
	pYFGYppGrObT4ADoIShw2YQyrl0qbQ3YQvx6cnlSPGe7z9NTL5x/9szjk8+uedohkkf9yAkgk9mlc
	4/0d6UtNAbDNcDifsYqWmXhPHUgA3xrZbnNfOCJnHwU7e3ohNV2QgTEu2hU6bIl48WtiY8CG5bRY9
	eOg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8gQw-0005sq-TT;
	Mon, 21 Sep 2026 15:59:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8gQv-0005sk-BZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 15:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fJV1TpbXUjoEYfTld0wj7mmj3jAn03y8F/ylcYDUH+w=; b=fjqLgdCMtEWNc4eNdpCoiGOVBK
 kbFWbdJlC1fA76ENswXRpoMOg+YR/WMws/lLUBIB36hKeWHC/48n8pavazX+Umm5vpE196w88U5uW
 FS4xdyPW9WWTjzHS1vlks+lnkfNSPRerWlD7625Xb7g2j5QdyuJSQq9BWOC7OI4pSeZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fJV1TpbXUjoEYfTld0wj7mmj3jAn03y8F/ylcYDUH+w=; b=F
 oHp2K8N8ZnWPBq1yJzlHHEtHTNbvke9lBYa2emvqYr4BJyuPlpbG/3oggC/eogGpb/KKQtIIiCw6K
 iAaLPF3fer9tSj6y7ojDXJIRAh1w7E9nvZxptN5lBHmwL+ms1sc95IaPJq/cGXKQaUgW0NbNu8foY
 klptNiZOo8QouXdA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8gQu-0006hM-MX for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 15:59:58 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so23686005e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790006390; x=1790611190; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fJV1TpbXUjoEYfTld0wj7mmj3jAn03y8F/ylcYDUH+w=;
 b=GzdlW74ZPE7ZvNbOVqjsatclauEmHU6/pYo64W5REVQsgXUsm3cBfc8nK1ZQNAgpL5
 wPGNahO6jBFmNNxcUnQ5Uts8x8NUf8zr9Q9Qrr6oH+VGTnOEePQ5N5vSlNQukx2/8OKY
 zf+O8emEfzLNlDsJuM4dIEuAp/BsTjPAeNIJ16OUHwOHeI4nAq7I5pEigIru+PBm1fCt
 xoqnQhZpckuapYals2OnLRxFJan8MrzagcnR5B1u8jsYUeK5fCqrQc/LhtRqyMJD7BX0
 M/clYkFJbtO6/Y+rqJb3T9cwYmTTOkSbx3FSu/GYEaUA7te0ARIy4kxUB6dAXhF5beGc
 kUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006390; x=1790611190;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJV1TpbXUjoEYfTld0wj7mmj3jAn03y8F/ylcYDUH+w=;
 b=uBybBNpXuGD3LCVXLFhsU6oAud10fTRZwWm326hl+PZhJrks0ekFM73U08RMyPMEBz
 9AMo715tdtv3VxYlYZCjQLS8hA9suLH10Sz0vifyisLgBZ55UZ5Cjz8UX8XoHbsnlGKE
 T52AWRlmQiluwwIoJuc2MPvlzWHW21zYJSzspGexX5SJXheW/Tv5eN0jnv0RD+ecUafy
 gA1GaTtnpyojKwDTCS6IoBZseziO5D68ZU2+Xv5RDaGVzB0IK+9ludMIfKlcj3ZXFBUJ
 0KDx4FNE1GGPkOtpaF9gk54mgG2DQlGJ5P2VpzRCxToaZmIQ8eS2DmW1Y8aniCA9h/sT
 puKw==
X-Gm-Message-State: AFuF++n0ovHO3Aen26GGykJzb0/YPTVY/8MwlUApJk1y9oYg94dt5YIT
 X5DvBhw92ifGMNRxqdTAwmjVt8nwO6X25C+/AUJBML758QI9yeTMWHosL//UoGQifmxLRCsVCPP
 nggIQtYgSoXEkn75+u+zhOibPzqc9VQwNI3o3Th9nle82219ramiM1JLS9nBtwloqbpuCJN8DgN
 Ab9JCBkA==
X-Gm-Gg: AYBFou1Bx5ZoRj2gCXciwWzD83b7xMfpkjdpiA81CpkJZJ17WtzhhaKvAovzUGq3u0K
 aiwTlBijqC3QeQp6JCZTZ5+BCToisn5d70TUXLj+fQ5lFHKjVY6w4uYclUi5uYs1qbEEW38B5xV
 x7oCkHt4ca4k06PJP/1b0kYQr2yVE45EQnrbjhCvL2DpPW9LdSeocp0AVcpffODDeDKimDIL20o
 0K9XJTKQf/1OvZgckXYRN4KgOZ8LwBM25XS3F6AQHp3xn+B9rxbteQrx2w0ID6//JpqozXyieXn
 JcNJ+2GJH7ZIMoot1it7CQ1Gx+QgfESVRWwLp7nBoP4AQMOrVrahpVwHSKCp03KIVdAtsq4nC4y
 eiGrVRVyp5ueJAOUnlAc8YT/JzT0vTpQUUnL5yNmOiGXGlsegijRru1LVMTQ/VPa7xuxjMUR/tU
 TRTQcdeLFEYP/EsYtmdyMZ+tf11w+BqJp3UBq650gzAvueoAyX2F8rZfgzgSY8kQHJewz+vvrTM
 zMFpPMLS5wRUIMsv4zCF0b065WplY7s2sjm0BXVSCUGYHV/E/htFDPefOW5hc0cmC/O5j0JMn97
 U/8VeTRrjNK/ourxiY95DLxTVCCe3qPRRCzbrZGx+RiDSEviZ9CwQcd+hjv+
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49fc56811dcmr162177005e9.4.1790006389981; 
 Mon, 21 Sep 2026 08:59:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8b9fc5asm378695e9.5.2026.09.21.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:59:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 15:59:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
X-Gerrit-Change-Number: 1921
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1921?usp=email>
X-Gerrit-Commit: 91f143fc1c880bac765972d9d04924e124d9e84a
References: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkljYWE3NmEyMGVmNDFlMjYwNDRmYTY4NGQ1Mjk3ZjQwZDhkNWRkYzhkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a37cde07e3fb3a15e45f45cc226f414dfd729a8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8gQu-0006hM-MX
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3958239397430631972=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3958239397430631972==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UnTcsWYYyG8="; charset=UTF-8

--UnTcsWYYyG8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1921?usp=3Demail

to review the following change=2E


Chang=
e subject: GHA: Explicitly set PKG_CONFIG_PATH in Android build
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Explicitly set PK=
G_CONFIG_PATH in Android build

Otherwise CMake could use the wrong pkg-con=
fig file=2E
It was still using the correct libraries due to
architecture co=
nfig=2E However, in Ubuntu 26=2E04 lz4 has
an additional xxhash dependency =
and this dependency
was wrongly used=2E

Change-Id: Icaa76a20ef41e26044fa68=
4d5297f40d8d5ddc8d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
---
M =2Egithub/workflows/build=2Eyaml
1 file changed, 2 insertions(+), =
0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/21/1921/1

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egit=
hub/workflows/build=2Eyaml
index 56dd3ed=2E=2Ed67c215 100644
--- a/=2Egithu=
b/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -62,6 +6=
2,8 @@
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpk=
g install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
+ =
       env:
+          PKG_CONFIG_PATH: "${{ env=2EVCPKG_INSTALLED_DIR }}/$=
{{ matrix=2Evcpkg_triplet }}/lib/pkgconfig"
         run: |
           cmak=
e -S =2E -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes \
             -DCMAKE=
_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d=

Gerrit-Change-Number: 1921
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--UnTcsWYYyG8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">GHA: Explicitly set PKG_CONFIG_PATH in Android build<br><br>Otherwise =
CMake could use the wrong pkg-config file=2E<br>It was still using the corr=
ect libraries due to<br>architecture config=2E However, in Ubuntu 26=2E04 l=
z4 has<br>an additional xxhash dependency and this dependency<br>was wrongl=
y used=2E<br><br>Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =
=2Egithub/workflows/build=2Eyaml<br>1 file changed, 2 insertions(+), 0 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/21/1921/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egithub/workflow=
s/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span>index 56d=
d3ed=2E=2Ed67c215 100644</span><br><span>--- a/=2Egithub/workflows/build=2E=
yaml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span=
>@@ -62,6 +62,8 @@</span><br><span>       - name: Install dependencies</spa=
n><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</s=
pan><br><span>       - name: configure OpenVPN with cmake</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        env:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+          PKG_CONFIG_PATH: &quot;${{ env=2EV=
CPKG_INSTALLED_DIR }}/${{ matrix=2Evcpkg_triplet }}/lib/pkgconfig&quot;</sp=
an><br><span>         run: |</span><br><span>           cmake -S =2E -B ope=
nvpn-build -DUNSUPPORTED_BUILDS=3Dyes \</span><br><span>             -DCMAK=
E_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1921?usp=3Demail">change 1921</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1921?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5d=
dc8d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1921 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--UnTcsWYYyG8=--


--===============3958239397430631972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3958239397430631972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3958239397430631972==--

