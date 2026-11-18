Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEE606A32C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cIEiutD9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nPUFOnyL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ehtt4B9z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Nun4E4Dn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J4sRKc4mK4ClOwiBLC/DEEXn+menSJkcvmlhkC8Hpfw=; b=cIEiutD9ia1l148ypIBqRLfOJM
	WTdGuY1eWxh43e+rfjTT0fwo3mXCt52gCf/5MFaEvnG1YI3VrOtV4KuJH7DLFlXsmmJTzl6XkWjfq
	AnNOI4hHHK6a2ZOccpmNJ6kUFiqvo7fLIDErgRE0oMDAL49ZX55t9FGquJ2sKI9VyU/4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTbQi-000000008Lf-3foQ;
	Wed, 18 Nov 2026 08:54:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTbQc-000000008Kn-2wIc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1CZ9D2+eclKTf+6578AzySM3FPw6De9CiGD6A1hFBk=; b=nPUFOnyL4cAfKwumroGowNyJUI
 S9EpU5H/FoUDjzeglkXLhZSoblDX7GvBd8zsAUshKhxOhsV7p6VjIlCJl2KqqVQHoLBI0kAybxl14
 oAonix4d+BVMdLMBrKtC2dHYvNu4eIVj0lJ9856EGdYSF/ioa7gElCk09ACDqZ1UvSs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1CZ9D2+eclKTf+6578AzySM3FPw6De9CiGD6A1hFBk=; b=Ehtt4B9zlhl38ce4r8okmu2KpS
 1vP3WMvd4Kd+r1jM4Xt8eIDibZcSAscXkWCFmtyX4+FEDG4domezoLYtII8RhJXCriwGRwwwb6oVk
 rUgPXnoMBztC3YhKULHpe4oskCgw+fos2tUTq0FFaq7D8azAfYnsEGImHhpDu5v+9vUk=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTbQb-000000008EG-0Hoj for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:54:06 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so12034245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 00:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794992038; x=1795596838; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a1CZ9D2+eclKTf+6578AzySM3FPw6De9CiGD6A1hFBk=;
 b=Nun4E4Dnbg+ZXTvhqkRPJWrwQ0LrBaGoHXC95F56ujc1WKfF95HYo/c9YuNKCHKx7J
 JdKOB1TejDaT/7uOkYkhKEOfmXsYRVoRWt9AxkQeCkM4oI7jDghlQ7iBCHUy/TBWVXDN
 nJ/RUIOFy3Khzk9HYcW1ePAxcKaXrgTo/AuO0RmjRi/wX4x2eH10Kphc9D/hzHZl1Rcl
 l08JNswepI38t928VfnAuISnfg13k1YhKwaHDcpKwQRvUGRCKpPWjuAF2CU7I6DG8JDr
 v56rJ1SF2NyKQzzSFXGeqv81DYFQHRG+UbXQ2FLAKm3ydE+3zM1mGM7KnhwsD4HpJCPa
 N4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794992038; x=1795596838;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a1CZ9D2+eclKTf+6578AzySM3FPw6De9CiGD6A1hFBk=;
 b=jUymcdgU8NVcXQdWU+r8TPL7WC4uBCp/rshgxIizyc6e6+rnwaoZlK7djEj+pp9vZp
 U5wSW2YrkB7gJ/U/LE/Iy2EQKDFQKIjqkfZHqkILIsT4A2liUY/Ilr0OQI0tPZDV6uBd
 XWWmMPLXFXsnQ6e31ydHmpZ+49O2tyZ+ycBD3uyWIj3rR+zXKIlUF1ibY+yMZSCj/jJT
 W+UE3Xygy+UcJrgkRO7CtBa1/gtNxvIsv6VQIOp7UWcK+ChugnXipweRQJdq285Ko0ix
 rx0fP7cZuMNc2Wgij51dGxEv5G0AhWaCyGTXkSKvaWfuHDzKYRRnkgMAZQso62huibO7
 znLg==
X-Gm-Message-State: APuU4Z9yQBpAPtHYh5R0dYIZ+IjkRTti02ZhabP4l4Tp5N/gbX++K2+S
 9ZroTtkIxgwNwTWzSc3opMTeNVdh6jgKxHa6cr7v2fwT0geoR5/dxy8pNoVF51z8xExRjnHRMty
 W55xEBcpwrNLr622ihVq46ihfq08rrXZ+nTpFLne2R/wFxYG0IwhgtJe1Kq3TM8wr+vGeoJUX+4
 ORqcxsGg==
X-Gm-Gg: AYBFou0brxbmaqdgUlGmH4yz3ROOYdOt8msdBxucBoWNBR8dCYLMFiCLVwrxmmu7qyB
 lIT7cK7g7HBT7nx2qhOAyk8Fj6PFcMxWp090ZpKVR3cKtJ+dk359q7oSx5UjRA/MeCg2P042dtz
 2Oo1KsK7x6jcnG6F8g5n8VvFWKTMs70M6a3qkW0HqUObzOOXvjn7e+t31acXLxW59IfQsPmZBtH
 6s6kM5utSOayQfKVKqJLwIsHOmkOizzj7Upc4Q4X7MZmzvGaw6VvbF+eLgdQz0o9v9hWtMxoJls
 9+x1XCsr+1mTK8eNFGQhBe4XCYc8dXNJiw54IjjgJMSuY81wOfLAr9S9wBL96yNYrEG7pn97W4w
 pQoAlPysEMFyXqMtJ3zSifh985Y45C+qO4EoRTMc4takHU8X9b7iAkaFDJmlB8E8kCI2oPNjtmE
 6ZIy4WweACqpYFJwHjp9m9q28WV9rKL+HWb70QklN2el3i58jvkidXRboAMGb450tJ6KgYHNzPK
 0iRaCUCxVW/U30il3ghTDW7P1SYpZeePdCyFJ1KXp5uEPpZH7neEMGkyNKfg5VjyzhkkTnJQzrj
 sF20QSdBzx3J/+T8O5m6sikvQOFZ/8T/k5VdUAJdoqpTqN9Y/EeEiYHUSPhuPT72evUAPm75Xrq
 cHlhsYtRcvlX8x+uUMouNQ2m3FW/XVifIdnXRKP4zxi0kN3f/sluiGSrZUAO5rFbeQzHVXR86Yj
 /p9iwcVxxAI8u5qhs=
X-Received: by 2002:a05:600c:4445:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb7da1b421mr32853895e9.10.1794992038280; 
 Wed, 18 Nov 2026 00:53:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654997681sm2818102f8f.15.2026.11.18.00.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:53:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 08:53:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
X-Gerrit-Change-Number: 2191
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2191?usp=email>
X-Gerrit-Commit: 90464f81459cfb25262b733effa6908dc2484de7
In-Reply-To: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
References: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMwODQ3MDAwLklmYmQ2YmFkYWIzMWE0ODY1M2ZhMGJjYTdmMDg2ZGIwNThmODNmODkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da04236d58ab50075d74af88867616c92788059b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTbQb-000000008EG-0Hoj
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7671395968569718884=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7671395968569718884==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hssIZXVVw3w="; charset=UTF-8

--hssIZXVVw3w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2191?usp=3Demail

to look at the new patch set (#=
3)=2E


Change subject: ssl_verify: remove script temp files on all exit pa=
ths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_ver=
ify: remove script temp files on all exit paths

The file holding the clien=
t's challenge response was never deleted,
although the manual says it is re=
moved after the script returns=2E The
--auth-user-pass-verify via-file cred=
entials file was kept when the
deferred auth control files could not be cre=
ated=2E Unlink both on every
exit path=2E

Change-Id: Ifbd6badab31a48653fa0=
bca7f086db058f83f891
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

---
M src/openvpn/ssl_verify=2Ec
1 file changed, 5 insertions(+), 2 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/91/2191/3

diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verif=
y=2Ec
index 8641d15=2E=2E75cda97 100644
--- a/src/openvpn/ssl_verify=2Ec
++=
+ b/src/openvpn/ssl_verify=2Ec
@@ -1372,7 +1372,7 @@
             "could no=
t create deferred auth control file",
             __func__);
         retv=
al =3D OPENVPN_PLUGIN_FUNC_ERROR;
-        goto error;
+        goto done;
=
     }
 
     /* call command */
@@ -1415,7 +1415,6 @@
         platform_un=
link(tmp_file);
     }
 
-error:
     if (!session->opt->auth_user_pass_ver=
ify_script_via_file)
     {
         setenv_del(session->opt->es, "password=
");
@@ -1487,6 +1486,10 @@
         tls_deauthenticate(multi);
     }
 done=
:
+    if (tmp_file)
+    {
+        platform_unlink(tmp_file);
+    }
    =
 argv_free(&argv);
     gc_free(&gc);
 }

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
Gerrit-=
Change-Number: 2191
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--hssIZXVVw3w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">ssl_verify: remove script temp files on all exit paths<br><br>The=
 file holding the client&#39;s challenge response was never deleted,<br>alt=
hough the manual says it is removed after the script returns=2E The<br>--au=
th-user-pass-verify via-file credentials file was kept when the<br>deferred=
 auth control files could not be created=2E Unlink both on every<br>exit pa=
th=2E<br><br>Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891<br>Signed=
-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/open=
vpn/ssl_verify=2Ec<br>1 file changed, 5 insertions(+), 2 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/91/2191/3</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src=
/openvpn/ssl_verify=2Ec</span><br><span>index 8641d15=2E=2E75cda97 100644</=
span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_verify=2Ec</span><br><span>@@ -1372,7 +1372,7 @@</span><br><span=
>             &quot;could not create deferred auth control file&quot;,</spa=
n><br><span>             __func__);</span><br><span>         retval =3D OPE=
NVPN_PLUGIN_FUNC_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto done;</span><br><span>     }</span><br><span> </span><br><sp=
an>     /* call command */</span><br><span>@@ -1415,7 +1415,6 @@</span><br>=
<span>         platform_unlink(tmp_file);</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-error:</span><=
br><span>     if (!session-&gt;opt-&gt;auth_user_pass_verify_script_via_fil=
e)</span><br><span>     {</span><br><span>         setenv_del(session-&gt;o=
pt-&gt;es, &quot;password&quot;);</span><br><span>@@ -1487,6 +1486,10 @@</s=
pan><br><span>         tls_deauthenticate(multi);</span><br><span>     }</s=
pan><br><span> done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (tmp_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        platfor=
m_unlink(tmp_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span>     argv_free(&amp;argv);</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail">change 219=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ifbd6badab31a48653fa0bca7f086db058f83f891 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2191 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--hssIZXVVw3w=--


--===============7671395968569718884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7671395968569718884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7671395968569718884==--

