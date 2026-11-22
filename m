Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE5606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RbCTDcY8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NklWi9VX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IxRG7NOJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=akLooh1S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PnssW5Xo8b04yS0+aZuOwM2Py64mTu1kscOYuqe4MMI=; b=RbCTDcY8iSydKEDc342A6lEn7o
	cUitBQfKT4kJoLZblk9YXkBVPHp4jGhmC9R6rZbnH1triZpekRJ6wJ2XsM+xBaMmneMUAJcGG7+MJ
	c2+qV4LItgoE5UYTO7rJgp+3qsrUNSqGdJYeFiKzNgE9U0hDkQerMG73p5fQLbulf7Ts=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5U4-000000005bT-3Fr3;
	Sun, 22 Nov 2026 11:11:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5U1-000000005b6-3Af0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sEv669DRC0AJQBXzHESGsO/jzMOrkZK+bfeZNbgwngs=; b=NklWi9VXAu6v4JyjrlKrdvcLuR
 CcLhnACcHVmu2gw7QxzjBMtCn0PVAZw3S8mA4BfB81A4yu1mKcoNk4U0juVBh5EhkYHkvOY3t/PYt
 pDPSstK/BHFAmKQvvIz310+hG6mdKVTB0Nx7jlp9Q60QKiNMydH7Rqrw/qDx2N4pMrkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sEv669DRC0AJQBXzHESGsO/jzMOrkZK+bfeZNbgwngs=; b=IxRG7NOJdVg8J/YQKIMJXsfW8O
 Pj/5z9qPKMjMJwS4Kwez13s15yTt6rIwomcg3IkDVYTqefI0bJvOt8rEZoz7v4K+kX8HmZFiWdv+9
 HNzZjvTSzoOyEXctIiil6EjpE6Spis6jnM8cpLoU2VmFRSSzKFTp85i6EWVu6msjNafk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5U0-000000005L1-1NII for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:11:45 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso27388985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795345898; x=1795950698; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sEv669DRC0AJQBXzHESGsO/jzMOrkZK+bfeZNbgwngs=;
 b=akLooh1SIYo+3LBikb1K8l1w3zmv++/Ub0VkGPzBGOnbaLzw/7rmerDXyOPccGibIS
 SbLtCH8M2dica5mzzp0MuEYUhiSs0dFuorx/DJDrMHChkW04YkgSb9RqqtOGjOLrhADF
 yrqj0YlhixNbO89Dt6AACVWN1Q6VoZy+bQjcez3dFdm6vg4JyWlob6m/izglfZS5G7Hw
 q9tB4hV+BEwtYP97/7axbUOlfBsFecmu6vqq6Lno2VKyXFvw7x2uGZdviJMHtHFwNVEW
 7cnhJMdEjm4c7fG/TImrg0WIbXqoSsRutmwyBJNfyrgeKnTkN6x7kgyZgCRb+pyMfHbx
 a58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795345898; x=1795950698;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sEv669DRC0AJQBXzHESGsO/jzMOrkZK+bfeZNbgwngs=;
 b=xxVduNBiAxBpns9afgtkPfgoj5q3Dlp0+HGLHpJ8BxxjTEZOqf2MNNHRg/peFnLHZA
 LX8ogEBXY1NwIoZ2Mc1/5+M1zjwqeEgY0x3zS2WU09WrVdGb0kyTF0ZRKB3656zI0J3Z
 m0nwLu0wD4vBtUoi0+awrddpEIiwrYmpWSP/PUVYWCbCNZag3DWx+w5bd0kQMYlGTmWT
 o7UUtcss6t/xmTEvinwa6UXBy9PtalIwbew/JBEauswGE5PNDILxZE6Eg+ZJpg0EuRt0
 tfRd6T4LABFnYVCevUhLxQEFABCBxDK9WaIUBZVnqKnyBDiZMhen+m86O92Zs/mSPk92
 m7eA==
X-Gm-Message-State: APuU4Z98BIGzTfgiRNdf+LVR6Ek6ooAr6hUAayrbBFizSPUNrmIjuDtp
 7zUojhjJCFDVtWbC0U9cHuhLcIljWBs6+yTx15Wck3XN4bR/ocYcmLV8uTMr4Nnimvem0CIcPEG
 bYAGPgdqVUqL9ab1wyegSOEi+fLop1T3OJM510iWy7fMGPRawCWkbzTz6zBPG545LeDV+
X-Gm-Gg: AZFdTZfmx0znPR4jzOVDtg/ciYjW7GzDO7xURAd+Ee2YWU7yNEfgqdZfgML38qR549x
 /Un76c0iVL5PBOy2HKnzdUhj3nBtJY1HuRF2gWIs2c1fZKn8B4VlnesB0krKjeJ3A5JIcdTZbXS
 /kvSPQDhocinbtkDFlCMAAACNQbf8ZCYFNtvdVOsnFwCUo9icV4prrxkmGEN3BsPvIhAKQ6WG5A
 f6o3HmAqinhzHHkCGH6w/YWRyXXBUUcigSi6HfRz6PaMDea0vmNJoXG6N8JMAzfw1KiuPeAiUYW
 ADTo0yAT8DFBiMCMhWzQAwLbYop5lwzy9ltKSC6Pxh4a31SjjnUDfRZN2ku9jMeiGigOG1MHwcg
 C/4RZOGFOMI0i7kUjm/eJuhFF3MKg6C5BZoTxymP+YtQ1TvI2vXrHMpZpWoICHgofT1xI9s1+w9
 xEWlWzYSxbEUcfJ3kOXN+atWUxXl+Nm7nIcjOenwuQaAtnvlN7atHroOnXW5TRZhJDywsAo09TH
 PgVU7MEiL5hOGB6a+zpMSlAmw9fn/bqNgga639fZNwU4Rwj7CdztQFuFM6+PAr2tFTxNjJwwjSh
 Hd7NlAKHhG9E21TWOLWd8cbv1T9G05ljwjsUqVm6cG7YUMTIpluqy6lCCj26HSd53mVL8YbuJ2a
 ZLCjxMdkypxrQH/wqzYVh1ajez+bwe1oUzGnphdoq3tXpfD8ALfiBMGb2DH7THIv0L6hWpe+tRL
 B8IrjBXRB7hu4bjQER1M0zZksj3apI21jkk9eS
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb8881ae90mr189187535e9.32.1795345897518; 
 Sun, 22 Nov 2026 03:11:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm306657245e9.11.2026.11.22.03.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:11:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:11:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
X-Gerrit-Change-Number: 2220
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2220?usp=email>
X-Gerrit-Commit: d8e22c5191904153e43d982327f5f0f2cfbe7d92
In-Reply-To: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDI0NjMwMDAwLkk5YTc4ZTU3Y2ZmODA1ZTE4OTZkNzlhMTdmYmNkNDEzMmM1YTRiMWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e66a6b15a3f7c564e1e185ab9692a2be2e9fc26-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5U0-000000005L1-1NII
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0689203932272985589=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0689203932272985589==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yyAoUJi5uP8="; charset=UTF-8

--yyAoUJi5uP8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2220?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: ssl: fix MSVC C4047 in ke=
y_method_2_read()
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
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/2220/2
=

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index e06659a=2E=2E=
d5ae13d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2409=
,7 +2409,7 @@
 
     free(multi->remote_ciphername);
     multi->remote_cip=
hername =3D options_string_extract_option(options, "cipher", NULL);
-    mu=
lti->remote_usescomp =3D strstr(options, ",comp-lzo,");
+    multi->remote_=
usescomp =3D (strstr(options, ",comp-lzo,") !=3D NULL);
 
     /* In OCC we=
 send '[null-cipher]' instead 'none' */
     if (multi->remote_ciphername &=
& strcmp(multi->remote_ciphername, "[null-cipher]") =3D=3D 0)

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbc=
d4132c5a4b1b3
Gerrit-Change-Number: 2220
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--yyAoUJi5uP8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2220?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
: fix MSVC C4047 in key_method_2_read()<br><br>Assigning strstr()&#39;s res=
ult to the bool remote_usescomp warns under<br>MSVC and fails the /WX build=
=2E Compare against NULL=2E<br><br>Change-Id: I9a78e57cff805e1896d79a17fbcd=
4132c5a4b1b3<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220<br>Message-Id: &lt;2026111921=
2622=2E5852-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41689=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/ssl=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
20/2220/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</s=
pan><br><span>index e06659a=2E=2Ed5ae13d 100644</span><br><span>--- a/src/o=
penvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@=
 -2409,7 +2409,7 @@</span><br><span> </span><br><span>     free(multi-&gt;r=
emote_ciphername);</span><br><span>     multi-&gt;remote_ciphername =3D opt=
ions_string_extract_option(options, &quot;cipher&quot;, NULL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    multi-&gt;remote_usescomp =3D =
strstr(options, &quot;,comp-lzo,&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    multi-&gt;remote_usescomp =3D (strstr(options, &qu=
ot;,comp-lzo,&quot;) !=3D NULL);</span><br><span> </span><br><span>     /* =
In OCC we send &#39;[null-cipher]&#39; instead &#39;none&#39; */</span><br>=
<span>     if (multi-&gt;remote_ciphername &amp;&amp; strcmp(multi-&gt;remo=
te_ciphername, &quot;[null-cipher]&quot;) =3D=3D 0)</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=
=3Demail">change 2220</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2220?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2220 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--yyAoUJi5uP8=--


--===============0689203932272985589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0689203932272985589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0689203932272985589==--

