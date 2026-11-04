Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06C606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BWiVLPcN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TqVJ5b0/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UqGKa3Cp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cqio7YMZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z/QUAO3C6mj1yuCgeFgljylS3PRvAQlNc+Vi0umdHJA=; b=BWiVLPcNIDV2nVJqKLsLsnEG2+
	nEx9fBMZ3qJmVIrvGSZsfrfAdwO1qBiCS4MfoiKpRN4jiJI1wvdevx1cxk+lNNhMy1jFeyxM9395V
	Pup5Jc0zT2iP/lEP7lFcSuZvCJt66tbQ7b5J9BGXfdVrvvFpB+zjC7IbxNH0h9bkQQVc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeVF-000000007kZ-3BSZ;
	Wed, 04 Nov 2026 17:10:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeVD-000000007kT-3SsO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:10:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nh+P11u/sDdcQ/y8BTie0PWd+GE/8MNJrZhrjz8uT5Q=; b=TqVJ5b0/eE3D0izNGsphLFIwGo
 ojOnef1OgDu7i6+jszd3OjPMJQP4Mo9iPJDroTFdGKEjOlAJVmwd40iZhfio6ogf1L7kowGMauRJO
 BlumrwD1JhJZDTkCBPz8FwjTHTD0ZtVQhQoFKPcemIynTl6aNiyDpR9lAca6Ytz2L5mY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nh+P11u/sDdcQ/y8BTie0PWd+GE/8MNJrZhrjz8uT5Q=; b=UqGKa3CpcxfenlLgkB4hsRN5S9
 b3n8ewoSeT1nDQ9VK3skiA9O3vCmUsRwTtGwYI79FG34r7db+V5ndGS7HZxZENClJuaKZhoS6i4rb
 0Gg99pPPdFQBZEaZMrGAsRjZj9XrCLyCl4E7aIcT0gxhHLxDuERPvW7us7wOSUGUsfKc=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeVB-000000001xd-2MGl for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:10:23 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so744782f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793812215; x=1794417015; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nh+P11u/sDdcQ/y8BTie0PWd+GE/8MNJrZhrjz8uT5Q=;
 b=cqio7YMZpCXv6iZnYYaLDlGw6Zpok3p689NeVqNfg1XXrlsBpj6C5o2n41NoHMLC3c
 Cqk1emhofEP0nX7LnKyf/nIIM2C30PJ6soQmcGKtkNRZmxHnI7XTVJmBMrFooo8ER6wN
 EhpWeldXmaDSWftzA7SC2TuPopFTdb5Xsp3IwqOXKZZVNILK425DlY207a9lTaHtPTSc
 jElwZ6y3THRzIZ3EsK6V9VEcWW1F+GhDRnGrrPbqI0Xf2lbS3i9ndtMCF0CcFKQFwAT2
 bvtxMN0DC47jxNbz+s9oEHwlVOeCeRBFmQmauKLxJe1gkrZSgsZLlM4t0Up8/Vnep05L
 gt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793812215; x=1794417015;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nh+P11u/sDdcQ/y8BTie0PWd+GE/8MNJrZhrjz8uT5Q=;
 b=icHDGGpBAxjsddeS6FtP7zdOw6az+Lsa8FQUTPk1uXeM6cR6XsSRHZgIPXN4FnBtXB
 t6ieN4a6f9BHPOhriIVMA9RTGASGwfZCI7XelpEfOyYCb5F2HUG+vzNHQvBQ6N+VAOfB
 rXNRTOh8K/CRXRlmdKhQrsWyB+6GEu2PYnr2jWa3AIUqu2dF8or+UOJGKva6e4KI8wA+
 co/8znLoDUjsfmB5+lC0bnqkJDGg2uSo5EJpyJ95//xDcmejqzv9/RSz+MA3Jq35qvLQ
 LytC1AOiHziRi5V0vzupN1bw/9I9UXcNKXPqcN7kdJy9zpmPVmfAmXGejo0nvIW5fwNO
 BG5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNsiMViB05VO6cReSt8SworsrhLSQ5mFjJa3zHAAmyYM5esuc7S/LBN9l18pvTkcmfEi/buJYz53IpNpus@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9mZdlRug7XZ2CyDdM0IWmXKjmxsOAXhF/C+GePyYQDQo5zUP9N
 2xEgkEs+F5VmiXE7kHZsBmfAVnFSa5tk8qcV4gtIDZpO9LG635VR/HtLcBITMzmWhZriIanhZer
 9LihWYjVm5wf+axrqNhRN3IoQf+Q8VcwMJ2sR35MIkmdu71zANXgp+PLaydn5GZq8695AQw+FgD
 REJ8Ty4g==
X-Gm-Gg: AYBFou2Jedd8MsgJlRbDOz2lCxpkuqCroReOTh2z0tfr/YnD8BSjwsf0GLO/1/kBVkO
 ZjtyxI2gQCxjjuqtZ7D6aaObAhnCtXSwhenI4yRWNjfYEZaPaExpTW2PMLG64q6qvWM73x6o0w6
 EppOjfmWe+oz9l7Cym3dB2kGIVmC7KZDvZX/X78mwd73oVrbCVXeGh3S27v+ZYOjUXotngk43FY
 3TwQYM8XV/q2D4JRfGW+5zeHPP2fSQ4Ort/9JYsvmUkYtqx6obVXCid1Ztb3Ywf3TkuXR8xkWPd
 caeH57aya0qDj7nHqX/4IZHcc4KE9pX3lN5Y83XP9cuRVzV/TuEbKLNXmLH4l4it47n0PtfjIyI
 M7mZieiyoY4yRhyeKHEuwRDLnwndyFumUgAXK696OzHkId/fwyt9+HrZZN7ZKB2m93YYnSc08M0
 akuKv8l+ERnbNy1O3MU6/GMnNESbPNOCOJ1Tkwb4mgrN7pGTV+KuwrxV4/5D0HzGnZNhJNt6ebJ
 B9yc6slFgLJA2/BLaY7Z+6ziljlGtDtPnI86F2cQ2Hj6TGfyWpJgf/1NwbaofiG1mlyFk3upmJb
 npbeU+MdUakJfB++jAy1GaEGogxU2Z8y2ipxv7LI4c/Trz62tMnv1Z2vplZXYadMCyi3Sjn8PNc
 PCwlXH8UDQrAETowAIUdRV3i5i/GVnLSkq+rskHviorQDUC09p7bgUvEmhiaKnvtj65yFFgFeht
 c6f4pekQEwRK9NBqM=
X-Received: by 2002:a5d:5f89:0:b0:48b:a4b:5a2c with SMTP id
 ffacd0b85a97d-48e6e2ba305mr36210381f8f.3.1793812214754; 
 Wed, 04 Nov 2026 09:10:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180eaesm5821772f8f.2.2026.11.04.09.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:10:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 17:10:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
X-Gerrit-Change-Number: 2111
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2111?usp=email>
X-Gerrit-Commit: 9e4394a6511d1e50f1c11efde223635bbc296aa3
In-Reply-To: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
References: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzODM0MDAwLklmYzcwN2VmNjlkNjE0YzM0MDhiNmY4OGM3ODBlMzM3ZTk1YmFhZmFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <072272786fbe39a7d707b36323a0733cd691b41b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeVB-000000001xd-2MGl
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Heiko Hund <heiko@openvpn.net>, Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2695491783158183684=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2695491783158183684==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MQRbtLm1n9k="; charset=UTF-8

--MQRbtLm1n9k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2111?usp=3Demail )

Change subject: openvpnserv: free security =
descriptors in RunOpenvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: free security descriptors in RunOpenvpn()

Th=
e DACL from SetEntriesInAcl() and the pipe security descriptor from
Convert=
StringSecurityDescriptorToSecurityDescriptorW() were never
freed, leaking b=
oth on every client connection=2E Initialize them to
NULL at the top and Lo=
calFree() them at out=2E

DACL leaked since a24dd2e3 ("interactive service =
v3"), pipe security
descriptor since 0a429cb1 ("Restrict access to the serv=
ice pipe to
SYSTEM and owner")=2E

Change-Id: Ifc707ef69d614c3408b6f88c780e=
337e95baafac
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-b=
y: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2111
Message-Id: <20261104074751=2E21336-1-gert@greenie=2Em=
uc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261104074751=2E21=
336-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Em=
uc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 4 insertions=
(+), 2 deletions(-)




diff --git a/src/openvpnserv/interactive=2Ec b/src/=
openvpnserv/interactive=2Ec
index 4a8d0b5=2E=2Ea04a449 100644
--- a/src/ope=
nvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3444,7 +=
3444,8 @@
                                         =2ElpSecurityDescriptor =
=3D NULL,
                                         =2EbInheritHandle =3D TR=
UE };
 
-    PACL ovpn_dacl;
+    PACL ovpn_dacl =3D NULL;
+    PSECURITY_D=
ESCRIPTOR pSD =3D NULL;
     EXPLICIT_ACCESS ea[2];
     SECURITY_DESCRIPTO=
R ovpn_sd;
     SECURITY_ATTRIBUTES ovpn_sa =3D { =2EnLength =3D sizeof(ovp=
n_sa),
@@ -3624,7 +3625,6 @@
      */
 
     SECURITY_ATTRIBUTES sa;
-    P=
SECURITY_DESCRIPTOR pSD =3D NULL;
     LPCWSTR szSDDL =3D L"D:(A;;GA;;;SY)(=
A;;GA;;;OW)";
     if (!ConvertStringSecurityDescriptorToSecurityDescriptor=
W(
             szSDDL, SDDL_REVISION_1, &pSD, NULL))
@@ -3764,6 +3764,8 @@=

     free(ovpn_user);
     free(svc_user);
     free(cmdline);
+    LocalF=
ree(pSD);
+    LocalFree(ovpn_dacl);
     DestroyEnvironmentBlock(user_env)=
;
     FreeStartupData(&sud);
     CloseHandleEx(&proc_info=2EhProcess);

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc707ef69d614c3408b=
6f88c780e337e95baafac
Gerrit-Change-Number: 2111
Gerrit-PatchSet: 2
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@open=
vpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--MQRbtLm1n9k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2111?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: free security descrip=
tors in RunOpenvpn()<br><br>The DACL from SetEntriesInAcl() and the pipe se=
curity descriptor from<br>ConvertStringSecurityDescriptorToSecurityDescript=
orW() were never<br>freed, leaking both on every client connection=2E Initi=
alize them to<br>NULL at the top and LocalFree() them at out=2E<br><br>DACL=
 leaked since a24dd2e3 (&quot;interactive service v3&quot;), pipe security<=
br>descriptor since 0a429cb1 (&quot;Restrict access to the service pipe to<=
br>SYSTEM and owner&quot;)=2E<br><br>Change-Id: Ifc707ef69d614c3408b6f88c78=
0e337e95baafac<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111<br>Message-Id: &lt;202611040747=
51=2E21336-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eor=
g/openvpn-devel/20261104074751=2E21336-1-gert@greenie=2Emuc=2Ede<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
nserv/interactive=2Ec<br>1 file changed, 4 insertions(+), 2 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnse=
rv/interactive=2Ec</span><br><span>index 4a8d0b5=2E=2Ea04a449 100644</span>=
<br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/o=
penvpnserv/interactive=2Ec</span><br><span>@@ -3444,7 +3444,8 @@</span><br>=
<span>                                         =2ElpSecurityDescriptor =3D =
NULL,</span><br><span>                                         =2EbInheritH=
andle =3D TRUE };</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    PACL ovpn_dacl;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    PACL ovpn_dacl =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><sp=
an>     EXPLICIT_ACCESS ea[2];</span><br><span>     SECURITY_DESCRIPTOR ovp=
n_sd;</span><br><span>     SECURITY_ATTRIBUTES ovpn_sa =3D { =2EnLength =3D=
 sizeof(ovpn_sa),</span><br><span>@@ -3624,7 +3625,6 @@</span><br><span>   =
   */</span><br><span> </span><br><span>     SECURITY_ATTRIBUTES sa;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    PSECURITY_DESCRIPTOR pSD=
 =3D NULL;</span><br><span>     LPCWSTR szSDDL =3D L&quot;D:(A;;GA;;;SY)(A;=
;GA;;;OW)&quot;;</span><br><span>     if (!ConvertStringSecurityDescriptorT=
oSecurityDescriptorW(</span><br><span>             szSDDL, SDDL_REVISION_1,=
 &amp;pSD, NULL))</span><br><span>@@ -3764,6 +3764,8 @@</span><br><span>   =
  free(ovpn_user);</span><br><span>     free(svc_user);</span><br><span>   =
  free(cmdline);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 LocalFree(pSD);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 LocalFree(ovpn_dacl);</span><br><span>     DestroyEnvironmentBlock(user_en=
v);</span><br><span>     FreeStartupData(&amp;sud);</span><br><span>     Cl=
oseHandleEx(&amp;proc_info=2EhProcess);</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Demail">chan=
ge 2111</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2111 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--MQRbtLm1n9k=--


--===============2695491783158183684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2695491783158183684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2695491783158183684==--

