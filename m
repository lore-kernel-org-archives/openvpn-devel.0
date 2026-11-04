Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A9606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D4UWbQ+7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L9k/pYCn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UJvtR9cv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TnrKpNQZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5FNj+EqqW7smlgbjM7a2tkzyhzdxwgiEqJqQDOIivE0=; b=D4UWbQ+7yEr11RuEmdZfhO5a26
	hQOYDYyRktGYrMzO4oDBy7FiEROBEdZhI8AafRuCN3ndM88ZNcpW51fJN/MY/kh0r/LTyuHBH+LGY
	UUCPpaYnAOlDczjwV/xN1sFNlEYAuNhDjQWghv5pWZaFU2YOuYA0mWmOh/HxK6kYjOAU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeVE-000000005Zp-2Gzu;
	Wed, 04 Nov 2026 17:10:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeVD-000000005Zc-06h8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:10:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fVDjyO+NoYLdjbc7YX6fyyV3gZH/OD4B8WSITPufRPY=; b=L9k/pYCnJotqJ4QAhhdBmlZAgz
 jzs4RhR0a0oXe5dDOm2caEE9gcNTDWXrKV5rD8PnM4u3NtUPwLw3cq2k7UPptEIdnd9Z3Vr+g4eSV
 +FovX8Qqij+I98APag3QzeQ0np8w97RP2jD+jk/yvnK1uqti26DS2ShdVobeMsmzAg3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fVDjyO+NoYLdjbc7YX6fyyV3gZH/OD4B8WSITPufRPY=; b=UJvtR9cvDIQlUFcgriIThIAUM/
 oUhuQJXy3fq5NZ0kn2XXH4Fs7dqhD3BfEVxVONJTjncVRq7CPg2XTooELa9yh4iEzyqrrckZgp0Y3
 ijFgtNhBinyeZMFTnxp0JS4EoZkA6xQ5y8iKN7bj33gyf5/dodhk2VN+6DaTphQBDWek=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeVA-000000007sb-2NCD for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:10:22 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso510566f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793812214; x=1794417014; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fVDjyO+NoYLdjbc7YX6fyyV3gZH/OD4B8WSITPufRPY=;
 b=TnrKpNQZwiWtu26Wnj6kepq9fieKPRTKjOdMqDhZjUOodaQGKZPRtJ2r4HjPox9mtz
 AQUKxqtZkL2cmHFnuptliqONYewD51SMkmy+49TM0AFlCgjXqBZhjvVyXyXA7g8LmZeR
 9Zsyb+YLaI5iDYS6MfSW/6MdvKkDM6ZJW/nc8Fxo2hduoWBVJPTvyPFt5PMWr+b/ePex
 F9CJwmJZbp1RsGfrizcbc06G0Bzz6g77+9JOaNOA8bBjHANsZ0bwtarTY25tDvUl2nc/
 7UEX/V2ZDyfraDsSB4N4yTjuARSAu8qrP0RB+fKg/aXoJn9tRcfkIs+QzkK00kPIYOdh
 PGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793812214; x=1794417014;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fVDjyO+NoYLdjbc7YX6fyyV3gZH/OD4B8WSITPufRPY=;
 b=t/W8gywgVlukhXb6yhCa/YktUNSyYpygulSfLQzQCiHt3cHE9w3INNZ4Nqs2HFLA0T
 sw8md7xk/o3Nd9gf1qt3S72JQOLk76iexZw3pGDGZLQzxhKGUNMnzc2sZ80M5NWKsr+r
 k4MW4KNhRs5wWotuBoC0xgFvF7MZTTrtmyjR7gvyedl1ibKxu4uBwxQZRApExiDbcGGj
 v8eakhMN+pnVRRDZE9KjDk48g/EoB12lGZ5jpuhoy2KvZLUSOz/ZYbfPD0+KM258pWUs
 mHNxZigyOjA+8rSdogpR581YZI9r1r6zMSM4chX+/YttYVZnBv2mC2vgTinV43KYlnPl
 xPPg==
X-Gm-Message-State: APuU4Z9WtVdxeDarklqoPItwqlR5sqnAnS3R+HxsuS8J1IUBcMv/9kmR
 +g3yHNPnMjAeFHm0SAGBezqi5FN3CrW1rmwqqyikZdWV9KGcV5BE2Ap6QtS7HXeyHwgy1Kft2wx
 t3PTXliiLvOohIy2XKdumQDHf2pdtBXYE6wSfLDdRllpTAtYYy6vUMuA/OOle36gZUdKV
X-Gm-Gg: AYBFou1j10e/kWsc6B5EJ53GTsy6Bo+2CKpMNSHEvsjF+VA/vwZzHFoPHWO6dhydma7
 10Mr6xVeCQ2PASEEt42tUvzeAMsIzUexSffX8qTTddIGMCc7yMv13F5t0FHxl8X7euJ3bguwiq2
 +W4IKMi2pwnlVV6SjphpjjKR74Qj0ZdKKyqetkipr4DkroNfqO8Rqau4ge8Ix/FwCBz1aanFue7
 CiSDfNkYOQDRUxBR8dtrVCg/mxVJVxsL05KuXSDYkTpyOoqYdeXlRQiHqIHMoP0ZSWSkpUx8W/4
 oAMD7pQug7TFrmlnRENhJaZaWJFkZ4IoyPsCOWw/U99uY9sA+o01bKusfYqLCLlzl2H0s6AVCr2
 E6/EmAp6nmsdG1/4OgGsrwSvOy79xJfzCoEXhz+G3MdWlJovKTlcJJwNdGa4tAOvB+YCffRp1Gs
 GvWdzybhcntnjcx1vVUENp4wC5gjsfJ0KAsccKZNQIACbDn9DXyJO8aDlIc8K/lRkt4PfTQPSVw
 jHcEu5q0NVz06kHSZL1Wv0+ViF5aztPmuDpn/l87lbedl2oFT7036H1Ykcz5c99CAPQ55dyNq9p
 tEDAGApWPVeFcG63QAcX5bsV+af6RLgAKp7pTxmdhuA0mfWy+2wglQwCmD6PWVGvcaO7220Of/y
 SQIqBA8qJ7ZvZVdE+vD5qO+9XKnB79kK4UlIpnD07nNCMlwY8SZyoqYszdKBfcWVmZocz1Erzvz
 g6pi1wbsiS/wHB12g=
X-Received: by 2002:a05:6000:4008:b0:490:2bd4:5c42 with SMTP id
 ffacd0b85a97d-4902bd45fa1mr4203768f8f.44.1793812213926; 
 Wed, 04 Nov 2026 09:10:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fee968763sm4923920f8f.56.2026.11.04.09.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:10:13 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 17:10:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Heiko Hund <heiko@openvpn.net>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
X-Gerrit-Change-Number: 2111
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2111?usp=email>
X-Gerrit-Commit: 9e4394a6511d1e50f1c11efde223635bbc296aa3
In-Reply-To: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
References: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzODM0MDAwLklmYzcwN2VmNjlkNjE0YzM0MDhiNmY4OGM3ODBlMzM3ZTk1YmFhZmFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <072272786fbe39a7d707b36323a0733cd691b41b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeVA-000000007sb-2NCD
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4459658466495714361=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4459658466495714361==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="itpYHavugGM="; charset=UTF-8

--itpYHavugGM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2111?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Heiko Hund


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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/11/2111/2

diff --git a/src/openvpnserv/interactive=2Ec b/src=
/openvpnserv/interactive=2Ec
index 4a8d0b5=2E=2Ea04a449 100644
--- a/src/op=
envpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3444,7 =
+3444,8 @@
                                         =2ElpSecurityDescriptor=
 =3D NULL,
                                         =2EbInheritHandle =3D T=
RUE };
 
-    PACL ovpn_dacl;
+    PACL ovpn_dacl =3D NULL;
+    PSECURITY_=
DESCRIPTOR pSD =3D NULL;
     EXPLICIT_ACCESS ea[2];
     SECURITY_DESCRIPT=
OR ovpn_sd;
     SECURITY_ATTRIBUTES ovpn_sa =3D { =2EnLength =3D sizeof(ov=
pn_sa),
@@ -3624,7 +3625,6 @@
      */
 
     SECURITY_ATTRIBUTES sa;
-    =
PSECURITY_DESCRIPTOR pSD =3D NULL;
     LPCWSTR szSDDL =3D L"D:(A;;GA;;;SY)=
(A;;GA;;;OW)";
     if (!ConvertStringSecurityDescriptorToSecurityDescripto=
rW(
             szSDDL, SDDL_REVISION_1, &pSD, NULL))
@@ -3764,6 +3764,8 @=
@
     free(ovpn_user);
     free(svc_user);
     free(cmdline);
+    Local=
Free(pSD);
+    LocalFree(ovpn_dacl);
     DestroyEnvironmentBlock(user_env=
);
     FreeStartupData(&sud);
     CloseHandleEx(&proc_info=2EhProcess);

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc707ef69d614c=
3408b6f88c780e337e95baafac
Gerrit-Change-Number: 2111
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko=
@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--itpYHavugGM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2111?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Heiko Hund</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">openv=
pnserv: free security descriptors in RunOpenvpn()<br><br>The DACL from SetE=
ntriesInAcl() and the pipe security descriptor from<br>ConvertStringSecurit=
yDescriptorToSecurityDescriptorW() were never<br>freed, leaking both on eve=
ry client connection=2E Initialize them to<br>NULL at the top and LocalFree=
() them at out=2E<br><br>DACL leaked since a24dd2e3 (&quot;interactive serv=
ice v3&quot;), pipe security<br>descriptor since 0a429cb1 (&quot;Restrict a=
ccess to the service pipe to<br>SYSTEM and owner&quot;)=2E<br><br>Change-Id=
: Ifc707ef69d614c3408b6f88c780e337e95baafac<br>Signed-off-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111<b=
r>Message-Id: &lt;20261104074751=2E21336-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261104074751=2E21336-1-gert=
@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 4 =
insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/2111/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span>=
<br><span>index 4a8d0b5=2E=2Ea04a449 100644</span><br><span>--- a/src/openv=
pnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2E=
c</span><br><span>@@ -3444,7 +3444,8 @@</span><br><span>                   =
                      =2ElpSecurityDescriptor =3D NULL,</span><br><span>   =
                                      =2EbInheritHandle =3D TRUE };</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    PACL ov=
pn_dacl;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PACL ov=
pn_dacl =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><span>     EXPLICIT_ACCESS e=
a[2];</span><br><span>     SECURITY_DESCRIPTOR ovpn_sd;</span><br><span>   =
  SECURITY_ATTRIBUTES ovpn_sa =3D { =2EnLength =3D sizeof(ovpn_sa),</span><=
br><span>@@ -3624,7 +3625,6 @@</span><br><span>      */</span><br><span> </=
span><br><span>     SECURITY_ATTRIBUTES sa;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><spa=
n>     LPCWSTR szSDDL =3D L&quot;D:(A;;GA;;;SY)(A;;GA;;;OW)&quot;;</span><b=
r><span>     if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(</sp=
an><br><span>             szSDDL, SDDL_REVISION_1, &amp;pSD, NULL))</span><=
br><span>@@ -3764,6 +3764,8 @@</span><br><span>     free(ovpn_user);</span>=
<br><span>     free(svc_user);</span><br><span>     free(cmdline);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    LocalFree(pSD);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    LocalFree(ovpn_dacl);</s=
pan><br><span>     DestroyEnvironmentBlock(user_env);</span><br><span>     =
FreeStartupData(&amp;sud);</span><br><span>     CloseHandleEx(&amp;proc_inf=
o=2EhProcess);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Demail">change 2111</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2111?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc707ef69d614c3=
408b6f88c780e337e95baafac </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2111 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--itpYHavugGM=--


--===============4459658466495714361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4459658466495714361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4459658466495714361==--

