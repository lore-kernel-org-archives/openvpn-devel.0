Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E23606B716
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aGn+oe/1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mxDzRZpV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cQK1HZpX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FTw/leN0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=PDE58xrXy4QdJ99zaBQWAHtjVp5tsQ4+Ylpxp/wErJE=; b=aGn+oe/1Engff7Nu2WdSsylzvm
	3jqaYjQygyxOSvguAFBIc8RzZCbcspanPRqNZgsoU9bqlwUv9nbYWhGDY8BnB5Bz2BO54fhkUWFeT
	hddjv6s6+D+Hty1PFpe+MWfisFrhLZdf04dvyHXvrEt3IOrl14ox8ELtSpc3uLGxd0mU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUVTS-000000002TI-1ZFe;
	Fri, 20 Nov 2026 20:44:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUVTQ-000000002T9-247d
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Wu92tVweehPSCyn8YxCV+FNbk5J8UyMjrwjQI/rmOA=; b=mxDzRZpVk5YbPlL9LXPKfKSPD3
 uRZenAStd2Eje6QkFF904VPONvj2/L5yZ4hj1P7V5BdctmcKFuiljOdPlr4+361SluE3w6vakS1Xu
 y6TjR0cthKVGBbaxTB5DA/cQwJVRPUmHqW97AdyPSAF3z6VaO8P0UkxFF+qu4VQlqOiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Wu92tVweehPSCyn8YxCV+FNbk5J8UyMjrwjQI/rmOA=; b=cQK1HZpX/dDs4k1ktcX7s0MzQm
 slrKxvKyBhFqXiCLk51FXrW78dPURmhvKmRSK+qtVGee6suL6VY5gFRceK0zZS7v9KdFs94yxOadK
 ce2uJdVY+ONBSb/8PhMBw8wD7KAbbO9sE1r78HLLCBPkRDbO9wS8xPo0VPE2cessNEvM=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUVTP-000000001dm-2xkW for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:44:44 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1203693f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 12:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795207477; x=1795812277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4Wu92tVweehPSCyn8YxCV+FNbk5J8UyMjrwjQI/rmOA=;
 b=FTw/leN0kaRgJewRMFR82WFu5lSYLrK6a/Mirc0QXNJzm/gJUyMnV0l7/uULqKmcoj
 qwh/tx9lotCwyjqPCAaBAK8EdNjrPhCJP8q7tQGz5wRDnSMD3y2DirzAtDXxPf1JVHqJ
 nPv7HuefKSBBNOUZnDdY93+EH8HOh0+DJqe27n4oGUytG/Z/K0WEUBmPiocm1zwZ/SG0
 K4EihHih0KsJOpQNykC6E7D8NnV9FkRhCmbc8yM+8bw//NQIEwju4WVq8lwz/9KEvq/e
 x7Y4ohPGUeBwVX1Pndn2hsY3z6GKE8L9iohRUGNi+IucpLzccrWy//xGdcsA67spanod
 GDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795207477; x=1795812277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Wu92tVweehPSCyn8YxCV+FNbk5J8UyMjrwjQI/rmOA=;
 b=uUSNdj6HzR8/QUV7jbbSZoePejO8Uzo0tCZ8yEEGfkgpNJSWohLc0SxrohY/pO38PV
 3Dh44CQOn9aKbjI5ZtywfJ0tLhcugmgac2MDYZVIjrNl3E9eZ3N1MvxYrTsx3ziTFB8y
 +tsVBI4rjmtNsAhBaucH1tpvAyJY2rOW6xIrU6AoBETu69Dfrr+G3IH+PMEzUx07/MgD
 v7LWWfbevfbA6EpeCsNwUsvJ5kue7PzdMwHhi5h3V9VwhMHSLlxrTHrZXbWeseJCw7+D
 eWpcRTZ6LJaqoAEKlJqdZJcU/K3LJgE7h1joKUEFMyDm39Gro8Y7aJWWdz4TO8qXJCxM
 KxrQ==
X-Gm-Message-State: APuU4Z89xgI0OORnWaq3tVH4zpsu7ETHWf5BhWPLCwX1oIh9U7wBCjed
 TIMD01pTaFoAxewEjZww0+x/hTZphSEPh0HvCxqXb4ORVpCMlf/FbhX4Y+/IEYpcLlNqb/C5Zhj
 5IVKyIu3tvOaZT09a2MnNgSsa7lto/ArH8Eh3/pq7ruoBuban/k2MO7u/x8g/eGJAOBDwIriSBk
 jCS3SQHQ==
X-Gm-Gg: AZFdTZfgeRbfnWtn0ydcARCmLGZ5L64xX5C4A6ynuFE0CvtNNKpwlW4TCjkWXqhVMCe
 OGXJvgnERdzW8K9aVmI7rsD89RiaQ+/qIv83dU7O+ZqlPk7Zws4wcmLDUkb9znFR7wpFmcyVmKx
 z7h/LSGkltTHfNIyvO6pxFHpZtv+hWl93E7mrjEyBjlzPVobdneG/EnGCqN5z9s+X0yexuXRS5w
 nFnqynW9+osRiyKeIeGpSOa6T/5vhOuqY2F44qvrVGoJe+KkRYqrEhwTVIHd483DivFqjR9NbXn
 VZlAxTYBLHmwAd5mPa3PiYeqi+KHdUKYMAYNFwTlFP1xDTZp5k6lJYXu/QvkNEHJNO7ibbLFD/S
 RME/JLqz+RbeVotnV0dj6lxCCczu2O8YTDUq4FEv3AN0SsEgrTndjLWdIrdY8kJ8XGTFqnH9mSk
 rY/QbtBxJMDurp2zqoBPrZx+PgsWeOr/iDWDSa9EU7wUPH9SWq+z5bgeihBpObNg/mY7mUTIy5W
 pcqW30KWEUam5AC2fYQUNQS+gR3lFVnLtnswZd8LDplYKh4vpL+2SfvV03f0u3tLINyErGDMLmI
 AzqoMZql8tKyNLNDu5HfC0tp1eTMHObahOd5X5nwTiPEkx+gCRdywwLasRkM6cMf3/wUv0seOtQ
 IorRmzBZB9W0Sq0KQ0dNmUJWu468xgFUqI0SQhSFhTBX++iPMh5Bpq0oXeYuGznrt5a1SmPPsDd
 x6eB/uydNw1lirJUNO
X-Received: by 2002:a05:6000:4303:b0:492:46e:d4ce with SMTP id
 ffacd0b85a97d-4abb2168e19mr7767924f8f.13.1795207477064; 
 Fri, 20 Nov 2026 12:44:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm6883819f8f.23.2026.11.20.12.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:44:36 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 20:44:36 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
X-Gerrit-Change-Number: 2234
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2234?usp=email>
X-Gerrit-Commit: 3679c6993d79e1edab6ac9f8065a91b94dd06dfc
References: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLkkxZDM2OTk2MjE4YzNjNjFmMWYxNmUyYzk3ZjkyMmFmYTY2ZGY2YjY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <958cecc1937c2b5f97f0169ac240511504eb76b1-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUVTP-000000001dm-2xkW
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 reading DHCPv6 name servers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3349567749990621975=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3349567749990621975==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LwD6+Euc1Jg="; charset=UTF-8

--LwD6+Euc1Jg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2234?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: fix reading DHCPv6 name servers
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: fix reading =
DHCPv6 name servers

GetItfDnsServersV6() treated a successful inet_ntop() =
as failure and
returned ERROR_MORE_DATA after converting the first address=
=2E So DHCPv6
name servers of an interface were never used for the NRPT exc=
lude
rules=2E

Fix the check=2E As the loop now gets to further addresses, =
also make
sure there is room for more than the terminating zero before a
se=
parator is added=2E

Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
S=
igned-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnse=
rv/interactive=2Ec
1 file changed, 6 insertions(+), 1 deletion(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/2234/1

dif=
f --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec=

index 24705a9=2E=2E32b1688 100644
--- a/src/openvpnserv/interactive=2Ec
++=
+ b/src/openvpnserv/interactive=2Ec
@@ -2256,7 +2256,12 @@
         {
     =
        if (i !=3D 0)
             {
-                /* Add separator */
+=
                /* Add separator, if there is room for more than the termin=
ator */
+                if (s < 2)
+                {
+                   =
 *size =3D 0;
+                    return ERROR_MORE_DATA;
+               =
 }
                 *pos++ =3D ',';
                 s--;
             }

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d36996218c3c61f=
1f16e2c97f922afa66df6b66
Gerrit-Change-Number: 2234
Gerrit-PatchSet: 1
Gerr=
it-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>

--LwD6+Euc1Jg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: fix reading DHCPv6 name servers<br><br>GetItfDnsServ=
ersV6() treated a successful inet_ntop() as failure and<br>returned ERROR_M=
ORE_DATA after converting the first address=2E So DHCPv6<br>name servers of=
 an interface were never used for the NRPT exclude<br>rules=2E<br><br>Fix t=
he check=2E As the loop now gets to further addresses, also make<br>sure th=
ere is room for more than the terminating zero before a<br>separator is add=
ed=2E<br><br>Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66<br>Signed=
-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/op=
envpnserv/interactive=2Ec<br>1 file changed, 6 insertions(+), 1 deletion(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/34/2234/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactiv=
e=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 24705a9=2E=2E=
32b1688 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span>=
<br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2256,7 =
+2256,12 @@</span><br><span>         {</span><br><span>             if (i !=
=3D 0)</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                /* Add separator */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* Add separator, if ther=
e is room for more than the terminator */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                if (s &lt; 2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    *size =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    return E=
RROR_MORE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            }</span><br><span>                 *pos++ =3D &#39;,&#39;;</spa=
n><br><span>                 s--;</span><br><span>             }</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2234?usp=3Demail">change 2234</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2234?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2234 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--LwD6+Euc1Jg=--


--===============3349567749990621975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3349567749990621975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3349567749990621975==--

