Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27D606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NPLjacMA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VUq89fr+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TZZ/AnnC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XncOwm+2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=SdqQdRSUILeF4ot8I/GBwEo4pSrmwCZZqDnazmmyWPY=; b=NPLjacMAkswVOuu1ojZhN8BPQ5
	f7MLqQTZbeOEGACvKM2D9Ovr2fvsYZIKUX8/lsV7u+GS1J3in0abAsb5KV2E87/YEdkrSLnx2sLpH
	H8mYlIP134HMLJcPuYIr5kcJ0QCldLNtRU7yNAhPRl2AJV0R6aBXldfduN9Ozrdy5OIg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOK74-000000004QI-3Znf;
	Tue, 03 Nov 2026 19:24:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOK73-000000004QB-19mE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:24:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PYpY1Kv8SDEfqx9YeJW2cVx6OLBSaTUCR+oFLbbSvNw=; b=VUq89fr+duyyj6yZswoZaZMe8q
 qe8gSpJNH1FMkDN7iNDD4lUgjof6cL/6ot3VWj35kaZCcdDaLriImxzA5gtpZoowSNzPngb1usv7i
 QCtuGJP10koEtKXzQGe6nHFEYBmly+XtFQw1gwKmLrNI3RWILooq88Xif8JapQSfzfmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PYpY1Kv8SDEfqx9YeJW2cVx6OLBSaTUCR+oFLbbSvNw=; b=TZZ/AnnCwuqOnlHIsChVhV7kQH
 L7drHolOUKWAz7l3vwBFdDgjJptpciKB/CdqBwKFJNzp8vT0A1zZj9Qj2rf3j29LFNv+G3SlYyxC9
 l8RiCa5/wDE8vhtYaWONcezErpm+bFFttaDw8r8AEM0hrT/8YC5nwjbeU7J3wBrvcz7U=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOK71-000000004LK-3V60 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:24:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so45355305e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793733837; x=1794338637; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PYpY1Kv8SDEfqx9YeJW2cVx6OLBSaTUCR+oFLbbSvNw=;
 b=XncOwm+2sLiX9LeuNnpYfu7aSkKSG0mU+Ln7HVc0Ulz+URdJb5EtNK2LSNtLX7joMo
 ni7MKl/sTjmRkDRXQ3Ef+nIcdjNEpEVIfDZcEdAhjV6TVLs9opMVrIHDnfe7qQlEPxAN
 CSmQk6Jzl32M3lO4zYn5xBpocxHtQFg724n4w6xjH34hf4LhA71lsgpDio8S6yWURSjt
 cgRYN7E30Js59Zo+1EWR+bXLs9BhwrwYMov3btaY203IkRe14giAHiIpv0tzblmeX170
 h7PbQipD9YlDLxwCu1e0RRL6m8eQGiOV0yEPr35s+dFzIHlUYHEp5Wkg6e5B9tTG1ZX6
 6mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793733837; x=1794338637;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PYpY1Kv8SDEfqx9YeJW2cVx6OLBSaTUCR+oFLbbSvNw=;
 b=NTkV2tIvP3f9ESMjiTk6X7znzfYNCZB8ZK0yfbkn8/3wnardlV1d96DM9dqwf85Gt6
 blrsu802JEWdwYqzKttpv1IRxSK/+xGHEzAo1Tdoz4SfH5JYvAbfhxgK+hFC7pgQJVA4
 Yq/UPBwz5mUkSp4vc52iQryA03y4ikv4BRHltvB5uZmc7yztHS6f2Cvoj9PGfxIUAY6V
 XdcskMvEjbqDnDaECb7KTOZwZbC1NeHfyRbh6dqPV1sqwzc+v04nG7kX99+TZpcflNUY
 8nv7N1SyExysIjU/5Oco3HPkUuQoL69QOLoG6svlj4N3NzEmSpqFuekrLzbrMDxEZG0T
 JZCg==
X-Gm-Message-State: APuU4Z/LevRxf8Jk07jhTHqEkImkfASLxW4U4jDX+NCOqutT72uXoCBG
 /+8TTpm4L3TrMUzKJh787ngBsAkm6MoHnSiop39UytBq8/9c7c3HUvnjKhQQiPM41mXoTzScp67
 rK21ejj+wtp49lHfKY7SuzNGxKaUSp/DbKbOtEj+m4pD7Dm4KvzU3w1fLQFZ590+bHy1/EbBE5h
 nC4Kw5gg==
X-Gm-Gg: AYBFou2bD5Mo/vSe5vqCD91qOyeukVL96lfLPJbqjEvhF1SDbEoS3VIAhqZvmN4J7Li
 s3Azkf31oYaZkT8BetsXJ7ZgMF00Qe7m9ZwkCNzgPzfNmXdZq4MSqdQujvdLLWSSaadB0asnzi6
 KYDRlO0E+9dMJqpYkMV9EaPSmd+9BpsEIz0QqwcJ0Imouz/KoZXzQwL/uhtPPZ8G6RlnhevkBZw
 iwW/YY3mn9WK/hKd60Nw6NXIa+Ig8h6RI6Xhe4LVPedcmNy0CK6hhZOS+310ANT4V4/eWSE//dE
 n2DacvoqW02V8pb7xqqcTAJC50k3Cpela8O3rWlWoH3q08ZML/NVS0872HxsaY5KCBO5aW7JHJP
 7RuidSnZnY2WgLRImcJFYvKMBUWWIHZ5CTZE4vgx0g9S7FDI7peWLuwVAnfB/aV/gCnF2sNedur
 36sH8SMFyhL8HIiZ4Tffo3HTTOAhutMggl0SL+R2A0HkuVs5/tOyGnGKz6VPwFnlu7lL7P6R8X2
 t34doIEWGRjTmbl1KG1xVGdh1CWxnl3+SY3E5jn00YtLctKq2WAYMDpa44kx7LRuj+dAcgREbxm
 18G54mogTdIW3jB65kzyApL3ivlUe7qinaGgpnGh5zbsqRCldYaOqIXESL8WSgabOR462zouNcq
 NAf1Qd9Tv43vze7Z7o8UxFLPmwmST+zgqTO8mAqg1jAMVaZwOJUrsOUx3oTrchxuNcCd1ypfC3m
 MaQaERbHoGbAp0GA==
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4ac17ffb2ffmr328487125e9.9.1793733836621; 
 Tue, 03 Nov 2026 11:23:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm91466915e9.5.2026.11.03.11.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:23:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:23:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
X-Gerrit-Change-Number: 2111
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2111?usp=email>
X-Gerrit-Commit: d2b8fc1d0fa0ddf8d96e14529f50113a950920f8
References: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzODM0MDAwLklmYzcwN2VmNjlkNjE0YzM0MDhiNmY4OGM3ODBlMzM3ZTk1YmFhZmFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <594f0dd0344ef183495390fb01f3b11640237ed7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOK71-000000004LK-3V60
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: free
 security descriptors in RunOpenvpn()
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
Content-Type: multipart/mixed; boundary="===============3766568262908308642=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3766568262908308642==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2PAegJQXlrE="; charset=UTF-8

--2PAegJQXlrE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2111?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: free security descriptors in RunOpenvpn()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
free security descriptors in RunOpenvpn()

The DACL from SetEntriesInAcl() =
and the pipe security descriptor from
ConvertStringSecurityDescriptorToSecu=
rityDescriptorW() were never
freed, leaking both on every client connection=
=2E Initialize them to
NULL at the top and LocalFree() them at out=2E

DACL=
 leaked since a24dd2e3 ("interactive service v3"), pipe security
descriptor=
 since 0a429cb1 ("Restrict access to the service pipe to
SYSTEM and owner")=
=2E

Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec=

1 file changed, 4 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/2111/1

diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 484f27c=2E=
=2E4ddc354 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -3444,7 +3444,8 @@
                                  =
       =2ElpSecurityDescriptor =3D NULL,
                                  =
       =2EbInheritHandle =3D TRUE };
 
-    PACL ovpn_dacl;
+    PACL ovpn_=
dacl =3D NULL;
+    PSECURITY_DESCRIPTOR pSD =3D NULL;
     EXPLICIT_ACCESS=
 ea[2];
     SECURITY_DESCRIPTOR ovpn_sd;
     SECURITY_ATTRIBUTES ovpn_sa =
=3D { =2EnLength =3D sizeof(ovpn_sa),
@@ -3624,7 +3625,6 @@
      */
 
    =
 SECURITY_ATTRIBUTES sa;
-    PSECURITY_DESCRIPTOR pSD =3D NULL;
     LPCWS=
TR szSDDL =3D L"D:(A;;GA;;;SY)(A;;GA;;;OW)";
     if (!ConvertStringSecurit=
yDescriptorToSecurityDescriptorW(
             szSDDL, SDDL_REVISION_1, &pS=
D, NULL))
@@ -3764,6 +3764,8 @@
     free(ovpn_user);
     free(svc_user);
=
     free(cmdline);
+    LocalFree(pSD);
+    LocalFree(ovpn_dacl);
     De=
stroyEnvironmentBlock(user_env);
     FreeStartupData(&sud);
     CloseHand=
leEx(&proc_info=2EhProcess);

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2111?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
Gerrit-Change-Numbe=
r: 2111
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--2PAegJQXlrE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: free security descriptors in RunOpenvpn()<=
br><br>The DACL from SetEntriesInAcl() and the pipe security descriptor fro=
m<br>ConvertStringSecurityDescriptorToSecurityDescriptorW() were never<br>f=
reed, leaking both on every client connection=2E Initialize them to<br>NULL=
 at the top and LocalFree() them at out=2E<br><br>DACL leaked since a24dd2e=
3 (&quot;interactive service v3&quot;), pipe security<br>descriptor since 0=
a429cb1 (&quot;Restrict access to the service pipe to<br>SYSTEM and owner&q=
uot;)=2E<br><br>Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac<br>Sig=
ned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/o=
penvpnserv/interactive=2Ec<br>1 file changed, 4 insertions(+), 2 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/11/2111/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interact=
ive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 484f27c=2E=
=2E4ddc354 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3444=
,7 +3444,8 @@</span><br><span>                                         =2El=
pSecurityDescriptor =3D NULL,</span><br><span>                             =
            =2EbInheritHandle =3D TRUE };</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    PACL ovpn_dacl;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    PACL ovpn_dacl =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    PSECURITY_DESCRIPTOR pSD=
 =3D NULL;</span><br><span>     EXPLICIT_ACCESS ea[2];</span><br><span>    =
 SECURITY_DESCRIPTOR ovpn_sd;</span><br><span>     SECURITY_ATTRIBUTES ovpn=
_sa =3D { =2EnLength =3D sizeof(ovpn_sa),</span><br><span>@@ -3624,7 +3625,=
6 @@</span><br><span>      */</span><br><span> </span><br><span>     SECURI=
TY_ATTRIBUTES sa;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><span>     LPCWSTR szSDDL =3D =
L&quot;D:(A;;GA;;;SY)(A;;GA;;;OW)&quot;;</span><br><span>     if (!ConvertS=
tringSecurityDescriptorToSecurityDescriptorW(</span><br><span>             =
szSDDL, SDDL_REVISION_1, &amp;pSD, NULL))</span><br><span>@@ -3764,6 +3764,=
8 @@</span><br><span>     free(ovpn_user);</span><br><span>     free(svc_us=
er);</span><br><span>     free(cmdline);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    LocalFree(pSD);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    LocalFree(ovpn_dacl);</span><br><span>     Destroy=
EnvironmentBlock(user_env);</span><br><span>     FreeStartupData(&amp;sud);=
</span><br><span>     CloseHandleEx(&amp;proc_info=2EhProcess);</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2111?usp=3Demail">change 2111</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2111?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2111 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>

</body></html>
--2PAegJQXlrE=--


--===============3766568262908308642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3766568262908308642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3766568262908308642==--

