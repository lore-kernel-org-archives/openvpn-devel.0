Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C7606A330
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CSVW7Nge;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FcEGQVVm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A4sWAeRh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NzHgzujW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=24nMf+l524L+iDbTRp9Euof2M80EgjSh227Q3m2uQIM=; b=CSVW7Nge7U4ae/e+UU3ruvLZYo
	Ml9e84exmFGL1eCeCTpFze+8ffD8ue4XNAjHm8+Q2QuS+H/0NdVYweuXlI58DpXR00DtwKYCm/gzC
	yi+n9sPqsBOqlKvhirsxkdwD0VwOurODdoMVcvg7LHVtWX2A6xxtjiPo7pqhzZMGByhg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzmI-0000000016Z-1aVH;
	Fri, 13 Nov 2026 22:29:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzmG-0000000016S-40UH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:29:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BGUpQDAQjWJR7qv084Nf0jumzFncOHY8Tm0kXG0uTcM=; b=FcEGQVVmnp4LV6zrdb/0fL+6Ok
 75u7MwP48XWA1+4eRSmtcbN7h9eAyU31IKVzCY9z6rdTKj9Opqt3874xqpPq4kslP50SfqZtG4Qn0
 rIFUAlRLRMUB8Da1HckgxZb33itF3forQQDngMKGfFYR0GI8Oq/CzfQ+45w3bMn21btE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BGUpQDAQjWJR7qv084Nf0jumzFncOHY8Tm0kXG0uTcM=; b=A4sWAeRh2ZOSBR6ZvG9OoGmB9m
 5jdWG0jF1TyxbQUROveJpvtLam5jYhBgSkBUtBfeGKGoRWjqs0jdThi3hze/FQXt8uitvxI7t5wdz
 j8VHODKQWVMRD80VMjkRD9bYBv7qBh5nvHgS0t4U9DgRh4d6fj/3ouWjttsAVfvQCxYQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzmG-000000000EN-1H6D for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:29:48 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4919a880834so728613f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794608982; x=1795213782; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BGUpQDAQjWJR7qv084Nf0jumzFncOHY8Tm0kXG0uTcM=;
 b=NzHgzujWG9B7BdrfnQ9HO0UEkqyP4ob2TFTXwwf36VlCGPyJxf2K4bvJLAF8BZQ/Et
 kUI0mtu0BuzO9CfFuqmWU+uNBmxAAH5CQBKEhM9jwPKb2NR6Nrx3eEC2p0wXYBoNMmfF
 cHn/KrXxXzdW6WuzXyCST2teMhrORr7318iMCupQDKq5EWiNN/G+ZaqREpM2CUSznhvo
 bpev6k/fdI7VDmGiBCEm1fJS9Qlj+IVM5r29oAvspVouQOthpuJMs4HLCliHPwmCAvn5
 X8fcGH2kewNSy2/2fE2wUHnH1YoIKf4YjfCap5AgYTQijpsC4KG88m+CCu6TXDlXavwp
 PzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794608982; x=1795213782;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BGUpQDAQjWJR7qv084Nf0jumzFncOHY8Tm0kXG0uTcM=;
 b=gyfyFjAVASPTu5qzaGDQtdTXdXcSg7x1VNoqA4tfDPYRAHD2EfHvxcK2sIMhvo5z3F
 QVRFisrfpaa/iYnhJmVgp6yq1t4BsFSD2EIrSeag9G4mWIW7vDL0IO9VwVCpldr8whu1
 edsb8yD9Ym9vbtzHLIwtSX8yUu0wJTMJOQ3CamWRWYTk1wmW73UnYXg2oYaZuwrRH0Fp
 Px9ARDG2CwhxmNTS+9lCiF58PFNwKvEOjJ8mKK7pPqUSn79gWCYjKhgM69XUxOYJcwjQ
 hcTsFxUVxeFMt1BoGIT1j3c4hBRPuCeauQ9kXYKp36ZqaB08mlCZFDOa6S6ij2C8192S
 bDpg==
X-Forwarded-Encrypted: i=1;
 AL+hErG8ilbRXFw4Csho0WESzNRubWkoTmuLBhMrLiqCkZpepBtzkydtWBrlYb31uzvV7CPVQTXcxIQy3QzD72Nu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8e6p1wP1dmZm+KAEJKiDw7lqCFEmdxQDl8IUeV+ZyHR/GOodcl
 qtYhQegqx6uXCyK76IGBACrpy1LzlNUfp8HVoIFL14O9OBOie+28GKWHln0nWqGUSfpWNx0Yow0
 k+5U4Tq8bx2fSKT7/KtPsZhuQxHUgRx1a39X8YaXJMqSEalzrONi7oyWVwD3FX6JzS3qP
X-Gm-Gg: AYBFou3b/NGoUrU5fopugBH2xhMPpLBAevWbTH1WKlI51iJqeJ1PzCxy8QS2Xt1HOs6
 KRC916v52iNDIgvIdsTh1ApUAqbX+w8y2wJ+r2uueTzzNuMcJeZOtvFqr1EEzDRf+68T5iUUPPA
 Ww4fJBk98GCvXd03FtbWuXYEee/Yvlv547AxKWOdHwCcfDMBfEy4HIJlPre8QEDOgN9XsX+7o8C
 IMdWM0FJLoXjzLWyUT90GLjBrCrvpTfQIErctjQBBCQl7JpNO2QfQILVg1GjzulehmlbHfELpMN
 Kr3q89wq3g4DY0RIxbBl+UDY9SzEWB3+9hD+qFWfPPifLq8eU2kX02tmAlCF0sfaQlP8n3TtHEV
 hu+ffi68XpK/6IA1TBeMmvQVMVug5Z4ue+1NvwcOLox6XFHeYlK3aepO54hJjtCX7IEiDNmjCvu
 1K8p0ycOrBz3xwoLaesQYHUnJb8M2/47I7KsLezohcyNR/ngVTtx7+EgcuuHgWyxar8E0L5b2Dg
 wtvt49X2APsaBjBuGpuM0rjHrFUix3TFquDR2cTh2/Vt4AeFbMC8nErwY/6H928+tF7tjZw7R/Y
 x5gfFp0SnjKvTS6eApRCqTfD1STKU9zScsc1AYVzI0aHO52Bna8Hs33WZjksKRqzIIz2WU/VGcF
 cZ2dNX4Y+2RYKnbNYkKoTZg9oDG4xc6ILOtLteEOduHcjJVUCnWZBDoLHPRnuWMDzgyJF3GDfmj
 nS1DHkRqYXAlGu0BipEGqIxW9QxXI0TNHlqzha
X-Received: by 2002:a05:6000:27cd:b0:48e:5eac:7e48 with SMTP id
 ffacd0b85a97d-49c714a2f12mr5642886f8f.22.1794608981411; 
 Fri, 13 Nov 2026 14:29:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm7068809f8f.29.2026.11.13.14.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:29:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:29:40 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
X-Gerrit-Change-Number: 2176
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2176?usp=email>
X-Gerrit-Commit: 9e9f76c872fc67fe5ed9a11853509cf965c30d79
In-Reply-To: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
References: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkllNzIyOGVlOTVjMmI0M2Y5YmUyYmY0YzZhOWE5NTlhZjJmNzI5MDg4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30d1204dda0c495c457557ccb96e06a414933250-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzmG-000000000EN-1H6D
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: Make
 error_flags unsigned consistently
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7610835995296557287=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7610835995296557287==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E6Qnp4rXV98="; charset=UTF-8

--E6Qnp4rXV98=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2176?usp=3Demail )

Change subject: tun: Make error_flags unsig=
ned consistently
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

tun: Make error_flags unsigned consistently

Previously both int and u=
nsigned int was used=2E

Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f7290=
88
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Raz=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2176
Message-Id: <20261111183203=2E18722-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41174=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 4 insertions(+), 4 =
deletions(-)




diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
i=
ndex ea77f16=2E=2Ecb89627 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openv=
pn/init=2Ec
@@ -1801,7 +1801,7 @@
 
 
 static bool
-do_open_tun(struct cont=
ext *c, int *error_flags)
+do_open_tun(struct context *c, unsigned int *err=
or_flags)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;=

@@ -2303,7 +2303,7 @@
 bool
 do_up(struct context *c, bool pulled_options,=
 uint64_t option_types_found)
 {
-    int error_flags =3D 0;
+    unsigned =
int error_flags =3D 0;
     if (!c->c2=2Edo_up_ran)
     {
         reset_c=
oarse_timers(c);
@@ -2462,7 +2462,7 @@
     do_close_tun(c, true);
 
     m=
anagement_sleep(1);
-    int error_flags =3D 0;
+    unsigned int error_fla=
gs =3D 0;
     c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);
     =
update_time();
 
@@ -4530,7 +4530,7 @@
      * open tun/tap device, ifconfi=
g, run up script, etc=2E */
     if (!(options->up_delay || PULL_DEFINED(op=
tions)) && (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP))
     {
-      =
  int error_flags =3D 0;
+        unsigned int error_flags =3D 0;
         =
c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);
     }
 

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a95=
9af2f729088
Gerrit-Change-Number: 2176
Gerrit-PatchSet: 3
Gerrit-Owner: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--E6Qnp4rXV98=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2176?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: Make error_flags unsigned con=
sistently<br><br>Previously both int and unsigned int was used=2E<br><br>Ch=
ange-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2176<br>Message-Id: &lt;20261111183203=2E18722-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41174=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 file changed=
, 4 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index ea77f16=2E=2Ecb89627=
 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/sr=
c/openvpn/init=2Ec</span><br><span>@@ -1801,7 +1801,7 @@</span><br><span> <=
/span><br><span> </span><br><span> static bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-do_open_tun(struct context *c, int *error_flags)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_open_tun(struct co=
ntext *c, unsigned int *error_flags)</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D false;=
</span><br><span>@@ -2303,7 +2303,7 @@</span><br><span> bool</span><br><spa=
n> do_up(struct context *c, bool pulled_options, uint64_t option_types_foun=
d)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int error_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int error_flags =3D 0;</span><br><span>     if (!c-&gt;=
c2=2Edo_up_ran)</span><br><span>     {</span><br><span>         reset_coars=
e_timers(c);</span><br><span>@@ -2462,7 +2462,7 @@</span><br><span>     do_=
close_tun(c, true);</span><br><span> </span><br><span>     management_sleep=
(1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int error_fla=
gs =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsign=
ed int error_flags =3D 0;</span><br><span>     c-&gt;c2=2Edid_open_tun =3D =
do_open_tun(c, &amp;error_flags);</span><br><span>     update_time();</span=
><br><span> </span><br><span>@@ -4530,7 +4530,7 @@</span><br><span>      * =
open tun/tap device, ifconfig, run up script, etc=2E */</span><br><span>   =
  if (!(options-&gt;up_delay || PULL_DEFINED(options)) &amp;&amp; (c-&gt;mo=
de =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        int error_flags =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned=
 int error_flags =3D 0;</span><br><span>         c-&gt;c2=2Edid_open_tun =
=3D do_open_tun(c, &amp;error_flags);</span><br><span>     }</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
176?usp=3Demail">change 2176</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2176?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merge=
d </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2176 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--E6Qnp4rXV98=--


--===============7610835995296557287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7610835995296557287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7610835995296557287==--

