Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535C606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SlEi3WM+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FCObb+NI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sx/UqUgE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OoTqvUF/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Ck84xjC8OoHgforpUQlm31Oen94AsjbNWnfo3E9hSRU=; b=SlEi3WM+6zQmsG5hw1nrfPn07g
	gNKFGDRDeBqpQwUlggdXMSGN6T4CHHkQIiaw18iyRjG3nInsPQ7MnGYIjbiHnUGexAV+oUnQ2hODx
	lNPqaCpXVWkfkMTCoBxJiEGM55AAx4nYaKz6ZWemx7snOau3b/yE6uBE/sTrveacp6X4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmea-000000003yQ-2fMY;
	Tue, 10 Nov 2026 14:16:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmeY-000000003yK-3Owv
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fYDxbktRahSUsn5uMi7yBiiqK23E1kUP6vhAgaqnyac=; b=FCObb+NIw3tUekzSkKHeWKIUtv
 nkEhVYPRACvOzjRF0Xh3emgcgAAnmnYrvpFmybpd8iDZhKx9buNvgxKczN1YrEbjE3FhQHYjzbSbW
 87wQhplZJfGXzyiSwUq0ltL1wnIzichUSaB4Nu+XVjO/lkzPrm2/bDMTBb/FLg2NshMA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fYDxbktRahSUsn5uMi7yBiiqK23E1kUP6vhAgaqnyac=; b=Sx/UqUgE6PFRWGQ91Z4FGgL0pI
 ptGCFvonYh2L7N7bdnRaxkuIwQrh8F+oAecX93uLxZxsERabtmWU1vm1RYa8faKVOk8lUaFpZEBJ+
 JtC7CE91vM9XLGjBtvsOGztdJTeZhA5kyGX9gxLjxZHJEhZmJrgIYoL9zwVoKU8bXqVI=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmeW-0000000082H-0jLo for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:16:50 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so12529605e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794320202; x=1794925002; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fYDxbktRahSUsn5uMi7yBiiqK23E1kUP6vhAgaqnyac=;
 b=OoTqvUF//O3rpS/J3wfazOFfAzBIRACOPaGMs9pK1UwOd/SlcVMynF55ZlcAD7pQgP
 q73RK6eLLDf/Y2Chh7ySAzvlXpwfkCu5xfkgK5v/RH+uFcLkNrVNqsq2hMLI3P7zKHLX
 UWLIJOHo6XTLqRzEVhtr818gbMTpgAxTTBpsC9qM3OsgJJM72vhSBh0I9nK71L0hQHly
 Drvr3fQsiwr7j7aS4/h9mMLQLZHbrslO8HHf+geqqGeuT11JlUhoQo9DLGyG006egZEd
 MuYEzE4gt7kBNWBKIxRdasl9ozpeWOe2LoqzjWV0i3mrXCkcKYUvptFjroqX9QOujWa3
 Mmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794320202; x=1794925002;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYDxbktRahSUsn5uMi7yBiiqK23E1kUP6vhAgaqnyac=;
 b=YW5rfuwsTD06rMWKM0yl3P0KAB89twbEmGTKWvyyn2jSPa/jdciueHcB4L1lkWZLtY
 Gy++FNVG7S9RZo097EZ2jd5LMbIEh++SQ9g6GfMXm+hIadbTpvCIxqyDUBdJGh3JANgj
 8KZIkjchHDFY9swEgAUSXgP+JMvGEPq6cy9nvYxsx9SA3FMvdZOTwn5MRBhAJALBAUQH
 gk3y3os7r6pVAqeJylrsQiBDJwGro/PVlLHx7zxao8dpsO4vrlGp4b8dbJzNAuuPKpL3
 dZuE417ZTzdZbzuD/QzLmkR9ZnWgtgl+a6GSvnv05+JNdZoNpilc64CKWOjaJH8lu7XS
 cIhQ==
X-Gm-Message-State: APuU4Z8WfVhabLn8dNj4wX14fj7rNTkrjmaDJSuMSLA/08M2VzKCXEWf
 cGaKKUBSTBimBzGWEaQECdSOoG83tE9JI4ua4FLzbOOSiaD8S9MaFt68ysVxnXh1X0VMA2tk8Pt
 eEAKunoytNi1RvUgtsnxdxAvAw7XKOSGRj/7t/HnadN+RSYXFs3r+loAlvuqV+thJ9ZnSRrjibR
 le/2QILw==
X-Gm-Gg: AYBFou2aAMc8q8LFCf9Z9Mc7EzQwhkPmmWfRabutV/GJKX3d2lzimJMVmJJ6/FLOfpi
 KrAppuf8GKNUFLGdhkKlNxxdh0BaSFQuWnEnY9Y4jI1I4V+daHQGEXp99yX6fnIXBg2lXDLJyh+
 JHmZuSuwndqhc5fMce5iXvdJc7U6ukuy2RPG4i1HSm5UEo9VDK1DiY4qgIT4Bj/T9qsOSDjf3zR
 m5suhpaVINIutobyJY3jQeMEdFE3YSXOfx+wOs5qvmRv/Cx8TNkLc+jMFI3bpQEA5OxiuON2dFy
 szvqxsqVHPyJewaCllv9YbQ2eHy1bNsCKIo3NVbuJZuwYFKLh59q3hiIWHmvX5ERbNMW+KgUb7N
 6BM6ZswONf3tpSmFjwGFASSUZXY3pIioWyGtyWWn+aIrtWd12dlOcUhxUSLpnqj5JEuMvDKQm4m
 7ytpdXSESih0e7YelRdZZM0+3vqCucSWd1/s84R0TFGynHtjxJxkGAvYfaGXeeVfLdzqUVi52Dy
 amXeuE8ijCYr13rZnohlpr4vQw/K56hhws0A+cqNSefMFK2qGWXaGz1Ay4waCdB2U+tZdU181RT
 MnJ41q/6Pnq2S3AGe3DIQfaSkBeWiv5hPde5ZumrW70FpK2snDUk+GF19kNEk+ds8e7myy2onvo
 Zga6qelONmSkc2GgbEArS8pGdquMvYVr4fM9Zz4dDX9Zme+CEO7wdJsHTYKAf1D0muqcqOO3yRJ
 cX6iJtIBQu77n70nE=
X-Received: by 2002:a05:600c:500d:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4ba0233cbf4mr47860745e9.6.1794320201446; 
 Tue, 10 Nov 2026 06:16:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02345d22sm77305735e9.1.2026.11.10.06.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:16:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:16:40 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c
X-Gerrit-Change-Number: 2167
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2167?usp=email>
X-Gerrit-Commit: 41bde54e60b80823124880697168fc4844d3523e
References: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzIwMTk3MDAwLkk1YTgyN2Y0YzZkMTY5NDIwNTA0YTQ4ZTEzZWU2ZWIyODA1M2RiYzRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb5bc9a4289e83b870197c86f04e34a1d341aaf3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmeW-0000000082H-0jLo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: drop dead
 code in inherit_context_child()
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
Content-Type: multipart/mixed; boundary="===============9121012577157178235=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9121012577157178235==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UgCDNkfBBTI="; charset=UTF-8

--UgCDNkfBBTI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2167?usp=3Demail

to review the following change=2E
=


Change subject: init: drop dead code in inherit_context_child()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: drop dead code i=
n inherit_context_child()

The ciphername/authname copies are overwritten b=
y the
dest->options =3D src->options assignment that follows, and the
trail=
ing IS_SIG() return is a no-op=2E

Change-Id: I5a827f4c6d169420504a48e13ee6=
eb28053dbc4c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M s=
rc/openvpn/init=2Ec
1 file changed, 0 insertions(+), 7 deletions(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/2167/1

d=
iff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 3bc4de4=2E=2E=
bf88213 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48=
71,9 +4871,6 @@
     dest->c1=2Eks=2Etls_wrap_key =3D src->c1=2Eks=2Etls_wr=
ap_key;
     dest->c1=2Eks=2Etls_auth_key_type =3D src->c1=2Eks=2Etls_auth_=
key_type;
     dest->c1=2Eks=2Etls_crypt_v2_server_key =3D src->c1=2Eks=2Et=
ls_crypt_v2_server_key;
-    /* inherit pre-NCP ciphers */
-    dest->optio=
ns=2Eciphername =3D src->options=2Eciphername;
-    dest->options=2Eauthnam=
e =3D src->options=2Eauthname;
 
     /* inherit auth-token */
     dest->c=
1=2Eks=2Eauth_token_key =3D src->c1=2Eks=2Eauth_token_key;
@@ -4930,10 +492=
7,6 @@
     }
 
     init_instance(dest, src->c2=2Ees, CC_NO_CLOSE | CC_USR=
1_TO_HUP);
-    if (IS_SIG(dest))
-    {
-        return;
-    }
 }
 
 void=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a827f4c6d16942=
0504a48e13ee6eb28053dbc4c
Gerrit-Change-Number: 2167
Gerrit-PatchSet: 1
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--UgCDNkfBBTI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: drop dead code in inherit_context_child()<br><br>=
The ciphername/authname copies are overwritten by the<br>dest-&gt;options =
=3D src-&gt;options assignment that follows, and the<br>trailing IS_SIG() r=
eturn is a no-op=2E<br><br>Change-Id: I5a827f4c6d169420504a48e13ee6eb28053d=
bc4c<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---=
<br>M src/openvpn/init=2Ec<br>1 file changed, 0 insertions(+), 7 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/67/2167/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/s=
rc/openvpn/init=2Ec</span><br><span>index 3bc4de4=2E=2Ebf88213 100644</span=
><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/ini=
t=2Ec</span><br><span>@@ -4871,9 +4871,6 @@</span><br><span>     dest-&gt;c=
1=2Eks=2Etls_wrap_key =3D src-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span> =
    dest-&gt;c1=2Eks=2Etls_auth_key_type =3D src-&gt;c1=2Eks=2Etls_auth_key=
_type;</span><br><span>     dest-&gt;c1=2Eks=2Etls_crypt_v2_server_key =3D =
src-&gt;c1=2Eks=2Etls_crypt_v2_server_key;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* inherit pre-NCP ciphers */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;options=2Eciphername =3D src-=
&gt;options=2Eciphername;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    dest-&gt;options=2Eauthname =3D src-&gt;options=2Eauthname;</span><=
br><span> </span><br><span>     /* inherit auth-token */</span><br><span>  =
   dest-&gt;c1=2Eks=2Eauth_token_key =3D src-&gt;c1=2Eks=2Eauth_token_key;<=
/span><br><span>@@ -4930,10 +4927,6 @@</span><br><span>     }</span><br><sp=
an> </span><br><span>     init_instance(dest, src-&gt;c2=2Ees, CC_NO_CLOSE =
| CC_USR1_TO_HUP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (IS_SIG(dest))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?usp=3Demail">chan=
ge 2167</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2167?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2167 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html=
>
--UgCDNkfBBTI=--


--===============9121012577157178235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9121012577157178235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9121012577157178235==--

