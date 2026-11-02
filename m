Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7060722AE
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TUiLWcvV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Khcrp5Eo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LHx2B4RI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c78kDvfk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=lrEYfPxh2LfHtw6lctnLwy43pmGQebtAzBi4UNh9/gE=; b=TUiLWcvVaA6oens+FesCo4vAW+
	9r9yso8EF2TZca1rlr3eZfmQ/nWls1w1Yi90weW1GFJ0sBleNWClNBz92WcyGPJTj9AD89nJ+cNGM
	iOEyE/ftOxSc8VsLOf1gcrd8khey+QNzjgX9+TloO3JG1oaa699E5/dgieYAcxZnqiAI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNutL-000000001DD-2BvC;
	Mon, 02 Nov 2026 16:28:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNutK-000000001D7-2cCt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:28:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4BEfgB+L+kitgHzI3dPDQa4SNgMfBaEqOBbLfU2pu7w=; b=Khcrp5EoW84dvniNNFGq0+YSka
 EPwk3DWsynwcvp4codxu2q/d6Qwhsje47+vMbGI/vDkyktrC38q0E+ujLFtFnPGvLtnZrz0cPWgD7
 pzrpLEEGHNo0FzYsuHnXXwrzY8zexAOV3yDo9qui3A6l+MicCBHU3Q9jORxu762k+B98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4BEfgB+L+kitgHzI3dPDQa4SNgMfBaEqOBbLfU2pu7w=; b=LHx2B4RIbHKCU+HW3u8vfIumle
 DYGfh66ApxIrYBVfqej2Ka1sD2Y0ZJ+MbKtbuMEAhbNyEiMrzfbQcCfU8EIpW+k+6zVsSbOiTZdog
 hywp+OTJES7mRiMm3EmK4BnV+t8Q5QgOFKY5KvJ78B6O0N+biyXP+18S9p1CUY5eBRtk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNutJ-000000005DA-0laY for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:28:14 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so33866965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 08:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793636887; x=1794241687; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4BEfgB+L+kitgHzI3dPDQa4SNgMfBaEqOBbLfU2pu7w=;
 b=c78kDvfkMa7Q30FwHuO7Ge3yNfXLC8JOcArwgqjZfIb1yRkA5Omhok+9ucw6USkuLP
 JnJERa3zpuZoP8dP5jIdZf+f5ineGzf7N5w4qIz4R6nZk+f+XBWhBtpPyzO0CvgsfRXz
 k9BOQ09YDkGIRtzbme2SAaLmM0onJyB0f/J28iQlQo1iHcvV6mPAdyUepnAR512tJRYs
 lVw3f36GyFSDxwjVgRMrASJuIA+dLymKk/hr8bNn1Rb0+Evl3Dn+ddJELoJspiFHkyt1
 RwCiQj/Erb20BglaG9N9pMRKOhzwbgYSQvV252aPxsSsWzK/1CaSMcbFBEQhum8suPjQ
 lbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636887; x=1794241687;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4BEfgB+L+kitgHzI3dPDQa4SNgMfBaEqOBbLfU2pu7w=;
 b=0Jhoz1W0SxSrjN0SKrsjNDnLSbHdIHNS3HEaAik4TEgOOXsEuz/BzEDFYfHRpmog3e
 DBE8090eXNhIhGHcglsu3SOfekyw5Jgl7QpldcSBtvyuDa6N3I+3eJxWcqAPV4YSf83d
 qwW82A7qYV11c3fwCUESLM7oefwql5tHwjEKKtWyPVY9bSkRvpFapYdnN23axNfq9VEC
 vrooAOER8ex8cUV4YY807onTjB9xuZBbGHItwGSBeSrUfyolMgLT3JbtMrkkc5kO6uLz
 Wi5xh2JlGqCj0CK+s32/dREH6NaE1PTkJJh9Rpe+wvElyI321hIH2iSi0mxZG5R0KF0s
 Djxg==
X-Gm-Message-State: AFq9FYLiHZD679+brKc83jdaxtqF1hOZtEEkYxTZqsLzL2O7zxt707Oq
 9LLP1nfUc0BOXdCWJegJLpB7JTyZywhsBg6OyZ0xwPmrQy9cMuz03kVgJ/YdUhsQnSiib9YCZbQ
 lg4RFkLPRX5UVrGRrn5BWUX1plfGpctIPH3HMrLUaSk+iu3z+fzMGlKjq+B/a0h7exjNcMGw5bC
 ko3KjN+g==
X-Gm-Gg: AYBFou37uaUzBQeQzp3Oy8W/9NbBHYEIu4RCWjtDmyqJR2nfpEJ90cFaxk+tRwRdYFy
 p4YXf7S3c4ZNqA4lZ+UDXkqoVHxVsi+60mphy3S/MtBMlZ2V50QCXFNJ6rH6GfxS5yWwBoILyAm
 e+R6xQ60YsQVLrvRY991B4I2xjs8HcJhe///FEtOLzgft7NgWIBba4R5RnzSRVJZ7npX2JEg/o7
 blYASiTzbZpkG0q52C7RGOXgo88s2JYceQaUz7YbCXALr+EpEZ1EFoDJD+SF4rBqyioICw5Xsxz
 P/JgIBJfwBbqova07ZJabyzacyvfhcbV8X7iPmGzt49Y2toPZ4rnVTiqcS8Z9PrA3H6wbGcYjt4
 0t18k0mZm4CBbYPXgoRzEUQ07euD4dFKGb2okfFcE5aaf/RBe8Ej29DAStV4qoGqcvW6j3eQVyo
 JhOPUgfGKcrJkxCDa3b6MvFycYtUIMq/hcA0nqdWj1C686nYoltwh2eDNmocEj72EcDeBxKSDkY
 mgylzobGWSddGWBJEDX0SZFWJkjjepYOkpGBdYkJ99qoRJT8yWieXWgey8DpuFpV+dRcNaVROwk
 ZAEKB7qpTtU/pP7EPkE3/N+bIz5oRXq11NMEjfHTXEPr1/znr/F83yo4BzQX9MewYSEZtCEseax
 yj9fgxhD2Dx7XO86pfQQ2aWsruGLvHIyDmeHEwxXPB6hjsBimZhpzp1VJ059Hd2IZoRlLVykEk1
 Mpu0jHTeEpb1vUuQ==
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4ac17b2c8a7mr241891885e9.25.1793636886495; 
 Mon, 02 Nov 2026 08:28:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b289f7sm283563105e9.5.2026.11.02.08.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:28:06 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 16:28:05 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
X-Gerrit-Change-Number: 2093
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2093?usp=email>
X-Gerrit-Commit: cc31b4c3b5a9ec1deb40214270a0b181f58be0d8
References: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjM2ODg0MDAwLklhMDMwNGU1ZWY1ZjhhNTUzMjYyYTMyZDc4ZWQyMTU3Nzk3M2VlMmU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8ba63b8542fd7254659381b6d007817785e07e1d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNutJ-000000005DA-0laY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: close socket
 in Haiku get_default_gateway()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2150571850516354087=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2150571850516354087==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i9jswsb6NyI="; charset=UTF-8

--i9jswsb6NyI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2093?usp=3Demail

to review the following change=2E
=


Change subject: route: close socket in Haiku get_default_gateway()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: close socket=
 in Haiku get_default_gateway()

The socket used for the routing table ioct=
ls was never closed=2E Close
it on the early returns and right after the la=
st ioctl=2E

Broken since 7da14925 ("Haiku: Add calls to manage routing tab=
le")=2E

Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
Signed-off-by=
: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/route=2Ec
1 fil=
e changed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/93/2093/1

diff --git a/src/openvpn/ro=
ute=2Ec b/src/openvpn/route=2Ec
index 0bce966=2E=2Ee8de2d5 100644
--- a/src=
/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -3719,12 +3719,14 @@
    =
 if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0)
     {=

         msg(M_ERRNO, "%s: Error getting routing table size", __func__);
+=
        close(sockfd);
         return;
     }
 
     uint32 size =3D (uint=
32)config=2Eifc_value;
     if (size =3D=3D 0)
     {
+        close(sockfd=
);
         return;
     }
 
@@ -3733,7 +3735,9 @@
 
     config=2Eifc_len =
=3D size;
     config=2Eifc_buf =3D buffer;
-    if (ioctl(sockfd, SIOCGRTT=
ABLE, &config, sizeof(struct ifconf)) < 0)
+    int ret =3D ioctl(sockfd, S=
IOCGRTTABLE, &config, sizeof(struct ifconf));
+    close(sockfd);
+    if (=
ret < 0)
     {
         free(buffer);
         return;

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973=
ee2e9
Gerrit-Change-Number: 2093
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--i9jswsb6NyI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: close socket in Haiku get_default_gateway()<br><=
br>The socket used for the routing table ioctls was never closed=2E Close<b=
r>it on the early returns and right after the last ioctl=2E<br><br>Broken s=
ince 7da14925 (&quot;Haiku: Add calls to manage routing table&quot;)=2E<br>=
<br>Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=
=2Ec<br>1 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/=
2093/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</=
span><br><span>index 0bce966=2E=2Ee8de2d5 100644</span><br><span>--- a/src/=
openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><sp=
an>@@ -3719,12 +3719,14 @@</span><br><span>     if (ioctl(sockfd, SIOCGRTSI=
ZE, &amp;config, sizeof(struct ifconf)) &lt; 0)</span><br><span>     {</spa=
n><br><span>         msg(M_ERRNO, &quot;%s: Error getting routing table siz=
e&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        close(sockfd);</span><br><span>         return;</span><br><span>   =
  }</span><br><span> </span><br><span>     uint32 size =3D (uint32)config=
=2Eifc_value;</span><br><span>     if (size =3D=3D 0)</span><br><span>     =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(sock=
fd);</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span>@@ -3733,7 +3735,9 @@</span><br><span> </span><br><span=
>     config=2Eifc_len =3D size;</span><br><span>     config=2Eifc_buf =3D =
buffer;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ioctl(=
sockfd, SIOCGRTTABLE, &amp;config, sizeof(struct ifconf)) &lt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ioctl(sockfd,=
 SIOCGRTTABLE, &amp;config, sizeof(struct ifconf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    close(sockfd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span>     =
{</span><br><span>         free(buffer);</span><br><span>         return;</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2093?usp=3Demail">change 2093</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2093?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ia0304e5ef5f8a553262a32d78ed21577=
973ee2e9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2093 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--i9jswsb6NyI=--


--===============2150571850516354087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2150571850516354087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2150571850516354087==--

