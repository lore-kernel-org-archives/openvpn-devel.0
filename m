Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4087C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pG3xTYcGDwabQnawRasPwrQQZTuMxQGl2gYrWzV9BjA=; b=P0LcF7ih6r0T8QyclezCDbIRa+
	pRm3OYeXSOgUgKCHU76icKIPkG+QSwZZq4R+PeD6iLSsnVay6cphM4/ZNEMvg57xbMhb6s/IOWe5j
	Mngvmsoob0dX/fPj3XurJWIdQeypJaWrYjv8WaT64fo5V/oIkUNsKhf7/jZ2++hh2xuI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgkGu-0002z4-Ez;
	Mon, 06 Jul 2026 14:26:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgkGs-0002yx-Lz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 14:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=a7OCIQNLQANEn8Vn6VO3yPq8M8iAYEfnOFqMI5w5hpA=; b=Dler2Tu3krVWexVFrpU0kBPSBJ
 q/MU7WfWaSR1ObxOtCoC6rt6U91wB8SZz+WouxfgiH9z2ePrm8jWFvGigAdT1oVcYjpNG/lB5vSaR
 2by/MGbwyrTf//wbkDQRJnVPvtNY+7l4xEFRU6NEQqF6/EsmKk8gbatRay8WctQ5GjU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a7OCIQNLQANEn8Vn6VO3yPq8M8iAYEfnOFqMI5w5hpA=; b=d
 T0bK4I6iUznaIJTOYJrUN+bII+kMTKVx6+k/ZahoHXbzM1ibckBqkJqCjbfpeij4UEWdgxB6CJoVN
 jSj/ahRWELWNDkMxH5nP8kGUfuW4fEzhGbLmbRfo9nNqyGQ1smT0K+6v51+hDhKayMV/in3WXLMcC
 IKNWlwsWHn6p8QG4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgkGm-0005u7-Vd for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 14:26:03 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso31997285e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783347950; x=1783952750; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a7OCIQNLQANEn8Vn6VO3yPq8M8iAYEfnOFqMI5w5hpA=;
 b=EzUlDSZRS4dS6jh3y7e7rsAXnKXRylqGbTVeKBQiCbVbz/C+BDsfnNQRewUUqbSC0a
 vw4YjT4iUrjXz/8Y8+rKrXJP5IorOjKxEe918c618bPN20xfyJ6OdsFxTpG93i55MArL
 BpTU7k927BLnx6eswj0dfWhXROKpULIZB79EbKkZq0YE/AkNLFlNNeA8PApn+24ujiMF
 e45KPojj3w9KaPBDxfcRLrTx+TxyVMF3AhEgxGZFQDvZbLHfJWso9cELSsjdcLu0NDTo
 N1t7CHKpwe3j7q53IAKPYeytrvirlKMLX8q/LzgcRiVCQPa6OQsToYah4b4EtQPCeYiI
 8nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783347950; x=1783952750;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a7OCIQNLQANEn8Vn6VO3yPq8M8iAYEfnOFqMI5w5hpA=;
 b=g7EO4Uha/P9H4CxWLAcqpTVu9AoNCwa04QCsor7cjUqvYep9m3g1rXNIR2mIXmRPv+
 jsPq8RLwnmYdVGOGuJS3xNPex1oVp2lF5PfJRiWkv8/G4C5XRdx35k1Trc1o+UHq16tY
 Kn1R3RAIAg1jTzKxMH56reS+3NUdJa65ra0kqEE9GHNVPjxbdg/AbG7vB4eJfAvKH3qQ
 KkEcIObMQ0WU1gn9Ay2Jw5tiYR50FLhmumw49BI7ThO+B+9u2lFllC6cGlJQND+df8zI
 SGLIV6QA7iKEmviRKxnoQ4n/5JH69zCH+1H6SwaowxUo+bESxDVSwQ/y+IvKB8d0XYlh
 aa6Q==
X-Gm-Message-State: AOJu0YxbLZJcCdCmVcAP4BlK65og+d3fvFn0IMMNIk7TsmLNV8HljDfz
 jBVniqv2gcRfRcHOCH3EoITcJ7nvKHNtv2lnq4Lxc/+/fW27T0lcYRsN3BYzA6wtuRshv6VlYYl
 Y8c9X9eSafsvJafnTZi//sQALXoWEYqsrxRZ4RkaXTXEcKkjZV9GfTiIeFhnmZKQn0aoX
X-Gm-Gg: AfdE7cnnBpzmQSYhbM05YfUdJVEks/c6OAb4Rvq5vtw7c+bAhLOYuNHt60liNwl+YhW
 4gOmS7bw3eDBI5MTuwLRlKs6b1MIYGs2DHCtyH84mPL8Oa4zMzjz7xIYIPIRsXSNf6hqvOstE8q
 6s4DGx1o4OkmmCOVAaE62MgN+MSvFOHYFrMrKrjqkwbPsmD9zdpQPNYwYZocK6lSgTGAP3Jhvgc
 Mcera03zn31873Db132W+JxLhVIZnOzU7OoRmnzbdg/GDdZFSX3ORuYwq9WoQN9TtmymbWzGC4y
 wtgcUQLRkRMLSeFazxLvl4cKtSejBBrMx+LEXuBJDbRL9nnHi7+BDH+3SFQo0aTXT6bhiBqyWEV
 MLQLvEE97EQmVwxBhTT0ZuWscsF206/gZw+8mbVIbotlGwhJsIwxgJ3sb9jMGJamxTnBjLxl1kf
 sNxaw0DJg//Np/C12yhxqir6GjmSGfWWRNR5FM97g3EqwqtXLnLzTgsAHuaQfVCuOM0AJ8ng4dN
 865hFAVEAt8QIAgiswWQwJV0KKelKoA4EVWvcgF9DRnSX41HmC9P6BgkhsZMHFK7Tn2e9wBO7eC
 zkM=
X-Received: by 2002:a05:600c:1d1a:b0:493:b783:ad59 with SMTP id
 5b1f17b1804b1-493df07390amr10136885e9.14.1783347949597; 
 Mon, 06 Jul 2026 07:25:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm341565475e9.2.2026.07.06.07.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:25:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 14:25:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 9e251ce7c48f9a749e46bb4051ceaf79b41dc1b8
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 14:25:47 +0000
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <032d79713d97267b9a76046d7fe0ec53781e564e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgkGm-0005u7-Vd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Do not differentiate
 TLS server and client context initialisation
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1212930636250237362=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1212930636250237362==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kZvin8rSqSc="; charset=UTF-8

--kZvin8rSqSc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1728?usp=3Demail )

Change subject: Do not differentiate TLS serv=
er and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(3 comments)

Commit=
 Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/73b69bd1_=
a4561a58?usp=3Demail :
PS2, Line 14: We later explicitly tell initialise th=
e SSL objects to be a server or
"tell initialise" ?


http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1728/comment/17573b5b_dd6a8176?usp=3Demail :
PS2, Line=
 26: Our mBed TLS code basically does give the SSL contet any personlity
"m=
bed TLS"? "context" "personality"


http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1728/comment/6ca78742_a2889b59?usp=3Demail :
PS2, Line 27: of client or =
server until we the same area where the OpenSSL code
"until we are in the s=
ame area"



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
728?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf1f3475=
e4f27a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Gerrit-PatchSet=
: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Mon, 06 Jul 2026 14:25:47 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--kZvin8rSqSc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>3 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/73b=
69bd1_a4561a58?usp=3Demail">Patch Set #2, Line 14:</a> <code style=3D"font-=
family:monospace,monospace">We later explicitly tell initialise the SSL obj=
ects to be a server or</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">&quot;tell initialise&quot; ?</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/17573b5b=
_dd6a8176?usp=3Demail">Patch Set #2, Line 26:</a> <code style=3D"font-famil=
y:monospace,monospace">Our mBed TLS code basically does give the SSL contet=
 any personlity</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">&quot;mbed TLS&quot;? &quot;context&quot; &quot;=
personality&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1728/comment/6ca78742_a2889b59?usp=3Demail">Patch Set #2, Line 27:<=
/a> <code style=3D"font-family:monospace,monospace">of client or server unt=
il we the same area where the OpenSSL code</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;until we are in=
 the same area&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail">change 1728</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf1f3475=
e4f27a920c028cd73b1a2497953583d0 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1728 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Mon, 06 Jul 2026 14:25:47 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--kZvin8rSqSc=--


--===============1212930636250237362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1212930636250237362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1212930636250237362==--

