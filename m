Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD2606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DQeTiRkn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jPPbdC65;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SlKPyLmI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Hf5H8VzM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aal0I3dzC6g/NAFgAGsrs5Etjww0Pu/MWphmgz1Moi8=; b=DQeTiRknWnmLvdaFqm2JNfb5K3
	b+Us7HadKE9rOCmLj42VGpGm8YE3VaO2lELmc5FCWa00/qlhqcJWVj+mMn+XnAZkIod1nROyekjk3
	ZOyLoARfmQrUlYvk8dokTsq2HV7WTeSRGBp89gBpKj088Squu0lEbQM07Y57YirMx6xA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV703-000000005j9-3zEi;
	Sun, 22 Nov 2026 12:48:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV703-000000005j3-0qOy
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U0+x/FdgMLd6Sxxru05/wUPsuRMISgm8v9MOupZDDz0=; b=jPPbdC65lwnY8VifFgE4xUqDkl
 6mNOhfz56TR371Q9TkAqd4ftKOksUe/O3/SyMSqDYP3zkfj8477mXn1BZ82der9uTdgHTRlE9SCz3
 KOPVjut/OZiSjG4PBCb+sNdvWBYeVHd3ttuoB0FvbZYsmcOsHtD6kUyu8k59XuKsnBZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U0+x/FdgMLd6Sxxru05/wUPsuRMISgm8v9MOupZDDz0=; b=SlKPyLmInLLdNEtdKrDWLsH87K
 mf8+09m9QPV+PCWGBvE7J0KoFYECg5Cjb6jHDOGchMGh4WNqaxov9CZAXq8iMqLnM5aUiZB++L29X
 2Y8DxAd249rSglcJYCBhQZe/VSFXrTyVO+AZep4bxDeaYR7t/1NxWDbHyPZxlzANJVM0=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV702-000000000pv-2XuZ for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:48:55 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so1916686f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795351728; x=1795956528; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U0+x/FdgMLd6Sxxru05/wUPsuRMISgm8v9MOupZDDz0=;
 b=Hf5H8VzMd8F1N4kx41A1y18Ahv9ewQuDlLtoTII5W87nwMQjQHrN3sC4gFtVIGtKgl
 EK3dgGGthutqfGndkDdNJ1oHytlKA2jg+rFZYFqA031JQGdCKllDb0KtaZF+b4r9I4j8
 9VKbKsZasVJEYPB+7weGVd6wz4Nnq2ERD64eUgUe4ysvDoyf/lRxRDOc2a6ynmNhYxaZ
 f/PmOTzcaWdxPxbVUnon9ujp5DmWAV+7Ew5pU8P8MELn/YOlWZ9Qm2MALjcoH78YeWOI
 lMKrVVmWiTAZ3mhwy6BiUJsmDhSw1OYlro7OMgkDIsPBclw6/tGDbYOxd3QQWSq+9So/
 8uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351728; x=1795956528;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U0+x/FdgMLd6Sxxru05/wUPsuRMISgm8v9MOupZDDz0=;
 b=dVi0KYxiLzk7aYXYI/bDKt7p5JwiJlOAqNjBeIs8UH3WPOOtAHZNsCChWa3GunyGtz
 3xyzdcFWVjxYog+mPB/zwBf+aI0jF1VamVVOfPj0WiA1ZnnWVRugaOGdu7tv6a4SWZw2
 hMLcddHNX/bnb1wM6hKvVLpjgC96LWF6pMUTC2B+Vm7nRaNrRV24XzCp7uvE6hCjMEgG
 WqJEt4e+iSyrUTbgrha/SPaM+9Ey0nHd+XJLhb49zbn6K9erskD1TpcwjLxEFyBUoqNX
 abskr7lYdt26IA+VJU43+Cn29NffA2EUu4/F/erdvDqq4Tcurr8H4WtV9vsiGvFNA06F
 yZLw==
X-Forwarded-Encrypted: i=1;
 AL+hErEIyI0jNgNn23sVH0fZJtyIPJ2Smyh08T6eeXJl2lLrIHSdYnslTH/9pgnFkz0r5G5v0Kq0ndK1bsQ21RGM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/krwKcIp6OjZbdim0N2ID7J4EjHrgyg0c/OPVzcEaPmgVenWfg
 WpcqYHGoKkWuPqKFjEXcrnRfUvDnHqE34wJUfC1hxPawE945RvQzO/soISit06/p6lPISRVA8cO
 ad3lw5BxWhwasgKjGdAI3cHzdGdGIw0aRwEWlOl/YA5KJ1Rfa2RDdNLwnSgce9OaxBsjq
X-Gm-Gg: AZFdTZdWAUfGOva9ee52tOqp1RWgmUuHN7QCtVfWbib+4OfqggrbpH/XwU7Z6Hsqah5
 24NYEEG1+EWincRVLj7O2JaznCuey4onmBOeEOjWVdJ4qxALXw0dqLAmR2ad2Zc9n0h2VKCtz7z
 k5kee7CFw13ZQxiAWMDKTp7UcgsFl6wu+rVD3rhuWAk8NAZN8xYDkF0oPaX33jAel4Y+l4zcEue
 mcbAfcvusoRYaBDGBNdzYrPaErZCMtGScE7q1SyWidXNwKIVnj9aWtceKRV4c2szjiPLcsdU7hY
 25Xy9Rq191BJxVI2zvvgLkjpLeiihpvMI2krplwywKeGhMBkuqxbmeM0OimPN1lQwqY3oZhYkJo
 QtRIDPNsCE3+C7hJbfpXQvU2JLFfV0vbXjww+IsVIdjHk0Q2vCIh7L+vrRpDRUvcBcx4RQCP84R
 lr9xWxRqJ2CLbS2g8n1Kair/t+flAltbEFouXa9XXizJ8cqz3l5OS571PhGN6po++V1tud6u9jX
 Z21ofFVj+HaK3ocFOijJwIyRYutSKeN8xDYzc7mzX7A+khTyWqaz2+7rqyluEmc7RyeMnqrkHSX
 d8U/YE4/POREBR8gCZXU2FFwm4neUkgjnnPbNDRa7C9/OUTRvA3cisYyNlCbnBgB9i9gch2KxB2
 CKtK78KXzAkALNfbiogxuNqfdM+ijjvFSpawoTK0WYFn5dP8xPCmPY6yqZst7A2D5jfzMbwnmbx
 vz/Q7Z5Pss3pLkiEZo
X-Received: by 2002:a05:6000:4b17:b0:48e:7508:bc20 with SMTP id
 ffacd0b85a97d-4abaa9769c4mr17987356f8f.2.1795351727905; 
 Sun, 22 Nov 2026 04:48:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680483sm16788817f8f.28.2026.11.22.04.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 04:48:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 12:48:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
X-Gerrit-Change-Number: 2228
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2228?usp=email>
X-Gerrit-Commit: 5115f203b3c06035b8bdc84f86d4b84b08d5cfc5
In-Reply-To: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
References: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc2MzY4MDAwLklmYzcyYjM2NzcwNTZkZDA4OWI4YzZjZmFlNGJkMDc5MTFiNmY4NDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cdd6ee8e609181de8e415295ace0536e41f1d74-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV702-000000000pv-2XuZ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: check
 permission for --route-ipv6-gateway
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
Content-Type: multipart/mixed; boundary="===============0275162660751954643=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0275162660751954643==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ox9D7T6SpGw="; charset=UTF-8

--Ox9D7T6SpGw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2228?usp=3Demail )

Change subject: options: check permission f=
or --route-ipv6-gateway
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

options: check permission for --route-ipv6-gateway

Unlike --rou=
te-gateway, the handler never called VERIFY_PERMISSION(),
so the option was=
 accepted in any context (<connection>, ccd, inline)
and was missing from o=
ption_types_found=2E Require OPT_P_ROUTE_EXTRAS,
as --route-gateway does=2E=


Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Em=
uc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228
Messag=
e-Id: <20261121145406=2E27273-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41759=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
options=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)




diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e51ece7=2E=2E20683=
93 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -5=
350,6 +5350,7 @@
     }
     else if (streq(p[0], "route-ipv6-gateway") && =
p[1] && !p[2])
     {
+        VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
     =
    if (ipv6_addr_safe(p[1]))
         {
             options->route_ipv6_d=
efault_gateway =3D p[1];

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2228?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
Gerrit-Change-Number: 2228
G=
errit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--Ox9D7T6SpGw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2228?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: check permission for --ro=
ute-ipv6-gateway<br><br>Unlike --route-gateway, the handler never called VE=
RIFY_PERMISSION(),<br>so the option was accepted in any context (&lt;connec=
tion&gt;, ccd, inline)<br>and was missing from option_types_found=2E Requir=
e OPT_P_ROUTE_EXTRAS,<br>as --route-gateway does=2E<br><br>Change-Id: Ifc72=
b3677056dd089b8c6cfae4bd07911b6f8407<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228<br=
>Message-Id: &lt;20261121145406=2E27273-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg41759=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 1 insertion(+),=
 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec</span><br><span>index e51ece7=2E=2E2068393 100644</spa=
n><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn=
/options=2Ec</span><br><span>@@ -5350,6 +5350,7 @@</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;route-ipv6-gateway&quot;) &a=
mp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE_EX=
TRAS);</span><br><span>         if (ipv6_addr_safe(p[1]))</span><br><span> =
        {</span><br><span>             options-&gt;route_ipv6_default_gatew=
ay =3D p[1];</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2228?usp=3Demail">change 2228</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc72b3677056dd089b8c6c=
fae4bd07911b6f8407 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2228 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--Ox9D7T6SpGw=--


--===============0275162660751954643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0275162660751954643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0275162660751954643==--

