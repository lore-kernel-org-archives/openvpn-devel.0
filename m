Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431D606D80E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z1OhjOzj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mZWni36Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Bt3YdbEY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eZnmnomS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fyyPpsxjYZUzifMOlpy5q0FJasbGOJ2ujZ5wwQWiea0=; b=Z1OhjOzjpTmka13qDNQkTAl2t/
	YlFsZuu6paOpGltm4Gl3Sik8QJtL2SuUr08pCXYvCkcXMtDpXJQKbEKND9TLM1qN5ggZ95blhO7S6
	ylhQBczc9v6tYiNUOqFLSKE/88ar2Hz0IZraiv3D7KtGKqf7sQ22cAxUZKlMZq1TCcjM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNwZx-000000007Qu-23PM;
	Mon, 02 Nov 2026 18:16:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNwZu-000000007PW-0odJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 18:16:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyVX6PZRJSvW5NSikKEm84b36RbnPYaOpHmjAXZbY20=; b=mZWni36ZEDQVaPXZ5rHi+rt9uP
 Rmt8N4L0AX1JtlVGts/KZbxa2+VgZ5Mpnanpuh/+7Of+V/X7l57+kCmWlQPGVkbVcDi5o/H4rQBgz
 xqaEqDQZPbll34QMOu9wzdbP5IouhI2PDjTz+xS1cLOiLBPO4mlWDs4B5tqGzvVepMQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyVX6PZRJSvW5NSikKEm84b36RbnPYaOpHmjAXZbY20=; b=Bt3YdbEYmIqqUV242o3d+D8BDH
 Ce38mE0YL/rk6+/aXq4EN+KEDOEEzOe7pYx0JPhdgXiVTDXORhEA+SpD11qFy0zUsXZiAKRBDazgg
 lKtk5aeo/+xt5cq8UFysRM1jHGS0S3Iw0tiNjOqj05iHgkTPpcpB3SslVcYRPFHpucq0=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNwZd-000000008SA-24kY for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 18:16:02 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2049008f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793643355; x=1794248155; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jyVX6PZRJSvW5NSikKEm84b36RbnPYaOpHmjAXZbY20=;
 b=eZnmnomSZuE2aseCEqPdRUPG1IPwLyTXXi9PG3nvmsW0UQg49qv6kQysxYttjIdAkV
 FWQUHMYRa9y/Ya+9qETCk6E3+vryPnrWSjoOMoRz5qYvyoPlzgWh5+QFVXwPR+dlc/u+
 xgKGjueTK93tXwxcAjL+YYpa5TMvi2J52NOAEgRBciFxlyTwZMxJ30E/j0LMeOeIytxn
 bONT9bdZSMEjWq/Uk93dDdRpKGKWLSJ0u4QiwCrMJBS3u7GL0Qboe2TejGHavdLu+DOX
 Gp/MeyITvpgz/LoUFXH5qzaPmaNl2RgV640YG0h+dminuPvYiucE9XcTLwsxQTmSsCkk
 3ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793643355; x=1794248155;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jyVX6PZRJSvW5NSikKEm84b36RbnPYaOpHmjAXZbY20=;
 b=dM3FRcyPaE4lKLnYx7zZB851fK8CA8acGnbacp7VeHzcyX4HLOPno8vq5czUO69Z78
 80yhD30TiQpLdShJhir2eElFZ/jk+tQz4y0jTxKRQK96bahZDX/qLN1zSt9/0fXmkevX
 K7ni7gK5IZtxJo8NMctEZX9RpqSl17EXGuo60m6DmowK8Th0xO4PU0dTaHEMPq2skrSV
 bojRlqwPabqGRSZYped4M3Ij8ecumEHb7T4ue8idC/6TSqKaY0Chf8jHbro/ijhTeTmK
 +tNTbPj9k8qkdRNlcg5LKcg8jHRiJMY+aH1l0yV+CwWvqE0vFZHvoV7NoKXM79NFUUR1
 jwWw==
X-Gm-Message-State: APuU4Z+7ZZy9rsepRwJu+nnUT6sLPhvWDAADTiPP++3JRNx6/Ua+iod3
 ZVOGUP7FMetdhMlMGa2Zk1haEPs1wRvPJc7kPc2YTA2toPT5F2YbqN9KZAkEVzqR9WEP2vY1b5T
 ks2d+0Mwg+BqMz4IatzpW8aKYkE8nl6OFOLWMWDPAtlIaXE2/NWI7zzqXftDL6jRl9ZXX
X-Gm-Gg: AYBFou3xkX391ADfgTxo/5G4KxtAHffApWksTp/vYG9cU/FCSaQKXjQBOBqsIprm5pH
 LFaH2EIQnx/4aNE0zZmrLffjwQyFPNu7C6VHCCe6NexGe7g7hV/T9ScUyg2ywzPHoeiXwUqLWTq
 eoTq2cm/o3afmB6x4KJTqbeYT+83ZtDy69VWVXQorxmf3b4ztOsD8ublXSWhOhdNjS0NqED9oNo
 7Z3DP4qroL1wteE+BStQBQ7QikO1kP4bf/kIBy169xvoH4p1yaC3Zfn0iOvsrc2z2xSuIE+8FNb
 5GI5MT+9N5jv/BS3DGE0R5Q05aedx/tZaMDmSmMg4HtyndyCohJxPdbjSjYa7Xxq1ISPrpKYLeP
 /OmYk81k4O3prNe/sInAr6Q4SzfJ1qjLz+5wlRBkiZh0u2lW8KYG1lszk7gFMyZyfm2gEcahCqs
 uCenvtPJ+qjnLaSG/ckQOIdeRoaBQz6cyULkSwVJyJfV7O2c99MbMw7FLZIi9mc6MCCFiGnDtYv
 +Z6/21ol/Zqg07gniA1TbnZjPue9Ambes89PZTFJkTolyLo1n9ncN9w+bDQjZ0BcPyQjXEPqPu7
 DO8SqsGZhdxG0ELFnYHqGcRpmPv6Haduh0oHBC8duB1Vr+OYTTIEq2mcLzOuOZbT2t6SIq2B1HS
 a3GWDm2nAJOkJc1mg9VxLOkU+/Ru44SMmLIjEI8uMiA2QDr5ijIBythCCFjbOHDJck5w6CNcZ2i
 yI/Xovq3RpA0G9NQ==
X-Received: by 2002:a5d:4391:0:b0:487:219e:5e20 with SMTP id
 ffacd0b85a97d-48e6e529631mr18225005f8f.51.1793643354765; 
 Mon, 02 Nov 2026 10:15:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b959c1sm20887673f8f.45.2026.11.02.10.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 10:15:54 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 18:15:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
X-Gerrit-Change-Number: 2092
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2092?usp=email>
X-Gerrit-Commit: 97933ad9161fac59e4b738b226ad317ff23a3659
In-Reply-To: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI5OTY0MDAwLkk4MGI5OTY5ZjU1NWQ2NzBiYzEwMTYzNTMxOGQyNDVkMWIyZGU4ZWM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c281aa7e3f29f378556280d978fb40289acbde4c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNwZd-000000008SA-24kY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: free gc arena
 in windows_set_mtu()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9039495714728158830=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9039495714728158830==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kDHCVeYmWbc="; charset=UTF-8

--kDHCVeYmWbc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2092?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: tun: free gc arena in win=
dows_set_mtu()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


tun: free gc arena in windows_set_mtu()

The arena used for strerror_win3=
2() was never freed=2E Allocate it
only on the error path, where it is used=
=2E

Broken since 0213f80e ("Set the correct mtu on windows based systems")=
=2E

Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092
Me=
ssage-Id: <20261102144844=2E910-1-gert@greenie=2Emuc=2Ede>
URL: https://lor=
e=2Ekernel=2Eorg/openvpn-devel/20261102144844=2E910-1-gert@greenie=2Emuc=2E=
de
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
tun=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/2092/3

diff --git a/sr=
c/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index fdd13ae=2E=2E58f4750 100644
-=
-- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -5203,7 +5203,6 @@
 w=
indows_set_mtu(const int iface_index, const short family, const int mtu)
 {=

     DWORD err =3D 0;
-    struct gc_arena gc =3D gc_new();
     MIB_IPINT=
ERFACE_ROW ipiface;
     InitializeIpInterfaceEntry(&ipiface);
     const c=
har *family_name =3D (family =3D=3D AF_INET6) ? "IPv6" : "IPv4";
@@ -5228,8=
 +5227,10 @@
 
     if (err !=3D NO_ERROR)
     {
+        struct gc_arena =
gc =3D gc_new();
         msg(M_WARN, "TUN: Setting %s mtu failed: %s [stat=
us=3D%lu if_index=3D%d]", family_name,
             strerror_win32(err, &gc=
), err, iface_index);
+        gc_free(&gc);
     }
     else
     {

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80b9969f555d670bc101=
635318d245d1b2de8ec5
Gerrit-Change-Number: 2092
Gerrit-PatchSet: 3
Gerrit-O=
wner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--kDHCVeYmWbc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2092?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">tun=
: free gc arena in windows_set_mtu()<br><br>The arena used for strerror_win=
32() was never freed=2E Allocate it<br>only on the error path, where it is =
used=2E<br><br>Broken since 0213f80e (&quot;Set the correct mtu on windows =
based systems&quot;)=2E<br><br>Change-Id: I80b9969f555d670bc101635318d245d1=
b2de8ec5<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092<br>Message-Id: &lt;202611021448=
44=2E910-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/=
openvpn-devel/20261102144844=2E910-1-gert@greenie=2Emuc=2Ede<br>Signed-off-=
by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tu=
n=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92=
/2092/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</spa=
n><br><span>index fdd13ae=2E=2E58f4750 100644</span><br><span>--- a/src/ope=
nvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -=
5203,7 +5203,6 @@</span><br><span> windows_set_mtu(const int iface_index, c=
onst short family, const int mtu)</span><br><span> {</span><br><span>     D=
WORD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct gc_arena gc =3D gc_new();</span><br><span>     MIB_IPINTERFACE_ROW ipi=
face;</span><br><span>     InitializeIpInterfaceEntry(&amp;ipiface);</span>=
<br><span>     const char *family_name =3D (family =3D=3D AF_INET6) ? &quot=
;IPv6&quot; : &quot;IPv4&quot;;</span><br><span>@@ -5228,8 +5227,10 @@</spa=
n><br><span> </span><br><span>     if (err !=3D NO_ERROR)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 gc_arena gc =3D gc_new();</span><br><span>         msg(M_WARN, &quot;TUN: =
Setting %s mtu failed: %s [status=3D%lu if_index=3D%d]&quot;, family_name,<=
/span><br><span>             strerror_win32(err, &amp;gc), err, iface_index=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2092?usp=3Demail">change 2092</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I80b9969f555d670bc1016353=
18d245d1b2de8ec5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2092 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--kDHCVeYmWbc=--


--===============9039495714728158830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9039495714728158830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9039495714728158830==--

