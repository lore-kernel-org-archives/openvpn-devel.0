Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E0606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IZlNJLZo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jQ1Af87k;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FBtJxf0S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IXXpSzCF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Mlexa493wuv4GPiGH3Mb3YExD9XkBV6Pn5PcxCEJWeA=; b=IZlNJLZoFcNU3xQjYqfsI0WrBJ
	G0DiRP1uTbyWe6e75rSCp5RJruQmcwu3uNJZwHeIkJUE/+jLpJhUZc66GtOycgXh9Ah9qU25aa5ah
	/i9nhm1PkdQ2WPSarGySftXvYHXpRm/dITfy4WBicJxJwZoYg1aNNj+TuMFRCELkxInM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5U2-000000008Sz-24UM;
	Sun, 22 Nov 2026 11:11:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5U1-000000008St-3Kmn
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DZhThUmqy9fVGDyOVvyYuukO4nZ5uP9kpE72bQ09rKw=; b=jQ1Af87kDNE4kr2iuRzeWoF3As
 cDU6adVLXVMWuDPEP5KfZPqa74oiwBgfHsF4na9mQvLMnNHO7lCxMXN/oYqOwwiKcVN50zXdSgCKL
 Rb7wnmPiratzffXW5sj346htxEPwVLBtLLR/0FdKDWYFyBrXZ43KtB96b+mGdcANK3qc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DZhThUmqy9fVGDyOVvyYuukO4nZ5uP9kpE72bQ09rKw=; b=FBtJxf0SA05h/D+o0/p1U8sUyD
 paDQ9f7xJyaUL4RjobF/AO7BgpkRVT7EA20D1VNQAa/BIYTJEWU7ZTETBr4ulpK+uUmaBeio4ac8w
 ZH0NGRMQjx9gIfk7JmDZjs5UwTbRGNiTzCN84pwKdl+OVR4h8LbDOLm2GCXuK1PbVy9E=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5U1-0000000082k-0JA3 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:11:45 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso1559851f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795345898; x=1795950698; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DZhThUmqy9fVGDyOVvyYuukO4nZ5uP9kpE72bQ09rKw=;
 b=IXXpSzCF9zBwipFBvle6L0zY5B1zOesg7ygOlesXbXyhcWV0bIwcCRZYf/YNQZP5zW
 UhHAA8QQv41p/BrHPsQ46rVO57Gy5XnptUw9NVxya37PSDbGe6dtr4K9N72ldiJxi/GG
 H3wu3lqY51tR/9WFY87iE/YBBHTppXSIooMIZGR8v9yx41kS8tltj08ciI4cz8jNKTk6
 mYlCdnSOkDYuoUnPpDe9pOlg/fybs5VjWnyw6KO0mrzLBAXf+FWgX1solJj31jwEUTFZ
 9p4n7ag44CL76qJz6M/8ekjlNlSxCM+ubilDuUlU6lu15NWfGW+oXM364kMk654Tpaff
 sd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795345898; x=1795950698;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DZhThUmqy9fVGDyOVvyYuukO4nZ5uP9kpE72bQ09rKw=;
 b=wAviGZMwtE6ctiNuAJqdclIiPPX/AJah/DlX1Om9/aG7KC2o4aReABrzdHrZiY70To
 uYzXR9h4kFQS/7xHWAryKY0bubS6SB407pe+/NVeKbjxL8Ww+Jmt2i8uQNOsmbBibbBr
 X7WnKxoqVhMnoQBPyao8QSJ+kHg/BLJsiSR23TW/1BzbLiCIDBMsp84juqknM850t23I
 FmiHapq3GItqdKkRI7egqjoXsSb+sLdysE1yYz/yFsrNVmorw5/4Qdu18DKN4XXja33f
 mdigcxIlpt2eopt8QfRBC4iQWsK2wfYU/ocAQnxjTZR72PTB/721XV2bvtE9t7J/1WPd
 L7Sw==
X-Forwarded-Encrypted: i=1;
 AL+hErEeLlTiN9Xv0c4IY2DAi6SZDv2cNwFKgW8cnE9GnJFSJikjupfBBadBgaXahPc/iZ1u4RH6lq4gWUxQUa0v@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8SjLbK5g8GsxPXJDbp5O5Qz2zGqujOAqAFPhEfATuVjy3Iosme
 wkdAsz3f63jmNC+ktFYMBu6BknqKwc+5a7CPYxpZzD1Z2NOHVYPIpDfnVNPL7eWolNH27Y79Nl/
 ouE8D906Ac4k6A017t00RlJSUG+FndF2t58znIIB9zES78nFwdIUn2XnXpHkMFVxg3lG6
X-Gm-Gg: AZFdTZdauWm9SmZMuVz+y9inFvDNvgu8Ug27rc7toN8fYjmAZXNznidc4vIAPxFFPYV
 kJsAHbO2UVQCLe27FFcknEWiaDdu/4ioxkni8dU37c2E+PG1Gm/rBZkSgg/vnWiCJB+ezoYficA
 iqLgWYCVvsBFXP2/H++yeSU0ZoxfxFL2dhZpxVU2FrXyZWfDk+4tXdC/f60jRLXm71CPurJkNtV
 IrrZNScxZXUcqokin938PBbOnA+5mC6X9UrlSmMlBytq2Ebjl9MUhM+DiO+0quwTwC5cIn8XpDI
 GPYUtjLEG9Ub1xbdg+v35ExAT5R7u+BR+rYHdgUls5qEHUMn1cw6wQQXL9Dz1Lk8xopXNQM0tJ4
 QXD6iQ1ZymMZxhTz3URN5kP9uuX2TiIo9LUn9fJ0exVLRN+XLPHjIKa8yI+ymn/fENNeCvIyAkF
 Ya9TUW5o0nJyQsXvQr+lT6o6FShAECDlHcyj1K7z/AriDHPcGdUQtZt00exO6sOxhLDjfyikVfK
 Fz4DbJdLZRp3hrtiRRY63y3h7NU8A7muVvnRJe13Zs2J/5jK73aRdvGPyBAXjnNKerljYbTbTei
 jMnRDr4aP8HZCtIQdmJTcPEMkEkRL8BI6ioZodT6lS4w8b81Y+6o0ILBP1Io3+R99lPIMo4EHeC
 rXWudQ8HHyNhC/I3z/yF0n9AIxkQoiZyxHaFsFeQnFxq3zgwLQzOLlIGz1tl8mE+O8xsknSd3SO
 oBZGJ0FPkio5qcGEtNf5QS9dn+l2k5AnCm1ILt
X-Received: by 2002:a05:6000:4310:b0:4a9:6c58:178a with SMTP id
 ffacd0b85a97d-4aa55bfeb43mr23547724f8f.12.1795345898324; 
 Sun, 22 Nov 2026 03:11:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm10610600f8f.15.2026.11.22.03.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:11:38 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:11:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
X-Gerrit-Change-Number: 2220
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2220?usp=email>
X-Gerrit-Commit: d8e22c5191904153e43d982327f5f0f2cfbe7d92
In-Reply-To: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDI0NjMwMDAwLkk5YTc4ZTU3Y2ZmODA1ZTE4OTZkNzlhMTdmYmNkNDEzMmM1YTRiMWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e66a6b15a3f7c564e1e185ab9692a2be2e9fc26-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5U1-0000000082k-0JA3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: fix MSVC C4047
 in key_method_2_read()
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4427850725371728273=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4427850725371728273==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zmAhKdxqByM="; charset=UTF-8

--zmAhKdxqByM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2220?usp=3Demail )

Change subject: ssl: fix MSVC C4047 in key_=
method_2_read()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl: fix MSVC C4047 in key_method_2_read()

Assigning strstr()'s resul=
t to the bool remote_usescomp warns under
MSVC and fails the /WX build=2E C=
ompare against NULL=2E

Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b=
3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stip=
akov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2220
Message-Id: <20261119212622=2E5852-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg41689=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/ssl=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)




=
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index e06659a=2E=2Ed=
5ae13d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2409,=
7 +2409,7 @@
 
     free(multi->remote_ciphername);
     multi->remote_ciph=
ername =3D options_string_extract_option(options, "cipher", NULL);
-    mul=
ti->remote_usescomp =3D strstr(options, ",comp-lzo,");
+    multi->remote_u=
sescomp =3D (strstr(options, ",comp-lzo,") !=3D NULL);
 
     /* In OCC we =
send '[null-cipher]' instead 'none' */
     if (multi->remote_ciphername &&=
 strcmp(multi->remote_ciphername, "[null-cipher]") =3D=3D 0)

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c=
5a4b1b3
Gerrit-Change-Number: 2220
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--zmAhKdxqByM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2220?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl: fix MSVC C4047 in key_method_=
2_read()<br><br>Assigning strstr()&#39;s result to the bool remote_usescomp=
 warns under<br>MSVC and fails the /WX build=2E Compare against NULL=2E<br>=
<br>Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt=
;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2220<br>Message-Id: &lt;20261119212622=2E5852-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg41689=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 1 i=
nsertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index e06659a=2E=2Ed5ae13d 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -2409,7 +2409,7 @@</span><br><span> </span><br><=
span>     free(multi-&gt;remote_ciphername);</span><br><span>     multi-&gt=
;remote_ciphername =3D options_string_extract_option(options, &quot;cipher&=
quot;, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mult=
i-&gt;remote_usescomp =3D strstr(options, &quot;,comp-lzo,&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;remote_usescom=
p =3D (strstr(options, &quot;,comp-lzo,&quot;) !=3D NULL);</span><br><span>=
 </span><br><span>     /* In OCC we send &#39;[null-cipher]&#39; instead &#=
39;none&#39; */</span><br><span>     if (multi-&gt;remote_ciphername &amp;&=
amp; strcmp(multi-&gt;remote_ciphername, &quot;[null-cipher]&quot;) =3D=3D =
0)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2220?usp=3Demail">change 2220</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c=
5a4b1b3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2220 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--zmAhKdxqByM=--


--===============4427850725371728273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4427850725371728273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4427850725371728273==--

