Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E71C98302
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vHuoKrPgitjcnYZqOj5QBTZxSAU7RTaJukI9M+hZnB8=; b=kNnpFxOW0PGOrceoOWFxNsclgo
	DpufoFU5OUqLod/59Y+mpTYu8pv8Ext6qG88809/ApookDI9n6cn+m+UX5E/nbAaFdsh/oWtHqIEe
	JhIH8r2NDwANPKW1tJkA6I46evj+FyaoIChRIKcXKK+jaC5EeBH9+/ddn+0I2s8VF1/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91tK-0002mH-9g;
	Tue, 22 Sep 2026 14:54:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x91tD-0002lc-Om
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B2UdvIXXnpXtVtUNssKE9P6SjE5UKQQiyMdXfKY2Wo4=; b=RwLNvy4ngkCLX6Ks7PYi4XWhcW
 PeDac4vRCKMLje2oXKRXFOGhFvg23/E6ruvK2vr8EYnl4mseI4F5hrZM88A2xbdAIN7h3TOa08MkF
 q9XukLK2OTjdnGcclhY0rViUcEEM19uTgoHAwHeAEwyzL2DLFjSS1cvnUxaVBdEZkopg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B2UdvIXXnpXtVtUNssKE9P6SjE5UKQQiyMdXfKY2Wo4=; b=g
 Udsl/zm1ixLf4SG941ZYkY5C4cBUfNuvm6m6OrjTHhFcKL6WMIPHDiIkIzNXtUXvGCXn/gyr7762P
 +zH6nZoEut6EldC7v2GJkAWU2kIYpa8HRDNrT61w6lZRr4X6IfpMvNjhVPurmBlT8wtFdZqgYQrW0
 yWquSOdKijHms8Gg=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91tC-0003BT-1o for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:54:34 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so27564f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790088867; x=1790693667; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B2UdvIXXnpXtVtUNssKE9P6SjE5UKQQiyMdXfKY2Wo4=;
 b=DVbRXKnSHc4DfjtzGDLorokW2vqFnuWWpukxyuAHT0PBEDF1Js8dE56mXnbuE3h/Pb
 F0AiZ9Q0Xcm5H1ysW8j7a2x5Qf86k7v1VkzFvDtSFtZsLeEbBr3BJlKpxOOMDgeqV6Qy
 G76ozREdcZtGx39GqAQb4h2b1FyNWFqt+NO4TcSlYL5SGHCIDj/tl3uq2UBl3SpaxNrb
 4giHb1p6Yz9P7EmlshBK+RLxKQBYWhQ+7sjk7U5SfQEw6SOQNkTq0fz1aVEkEcSx+l67
 1uujPF/GqHePrKuMXe1WlEOkj+dIB8ywvgEd0jsf/RxU0jHPRhNSUK9UqYl0GIYWUtPR
 XgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790088867; x=1790693667;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B2UdvIXXnpXtVtUNssKE9P6SjE5UKQQiyMdXfKY2Wo4=;
 b=T1ru8gumlgb4ybPI6YuW6OTQYUtJVcXu26dpy+ZeXfE4erk/8A8EFRAhdX4bARokiD
 N55iCjLvvrgmixMhkdmoCHue/gR3a+SEWuMDSHuUwtXOsNA1pJurw5gS1OAfeD0PzbV/
 Uvft5v1WiEQ8ek4xM6JORNVUb/a9A7oMg6A1GnchL/FfBkdalkAZ2DaKAbu9N62O3pEP
 XOFpyHEeQQul0AAoIx1/BEWsIVzTpuDJ1swY7S2OU/Rc+zUnhRbJnfGJZ9qcT/XUlFBo
 2xjDlXG8Q3S79ipx69XHDsiEW1YBCgLfNWV4gCaNz1dBkMJ7EVLDPCfazKQ6hbhO8aLg
 K+CQ==
X-Gm-Message-State: AFuF++npXXrw81D1LIlzZ5BGroVuUmMJePzI8ebcc4czFQLr7be43ElX
 EXexCsMwtsywlXtzLePuIfQ3jhfiv0nz2V6kxyOh2vAsrSsk2B99RXqR9VFluhSu8v8qHTGbEcT
 qNXglqNW18XroepUvhO20lrtHsx03F+T3fHMSZbJ+P+I07IG0mhaf7dGZoVfVeISAf4brcon4tk
 yNkCgFFQ==
X-Gm-Gg: AYBFou2+yTAq/+uVesxBmJr170g+cQ1leJ8IM/AKy+j4zOkAUCb1Io+FUEPa7hJ+9M1
 m5/RH5nvmk1NbBnj8GqfOE3GOr9poBp4o3o+rX4vvf0ONe5OGQyskBgUuN/gm29S5vH/o05ned7
 muSvHsGXMFoaldcdZvCNqJknNG3cke5zvFRYnZYaGd+v3rFh0h4/QDiRCOgDrFuk7qiyuf1ZuND
 JxTQCQHy7uERCLeEcEaIp/yDpqY6ybvfXF+KiTnIiXSh//nAZ9wkHtgg/nfEXT/m+jJYZdB9NCn
 Re10+pMMiMpA49zomTLMWNJCSGlBWhmFEJaIPAJlIosuotT/fjU6WC3Ml2dB73rW4H+BavtvSVY
 U5LWyTupl4FWHXK1Iy+XKG9uzhmVs1qvxEw0GXtJuo5z+Ysu9wst4e9fo6PJF8rvze+2JQFFJg1
 kSkfiLmy6W5ModTx9c8/rh+TsUg5TKTLCkAm2dcsMlAikifoM5H3wuRY7nFqiEjI2M+9+CJgbcQ
 XJg+YhURAlBPi2rvA7KMSakAmY9qjt1RjfGbzC3iFzwNY+W2qQ0fRy72cCFIiZabgxxCoUN+j5L
 o2YVRyPHVClEQohE/N0JbcU4pGbehcIfBqpOGBiqmulTjg7PMyuz33X3Y/Ot9g==
X-Received: by 2002:a05:6000:4203:b0:487:279d:3b4b with SMTP id
 ffacd0b85a97d-487279d3d21mr17557993f8f.53.1790088867288; 
 Tue, 22 Sep 2026 07:54:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862731bf9sm5673890f8f.1.2026.09.22.07.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:54:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 14:54:25 +0000
To: razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: 12c2603caaec7f4b6d7f4aca60c1177714d2b300
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2468ae60f4a6ce61949d5e695e05a61a6bd8ab65-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x91tC-0003BT-1o
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1195539410485622644=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1195539410485622644==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i5+qur1XYrk="; charset=UTF-8

--i5+qur1XYrk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello razvanc, 

I'd li=
ke you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: Document notify as auth pending method
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Document notify as auth pending=
 method

This allows a server to signal a pending authentication that does
=
not require any action from the user or client but can still take
a while t=
o complete and enter the auth pending state=2E

Change-Id: I6217c0541bff81e=
efa63a987db8904b2feda2546
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
=
---
M doc/management-notes=2Etxt
1 file changed, 30 insertions(+), 0 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/19/1919/3

diff --git a/doc/management-notes=2Etxt b/doc/management-notes=
=2Etxt
index 1126468=2E=2Eefbe757 100644
--- a/doc/management-notes=2Etxt
+=
++ b/doc/management-notes=2Etxt
@@ -794,6 +794,36 @@
 The client should ret=
urn the response to the crtext challenge
 using the cr-response command=2E
=
 
+notify
+=3D=3D=3D=3D=3D=3D
+This is notification that there might be som=
e activity that potentially takes
+a while to finish is happening beyond th=
e control of the client=2E This might be
+a server side check or an out-of-=
band authentication like requiring to have
+to authorise the connection on =
a mobile phone app=2E Beyond the control of
+the client is here meant in th=
e strict sense of OpenVPN client program=2E
+This message still might promp=
t the user to look at their phone for example=2E
+
+The syntax of {EXTRA} f=
or notify is:
+
+    NOTIFY:<flags>:<notify_message>
+
+<flags>: a series o=
f optional, comma-separated flags=2E No flags have
+been defined yet=2E
+
+=
<notify_message>: The message to show the user to inform them about the
+on=
going authentication
+
+An example for a notify EXTRA of a server that does=
 some checks against
+well known list of blacklists could be
+
+    NOTIFY:=
:Please wait while your IP is checked against multiple online abuse databas=
es=2E
+
+to inform the user that there is a delay in the connection attempt=
=2E
+
+Since the notify pending auth is not requiring any action on the cli=
ent side
+that is required to continue the connection (unlike MFA or openin=
g a browser)
+this message is not negotiated but can just be sent as a grat=
uitous message=2E
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 ---=
--------------------------------------------
 

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Ge=
rrit-Change-Number: 1919
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--i5+qur1XYrk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Docum=
ent notify as auth pending method<br><br>This allows a server to signal a p=
ending authentication that does<br>not require any action from the user or =
client but can still take<br>a while to complete and enter the auth pending=
 state=2E<br><br>Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546<br>Si=
gned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/manage=
ment-notes=2Etxt<br>1 file changed, 30 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/19/1919/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/=
management-notes=2Etxt</span><br><span>index 1126468=2E=2Eefbe757 100644</s=
pan><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/ma=
nagement-notes=2Etxt</span><br><span>@@ -794,6 +794,36 @@</span><br><span> =
The client should return the response to the crtext challenge</span><br><sp=
an> using the cr-response command=2E</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+notify</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+This is notification that there might be some activity=
 that potentially takes</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+a while to finish is happening beyond the control of the client=2E This=
 might be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a server s=
ide check or an out-of-band authentication like requiring to have</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+to authorise the connection o=
n a mobile phone app=2E Beyond the control of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+the client is here meant in the strict sense of O=
penVPN client program=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+This message still might prompt the user to look at their phone for ex=
ample=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+The syntax of {EXTRA} for noti=
fy is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY:&lt;flags&gt;:&lt;not=
ify_message&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;flags&gt;: a series=
 of optional, comma-separated flags=2E No flags have</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+been defined yet=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+&lt;notify_message&gt;: The message to show the user to info=
rm them about the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+on=
going authentication</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+An example for a n=
otify EXTRA of a server that does some checks against</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+well known list of blacklists could be</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    NOTIFY::Please wait while your IP is =
checked against multiple online abuse databases=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+to inform the user that there is a delay in the connection atte=
mpt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+Since the notify pending auth is=
 not requiring any action on the client side</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+that is required to continue the connection (unlik=
e MFA or opening a browser)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+this message is not negotiated but can just be sent as a gratuitous=
 message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span=
> -----------------------------------------------</span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Dem=
ail">change 1919</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1919 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--i5+qur1XYrk=--


--===============1195539410485622644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1195539410485622644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1195539410485622644==--

