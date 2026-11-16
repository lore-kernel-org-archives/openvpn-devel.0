Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C627606A332
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XeunHk0O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=l0hBc7N3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GIaIC88A;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SzZn4NHv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bdPSd6WGt55XQIxIsQM7tjcbt2DDzt5vDz5057gzJ2M=; b=XeunHk0OeX4JdK2memp5wyjqky
	tWVy+6fW23568X8m2mbTEahplFCDWnOQTd92a2dN6RcKx+MGuXY8osC6ullMsjG4N/AFA7vdF/5yd
	Kp0ZHviB0fUDf62ZhWyNgM1eNEf035TGG6so4LiRQ1gEfm9l/D/NPpo+2B41Fd3+7YAg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT2ES-000000003Bi-0d7S;
	Mon, 16 Nov 2026 19:19:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT2EQ-000000003Bb-1yrZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGvimTt9TlD4C1YjFI/BuUvaoX0rn3j85dtBnnPGVKw=; b=l0hBc7N3Einz6NuAu5EzImDaI4
 SU6WTsAhmdt19/AQo7em5GCoXWH4T70+sSiDtCFA64NMz9sN729LKeGkalVetBI5VyY02ku3TopVS
 +GwxQ/k/qSdz91ZpIcbZNzKifJLJIYx40uJCPiMykUm1nO1VW+HsAb3i++FnM561b0KY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGvimTt9TlD4C1YjFI/BuUvaoX0rn3j85dtBnnPGVKw=; b=GIaIC88AzvvvQeSqFgkgAcS7pV
 C/gq8oKLNCABoOujfWjztdxDbJZvrVi7pl8OdHnKHEzuyRJsqZSLNKMAefzGimE8f/a4uE8ypBpYL
 BBm5x1+Iy/G9l0kP8iRjXem8q0gpKhmGxPSwQRpRsDgYjDMyqWYM8ezzl24xbCJRgUvE=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT2EN-000000007P6-3Tz8 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:19:10 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so13681765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794856741; x=1795461541; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qGvimTt9TlD4C1YjFI/BuUvaoX0rn3j85dtBnnPGVKw=;
 b=SzZn4NHv/2b7jZeFLWpIE1EZIhB3JqQN1WCI5ZcW4yDatX1vK3I6LzKgHQZ1AWTnvr
 YxcR2y5ttfJ2A3B5ymLY1ZHz2S/p0P+Nz2NXha6zH1QQg+XspyVyyHivQNAOykZ1kPFR
 KDvpzM3/TCL5f2qNITRAG8qML8jKbxlXMVkz/06uMfZkIuF32LFWYVm4twlpz55Ld++F
 vKqBvKdi8OtAC/9AXv8b7/shXlXTBYn0pMnG59cZh+/aFEyKPDadnrIvZYfmx/5O2Ty+
 0m0xkUYw9po921OmDVOTbkwuJg/MpFkmqXAjrQActCNejMNX5CIMqVOBsU7qwp+vGM/j
 FBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794856741; x=1795461541;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qGvimTt9TlD4C1YjFI/BuUvaoX0rn3j85dtBnnPGVKw=;
 b=LsoAffgP+LDzzx5IdP4frLnE9mkxE/dLXT6y9dfF62/9w6RhoFSOsYFo/HzoChmQ29
 QbXN5B8rB241UrTCXU2J/BSYQ90ZmeVclQnNaWFLnfRDqyrofBxxGxlHhacN/Rb86QM4
 D6kJS8XNfCQtbDYNAJVLvQLnn7YuCWaTgnRYVaJrIYzd+bNcfGBV3FdC7B+9+MP4GwK2
 EtN+1SKeOXSMy8uCt6cBdoA2MMuQXPZdF7miukZcb18n0ZlSDcoWRRMXqUVvwInoJmqv
 xj1EV00wMkXON+VKreZokMeAYXGxZMrs2NUTwcC9S3/9L1ct4q8NxyH9y7gwSALUjbeB
 rsyw==
X-Gm-Message-State: APuU4Z8P++eri7Bau1TMkd/c0KajUBdDujM9A21b55pp1CQRlOfa9Myk
 /I7uGyPlc+4TuP0BI8TJ7pwcuO/bH1Ofevkh6Gh87JbP4qvjRg+McEBfz7EtrHUcEX5JwNNV1lW
 5PfiwJUnUtvVJWQSL3NdmOYdJjR2B0aBUnlR35MLuMUEFL8wplC00mjJXjmx7x+rthKou
X-Gm-Gg: AYBFou15M3vXCcPM8WCB6N1154T6qscTfPfRQ6jczE0i75fyUTnxOsqo50U/L9yGwF/
 73lN6dHmLP/47n5ZWyYJJ31ZBMB6Tn3/SOeAmeWwWKP5ghsAbWJU1eEdJTXJpi8uzHdZbpCXHTp
 qQgCwih9iAsfPC57DDTnsRK+ZnHR4wTL7n2T/7MRQKGS6OmsgrfSnvyNruAu6LdsP6WJJR/z9Uk
 JBGk9Vc4lcqhpsNEA5faQu85Gginj/sZyqXa8tkufA79ncudpIYyvKuIcVNuPO8X5mfh8Y+PmW2
 N/4iIqf0viqdh4X3/68t+6DOMg///6CmPARxJsNJFsyyv6PXFZQZrCYuoUqwv2tSWqZ0/O2MN+3
 TvaPpfE9gFUJFVKHs2IuOI4JwJezL82Iin7Xnl4hg2JV4FVbgyZs+BzN20N985axdCJz3LqVeOS
 sENUSeQrrcaNP3t4TpeARHi+WICCQYUIv99pQELJIIeu52HhbgAon20tFZbHps87Uy7e482Qs72
 nI3bJ6oQct6qJuPUrv3AAajo3kL8ZVZHUB2FWcuuj+VvrJeCqwpGr9pppm2eY4OnASf0vlfZA9m
 P3KUiUGnuLuUvyl2cTphvpREmOoBO964yuj7RXrU1wWIwrn60C0keKpzRkGyO7OWyAUoGgS8oOu
 Sks4WKISS/HZed3I5xnZKzySGZhUvSs92btqcmbXGm7LyCKxKrGviaKDbEKzDrEZKNoiN8JmOWJ
 4PLKRurTIfbAjvns0=
X-Received: by 2002:a05:600c:3114:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb55a5de41mr244114005e9.21.1794856740989; 
 Mon, 16 Nov 2026 11:19:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f7eecsm17418115e9.3.2026.11.16.11.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 11:19:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 19:18:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44
X-Gerrit-Change-Number: 2192
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2192?usp=email>
X-Gerrit-Commit: 8e294f40da919fde860ebb545ea215c49108ea15
In-Reply-To: <gerrit.1794832614000.Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44@gerrit.openvpn.net>
References: <gerrit.1794832614000.Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyNjE0MDAwLkljM2UxM2U0MTRiM2M2NGNkYWZiNTdkY2ZlOWQzOTYxNTlmOGY1ZjQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd924f02fad66fc7ee1fe9f9b5014ae8845f17c6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT2EN-000000007P6-3Tz8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socks: convert
 service port to host byte order
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
Content-Type: multipart/mixed; boundary="===============7281039917534000494=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7281039917534000494==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f3NHWsAd7Gk="; charset=UTF-8

--f3NHWsAd7Gk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2192?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: socks: convert service port to host byte order
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socks: convert s=
ervice port to host byte order

getservbyname() returns s_port in network b=
yte order, but the caller
splits the port as a host-order value=2E On littl=
e-endian hosts a remote
port given as a service name (e=2Eg=2E "https") was=
 sent byte-swapped in the
SOCKS5 CONNECT request=2E

To test, connect with =
"--remote foobar https --socks-proxy <host> <port>"
and check the port the =
SOCKS proxy is asked to connect to: 443 with the
fix, 47873 (0xbb01) withou=
t it=2E

Change-Id: Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44
Signed-off-by=
: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/socks=2Ec
1 fil=
e changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/92/2192/2

diff --git a/src/openvpn/sock=
s=2Ec b/src/openvpn/socks=2Ec
index 51e3a1e=2E=2E5cd6d8b 100644
--- a/src/o=
penvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -332,7 +332,7 @@
     const=
 struct servent *service =3D getservbyname(servname, NULL);
     if (servic=
e)
     {
-        return service->s_port;
+        return ntohs((uint16_t)=
service->s_port);
     }
 
     return 0;

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2192?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f44
Gerrit=
-Change-Number: 2192
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--f3NHWsAd7Gk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2192?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">socks: convert service port to host byte order<br><br>getservbyna=
me() returns s_port in network byte order, but the caller<br>splits the por=
t as a host-order value=2E On little-endian hosts a remote<br>port given as=
 a service name (e=2Eg=2E &quot;https&quot;) was sent byte-swapped in the<b=
r>SOCKS5 CONNECT request=2E<br><br>To test, connect with &quot;--remote foo=
bar https --socks-proxy &lt;host&gt; &lt;port&gt;&quot;<br>and check the po=
rt the SOCKS proxy is asked to connect to: 443 with the<br>fix, 47873 (0xbb=
01) without it=2E<br><br>Change-Id: Ic3e13e414b3c64cdafb57dcfe9d396159f8f5f=
44<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<b=
r>M src/openvpn/socks=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/92/2192/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socks=2Ec b/src=
/openvpn/socks=2Ec</span><br><span>index 51e3a1e=2E=2E5cd6d8b 100644</span>=
<br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/soc=
ks=2Ec</span><br><span>@@ -332,7 +332,7 @@</span><br><span>     const struc=
t servent *service =3D getservbyname(servname, NULL);</span><br><span>     =
if (service)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return service-&gt;s_port;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return ntohs((uint16_t)service-&gt;s_p=
ort);</span><br><span>     }</span><br><span> </span><br><span>     return =
0;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2192?usp=3Demail">change 2192</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2192?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Ic3e13e414b3c64cdafb57dcfe9d3=
96159f8f5f44 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2192=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--f3NHWsAd7Gk=--


--===============7281039917534000494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7281039917534000494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7281039917534000494==--

