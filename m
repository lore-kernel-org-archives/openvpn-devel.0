Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F54606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S/jAZKoM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gmWbSyfB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BI3Lam19;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RcM6sxMJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EKhPOa21oedAoQ28HIVi6jTrpj7i64VtvPyYPbsbvRE=; b=S/jAZKoMqX3ESzYXrRsEnJVA9M
	kewbSF7pXD2H1RNO7yQFDdbixGSzIhcNeOdJ0KsxkOqGXNnYz6LQvjev0v8o59o7mh3AtAAArOArZ
	fFevOPhh2Yepjwn4Xama9qi1mzgUiSALSj/tzCxYLHTLApDvxsw8Op9PBZKn54RWi1Oo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUp7U-000000007VH-0ExD;
	Sat, 21 Nov 2026 17:43:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUp7S-000000007V9-3L6v
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L8kMdOhdnChpMHIU6YBTL854mpINyQ8475pYIM5Mpxc=; b=gmWbSyfBAcidx35hDq0ryu76/T
 SO917P5Rz8ExWSsxJ5AiQbuA1VTbFxSRDqStsns1+X1uXzzqpE6Ukeqz1RfHEIXaYEhs8Cee2qXfD
 qopemHv8nay8FJ44as4ayTnKbEGGquX1YkTbUEUbM90Gd5Swz9ibI8kV5xPwWS9uauNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L8kMdOhdnChpMHIU6YBTL854mpINyQ8475pYIM5Mpxc=; b=BI3Lam197nr5GZCzQ3DciecdFh
 EBaOYTtMYDrqTA1Wi8xuZkjtSeEKPs0gvRLr3EMRaki7dBj9Nuuou10k3NeKq8LkoaVhQIOzT3ccj
 OpdV59GRCoQ+hC5VPVLu9gBmqag3Chd216KaTYEviwl2cwM1aBjGxL7tygXSQH+16veU=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUp7S-000000007lC-0Rv5 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:43:22 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1879715f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 09:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795282995; x=1795887795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L8kMdOhdnChpMHIU6YBTL854mpINyQ8475pYIM5Mpxc=;
 b=RcM6sxMJdYWUaiQHKkgnC6phbP84F2cZaXi5L20hCVQN6ZLeWOgLPsqn4WvXwazOuu
 d2pH/ILZJJtXn4bScVg5BCR2wB1ydjgDYi4AuQrjLJKjL2bg7WpyjsdO4VMuOtbxvtRa
 so+MZ8PSfuriA8ANcUr0Pww6KfCWjSK/qOK+FFKsCusV/O/pnq0DPSuu7vr/kp7G99wr
 WVv++rmMXiIvirkTpR2QCgu+Xp62ZLndfk/o3nhziUNdNrx9nwZ4Zy+IaK5KHBD/BVnS
 rRXWBPHRcfi6L6MWSLGVlxU9Z0eW1v0so+gBEbx6y57V+uDl00Jh1NQwfk7zApLB2Nqg
 jdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795282995; x=1795887795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L8kMdOhdnChpMHIU6YBTL854mpINyQ8475pYIM5Mpxc=;
 b=ULmwsmPuqoyjZPm+dDP3/JzWJwj9MNQUunRWvfAlPuN11yH2J6vCL/Cz+e3gjZvqT7
 LjOuwxPpIoHQ93xT9Lgu6KM8RWAqVDVNHTDG6U0ox9oPuI0atO9ho7Nh4EMEwW7LCg4S
 n5mXROdkUiCJBo6LtMIOHKO8UtZId5qtBy+tte4nRpnprldR8NCpuFhNWVHu+2zuQWIQ
 xu9l3FZQ91oAKjjVfneQuJKv1dsLIRfhJA6mfvy5JnMmuoPP2d/HAdtZth42osOMcbFl
 sevIMAt2u+Lc+QsmrL0s5qE8PAF7balTcQmBWHA7uyJse7Gin+8n53AjiyVbW6OYvkQ8
 G4Wg==
X-Forwarded-Encrypted: i=1;
 AL+hErHoiYsOtbCCNxWJfMLXtAVsXu9FiW2vgXOnCGHFg2cYG7SbOMoMNfKWCMQ1pww6SqBhc9Dhsuf6aFz4M44a@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+vcZ8h8ltQAhDTC5XGJRsqBnI5EjDfsOtGk6Zela/+fEdRVL/c
 ZD5kIaIyBfPhSLWBni4TYJ9PXmmwzUowYrmvTWtRH3mFR1iB2qfQIeqPg8xWfDaV5mrJdrTo8in
 nEjcO+lgCKTKjq8Zjum6wLHw4otIe5UWfMs0AjNgChnQdNGsvShOAGMRtN9jSc3vmZZ5B
X-Gm-Gg: AZFdTZeHJoinPBfRo6I/VjUe4SvXyCr3U8KaVfmbiC/XtEOuv9YHyoU4XVaefaJcA2k
 q0AM4+9rGTVxHyL2VsJ5CRewqdzSb1TelViZyDkkT1+pDJE394MP6OJx8RfnB49iucUh1jTYZxw
 llTOe8f7kCcCv+GXdumH2HVrpWSna2KLtp+bWM2TysJLd17s0CkODBdda0eSLJpovSD38NWM7dy
 IqqDcZsdihUQ7Sc5I11iAKOsQeULmk2cDHGA9kB34SlIJD1OkH5owAXCl8cAQoIXKt5+MGPtshL
 TpaS3vWq2bU4mXuMqWuSvrfo/W3XqpgisYfR/Uh4CarTVcfdjx5Ctp/fCSvof76CkWORqlxeA3c
 1m5YwFd3hIrG/Ff4Al6T5l2e7OSZWR7T7akQUJFPnjKxvWbm8uB5qw3v2EFvyEPghuQJXH9sumi
 sVK2xy4JP5q3Myrazfw0gVVwPK5RBrALN+0HqpMY7pqWuB40onjtYOieVomoj5KoEGdxHwm4g91
 V29dy1H1Du3F097w3O3Je8PzES6CHoISvmHY6YX241P60FYAR9hBy6IvtdQiXKsfjikIgIJHqXv
 UQBH4ir3vVPbhFRpGw3KkMXuJX78iEsYxldByqv9mUltVI8VZR7EbDfvdXGo5tATcE2Pla03pTR
 r4PjNw9COhpphkUykgqLQkY63R+ez6cn1INXMe3ZCxYKvF9KpgSEG8otMEIx4vDaHkcDfmLeQdb
 9jOiGIFeXNshr5DtM=
X-Received: by 2002:a05:6000:2dc5:b0:4a6:67e2:5c6d with SMTP id
 ffacd0b85a97d-4abb400bb31mr13345984f8f.13.1795282994995; 
 Sat, 21 Nov 2026 09:43:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm7452152f8f.15.2026.11.21.09.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 09:43:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 17:43:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
X-Gerrit-Change-Number: 2191
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2191?usp=email>
X-Gerrit-Commit: 47dacce0d488cb126d08c0cd426402e89752a061
In-Reply-To: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
References: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMwODQ3MDAwLklmYmQ2YmFkYWIzMWE0ODY1M2ZhMGJjYTdmMDg2ZGIwNThmODNmODkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e08121cabe3149ce6cb9e109b7a2a212ef7eea80-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUp7S-000000007lC-0Rv5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: remove
 script temp files on all exit paths
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7468711645186257096=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7468711645186257096==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EBoxXT1riWo="; charset=UTF-8

--EBoxXT1riWo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2191?usp=3Demail )

Change subject: ssl_verify: remove script t=
emp files on all exit paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

ssl_verify: remove script temp files on all exit paths

Th=
e file holding the client's challenge response was never deleted,
although =
the manual says it is removed after the script returns=2E The
--auth-user-p=
ass-verify via-file credentials file was kept when the
deferred auth contro=
l files could not be created=2E Unlink both on every
exit path=2E

Change-I=
d: Ifbd6badab31a48653fa0bca7f086db058f83f891
Signed-off-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191
Message-Id: <=
20261119212143=2E5413-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41690=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify=
=2Ec
1 file changed, 5 insertions(+), 2 deletions(-)




diff --git a/src/o=
penvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 8641d15=2E=2E75cda=
97 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec=

@@ -1372,7 +1372,7 @@
             "could not create deferred auth control=
 file",
             __func__);
         retval =3D OPENVPN_PLUGIN_FUNC_ERR=
OR;
-        goto error;
+        goto done;
     }
 
     /* call command =
*/
@@ -1415,7 +1415,6 @@
         platform_unlink(tmp_file);
     }
 
-erro=
r:
     if (!session->opt->auth_user_pass_verify_script_via_file)
     {
  =
       setenv_del(session->opt->es, "password");
@@ -1487,6 +1486,10 @@
   =
      tls_deauthenticate(multi);
     }
 done:
+    if (tmp_file)
+    {
+ =
       platform_unlink(tmp_file);
+    }
     argv_free(&argv);
     gc_fre=
e(&gc);
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
191?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merge=
d
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbd6bada=
b31a48653fa0bca7f086db058f83f891
Gerrit-Change-Number: 2191
Gerrit-PatchSet=
: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--EBoxXT1riWo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2191?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_verify: remove script temp fil=
es on all exit paths<br><br>The file holding the client&#39;s challenge res=
ponse was never deleted,<br>although the manual says it is removed after th=
e script returns=2E The<br>--auth-user-pass-verify via-file credentials fil=
e was kept when the<br>deferred auth control files could not be created=2E =
Unlink both on every<br>exit path=2E<br><br>Change-Id: Ifbd6badab31a48653fa=
0bca7f086db058f83f891<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191<br>Message-Id: =
&lt;20261119212143=2E5413-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41690=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/ssl_verify=2Ec<br>1 file changed, 5 insertions(+), 2 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvp=
n/ssl_verify=2Ec</span><br><span>index 8641d15=2E=2E75cda97 100644</span><b=
r><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_verify=2Ec</span><br><span>@@ -1372,7 +1372,7 @@</span><br><span>      =
       &quot;could not create deferred auth control file&quot;,</span><br><=
span>             __func__);</span><br><span>         retval =3D OPENVPN_PL=
UGIN_FUNC_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto done;</span><br><span>     }</span><br><span> </span><br><span>    =
 /* call command */</span><br><span>@@ -1415,7 +1415,6 @@</span><br><span> =
        platform_unlink(tmp_file);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-error:</span><br><spa=
n>     if (!session-&gt;opt-&gt;auth_user_pass_verify_script_via_file)</spa=
n><br><span>     {</span><br><span>         setenv_del(session-&gt;opt-&gt;=
es, &quot;password&quot;);</span><br><span>@@ -1487,6 +1486,10 @@</span><br=
><span>         tls_deauthenticate(multi);</span><br><span>     }</span><br=
><span> done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (tmp_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        platform_unlin=
k(tmp_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp=
;gc);</span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">change 2191</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbd6badab=
31a48653fa0bca7f086db058f83f891 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--EBoxXT1riWo=--


--===============7468711645186257096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7468711645186257096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7468711645186257096==--

