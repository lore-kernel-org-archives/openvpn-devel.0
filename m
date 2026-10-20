Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5038606A338
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FSKboH8V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fKZX4xIl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sqy1uwek;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HR1WYdr0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HgzdmQW3y3tiu2OjJlPEEaB8i59OfkrWsDjvYC+xIKg=; b=FSKboH8VrppMxIwD5/sDjQ5+Og
	yZ04Jt7pnVBAdpWWb9omsO5O/cNPI1/E2dvNra/ltV6fZcfI6XoKinDsqXqOSn6LRYAifa9ayufCS
	Om4/w6Sbb+/SsIiHNDiNV770FqQtSu7K+UUvtJCMvytNbeNobImWWBJvu1Zgf5Tl0rZE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ5Ao-0002JA-KO;
	Tue, 20 Oct 2026 08:26:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ5Ab-0002II-IL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 08:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1a6AzCTa1NDCkVDRh8ZIf9zpcDht0bvqXXOx+gtWwp0=; b=fKZX4xIldYjiUH2NTOjOoI7Rcl
 Z33/LkFq6XaOHBCaaV0ioobGavrneJCvV72r5SxODwbZJnIXQho37PwfMl4m5aq4isq9vhkCWTakm
 bnqC7YP+spCTMFZT5O112vZAmLBX49DS5WQM1FG8abI+BL0jBrfLHta63Z+HhpNpVe3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1a6AzCTa1NDCkVDRh8ZIf9zpcDht0bvqXXOx+gtWwp0=; b=S
 qy1uwek6yTIyP6E7i/FObwFaDIeubheLM/WPaaHVe20Miq2d43Aelx3t0zR3H8tYh8fcVIRk+DJ95
 ZSj8imYBlD7MpOGyEYFWmd0JBXtALkco5j69bda/ZuPQ6EGsSQE8BUijeWCRrm9OGLZbYDUWN+f6N
 1dYt/HzlnI87Ygaw=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ5AS-0004Sg-PT for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 08:25:59 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so2465088f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792484750; x=1793089550; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1a6AzCTa1NDCkVDRh8ZIf9zpcDht0bvqXXOx+gtWwp0=;
 b=HR1WYdr0jsCHpSH9uz1qCgeeAezYk6vqD0Hu1P91liSgRUr5W5pICJF6LDSnL+17bB
 PHIm7IUuVOgesX9LVruxk4F4y6ZZpwmmix6yQbXsbcLRIauUR/ju+Vp7pcCQMP1Qktxa
 WOn7YnR8Sp/gA/JV4T1SR5CqR0SDy/0cs3UB3UKm41TaenVleltsMAjA7IR7cZClvE9O
 L1pEBsawqqry0s64Mxfh4sBGeFBDQniqr/ZQeIovkKp/E3847YjLVjHNvFyj0yDKtyYC
 2Cd56vETI+XrhlT01Z+1HkPvVPgjRvDP9IJVOT6MEZv/1jn78rYMdEDH5jlZZxgeYjzI
 dEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792484750; x=1793089550;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1a6AzCTa1NDCkVDRh8ZIf9zpcDht0bvqXXOx+gtWwp0=;
 b=XVwHAUB+trNkdXrkJ12myr5Ea97yZ8UWOwJNFMhoBMy3OrNejSiW7KojY3MszyS45A
 fTfUkJfL2/0opDqyEJ1cDz236sv+IdReYUXPvuOyrWIJHoiYR5nJk+ThlUF+ixnW5rvr
 gpZu9PyxvBurwxRpfUaMPxifWAl6no5l0ftCZgB/LtM1Y9IWW+miRGRZb9iRr2LgSATl
 1SgaUJKKgr3EvYCz0ETH/K/myi9YExS6N530Djl1HMElbnMMXpKgN9z4/BG4haoKnM+w
 EtakOWYrIQtZMAoie9ACsLIaQz/FzRfluzuRs/mWJNUv2FO2ccYjuNT+bVOvEGKiquTM
 BP8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDvA5ZxsgZrTF4rSK3pxT8hQgR8vAQVxwgP8atVLovzfErELasMaLzTexyWWEPjsb+aBZ0p2QMpV1IRKJm@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI41CSMgkr++N0ojkWx1JNzSKI/ywyDikm57hxfCAD1l2p7Ou1Y
 vvNiGBBqOg4QDB4KAfQZtgmeNswZYI/vNC7AQCCEnzmXvxmfRgfOZWXANpHCKHoBH4Bf0312Nsj
 3s286KP9mdd0OQTR1rph6ynqV+L0b9SFexIOSzn02MM0FCh+BuPWGT9KwAeQnjdZIcn+fIT/Vd7
 v5wsEWww==
X-Gm-Gg: AYBFou1RzmRulHzrJ1L7O0Kh/u9NA8bDLc2A6jMzCtUMbr6gJD+IZ7elwMjY/DcO7QB
 F7bc+N+DKv+FtrreZCwILijPbuOvNzf49EMGB1ovK5uTYsFf4YKy3cmn/4MyaE0aFxEer1UDb0V
 9KFfUM9BL821I3qpqgZXkcsdf0QEoZLUkcc1pEA8MLNesUeaAWrICFP9K+1QYFvrOVyEjgZrlq1
 OAqBCNCDY6vexC/BMj605OIAdRUETzu0jCxmbeZR3KpgtfJvFO0/ijmcr1kRKE1BTWxcxDzKg8+
 OcGPBZ0pBVJw7p5uowj9+WJpxsJypd7cSZEpewXBnjkZCErm1jYppCuhDqUocIaahKXqVEjTpYS
 jETwhDasS0ha1MPW197L5wHiCOJxQVrzo6y/wa4Bzl2DINrKOdM2jDpXqmELKIHIhJPQlIcNSAd
 svqbXoJxjOZbt12b65D0bkzU2AMJrWLg8vtYadSaKAkrasN8cmEUM4szGEypQ30m+RUza3ZBtn2
 IVB4iEikKfvkIcLeOZ36divLzi6XWXHRvOThr5TDc/pee078+CG6CXqygXdHJ5S1Lh+BbItqxLJ
 hAhwezQ6OsqNE5GgeCowBsyyj2NYh71C5kZ4gT/PyUDrzmDYlirAD9us3ZXJ
X-Received: by 2002:a05:6000:2002:b0:48d:fbe1:bb17 with SMTP id
 ffacd0b85a97d-48e07fa2f53mr20713061f8f.41.1792484750042; 
 Tue, 20 Oct 2026 01:25:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d838dd6sm4624455f8f.58.2026.10.20.01.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 01:25:49 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 08:25:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: e295fbc0d354939b403c33302da6c9ee8c74b653
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4bda0ab73aa918c7f875351d5da24d81231d3880-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ5AS-0004Sg-PT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
Content-Type: multipart/mixed; boundary="===============4893930879782829234=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4893930879782829234==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UgXtlIu5dXc="; charset=UTF-8

--UgXtlIu5dXc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919?usp=3Demail )

Change subject: Document notify as auth pen=
ding method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

D=
ocument notify as auth pending method

This allows a server to signal a pen=
ding authentication that does
not require any action from the user or clien=
t but can still take
a while to complete and enter the auth pending state=
=2E

Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919
Message=
-Id: <20260922160913=2E20905-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39421=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/management-=
notes=2Etxt
1 file changed, 30 insertions(+), 0 deletions(-)




diff --git=
 a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 412b79b=2E=
=2Ea28a1a8 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-not=
es=2Etxt
@@ -794,6 +794,36 @@
 The client should return the response to the=
 crtext challenge
 using the cr-response command=2E
 
+notify
+=3D=3D=3D=3D=
=3D=3D
+This is notification that there might be some activity that potenti=
ally takes
+a while to finish is happening beyond the control of the client=
=2E This might be
+a server side check or an out-of-band authentication lik=
e requiring to have
+to authorise the connection on a mobile phone app=2E B=
eyond the control of
+the client is here meant in the strict sense of OpenV=
PN client program=2E
+This message still might prompt the user to look at t=
heir phone for example=2E
+
+The syntax of {EXTRA} for notify is:
+
+    NO=
TIFY:<flags>:<notify_message>
+
+<flags>: a series of optional, comma-separ=
ated flags=2E No flags have
+been defined yet=2E
+
+<notify_message>: The m=
essage to show the user to inform them about the
+ongoing authentication
+
=
+An example for a notify EXTRA of a server that does some checks against
+w=
ell known list of blacklists could be
+
+    NOTIFY::Please wait while your=
 IP is checked against multiple online abuse databases=2E
+
+to inform the =
user that there is a delay in the connection attempt=2E
+
+Since the notify=
 pending auth is not requiring any action on the client side
+that is requi=
red to continue the connection (unlike MFA or opening a browser)
+this mess=
age is not negotiated but can just be sent as a gratuitous message=2E
+
 CO=
MMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 --------------------------=
---------------------
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I6217c0541bff81eefa63a987db8904b2feda2546
Gerrit-Change-Number: 1919
Ge=
rrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--UgXtlIu5dXc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Document notify as auth pending me=
thod<br><br>This allows a server to signal a pending authentication that do=
es<br>not require any action from the user or client but can still take<br>=
a while to complete and enter the auth pending state=2E<br><br>Change-Id: I=
6217c0541bff81eefa63a987db8904b2feda2546<br>Signed-off-by: Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919<br>M=
essage-Id: &lt;20260922160913=2E20905-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg39421=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M doc/management-notes=2Etxt<br>1 file changed, 30 insertions(=
+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt=
 b/doc/management-notes=2Etxt</span><br><span>index 412b79b=2E=2Ea28a1a8 10=
0644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b=
/doc/management-notes=2Etxt</span><br><span>@@ -794,6 +794,36 @@</span><br>=
<span> The client should return the response to the crtext challenge</span>=
<br><span> using the cr-response command=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+notify</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+This is notification that there might be some a=
ctivity that potentially takes</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+a while to finish is happening beyond the control of the client=
=2E This might be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a =
server side check or an out-of-band authentication like requiring to have</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+to authorise the conn=
ection on a mobile phone app=2E Beyond the control of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the client is here meant in the strict se=
nse of OpenVPN client program=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+This message still might prompt the user to look at their phon=
e for example=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+The syntax of {EXTRA} =
for notify is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY:&lt;flags&gt;=
:&lt;notify_message&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;flags&gt;: =
a series of optional, comma-separated flags=2E No flags have</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+been defined yet=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+&lt;notify_message&gt;: The message to show the user =
to inform them about the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ongoing authentication</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+An example =
for a notify EXTRA of a server that does some checks against</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+well known list of blacklists coul=
d be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY::Please wait while your=
 IP is checked against multiple online abuse databases=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+to inform the user that there is a delay in the connecti=
on attempt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Since the notify pending =
auth is not requiring any action on the client side</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+that is required to continue the connecti=
on (unlike MFA or opening a browser)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+this message is not negotiated but can just be sent as a g=
ratuitous message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span>=
<br><span> -----------------------------------------------</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/191=
9?usp=3Demail">change 1919</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1919 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--UgXtlIu5dXc=--


--===============4893930879782829234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4893930879782829234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4893930879782829234==--

