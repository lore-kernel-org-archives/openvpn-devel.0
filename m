Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1DCD98C8
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XnC6yOWh+aC9JZ5ZKyy19e9McfLE4y3O37fwdJaw44=; b=ZxAqpAsvTKcVSnjtDw7XfcjgIR
	6iJbZrUP7m1uMNSVASpnTSOFeZXKliOXGeiI6BJf7OsIxo8Ub7U6nleVFJwtekMhQ8r/j5mxLVYWw
	beAyjARpWcPMS2igwBNjnwPX/3147w08EIxk+9/dyJOIa8Qi89b7rxHCuC0Y4SQHslSs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWyaC-0004hI-Qf;
	Tue, 09 Jun 2026 15:41:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWyaB-0004h5-Cp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:41:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dSIRu0QFfSpCUCFry4zKUag3tEQGML+zoXgufqW8XCM=; b=BWc5xqZZIy7RahMoUMq8RrwE2p
 KyESrFKgniQQNRYakJwcDeGOmNKijmziMueuBvinI6KhO3Who3iTgOQGL5fhlMZHI9eaxihtJOd2q
 YgU0WEmi7tOInsvsB4dMw4vnFnDrcuS7/aY0Os6ld48M9O3YcoreKNeoLgnhTTKksCqE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dSIRu0QFfSpCUCFry4zKUag3tEQGML+zoXgufqW8XCM=; b=G
 5ctlZsD39QuQLKMVSlxVUT1h7qDjtoKLeBxeY2vF1CK6UdFAMhSEn9LRQhtX5Rf+QuJ2RYwo6wOFg
 t5hkophQh1B92YWQBCg1TEL73qdlQWY+7zu6PgNVMJE//zBiO23OpUUW5nl42bvajWm8cTNVLhJOw
 2oxm5ATns8hQGn8k=;
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWyaA-0006iS-95 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:41:40 +0000
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so10600148a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781019687; x=1781624487; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dSIRu0QFfSpCUCFry4zKUag3tEQGML+zoXgufqW8XCM=;
 b=e2F+Uh2OUa32T0uMPjz/nZjLZgiwuPC3JHsreYYKAxJI/pbbih3yqhcUB1f2xJ3IS5
 ri+Z9HSE7vP5Ae1LC47UgJmJ63tslK0CHZiSgS649mMAqn/X6wpq5p8g+1sIieB7Rm9F
 clAxKMiIomtZkxVCLNwBaIX8aN6u+lvc4Eg7ZQoFTS3Inc5nx6oXDM/o9+0ozqYIzsO0
 NiBQqp0A6THMazfHTPXprZg5x3pyeRon83UhcAAaClob0IV5zP1HegrlyFe6r2Azm70w
 HsrAQI65B02UgOaVkWEcqR/pTpBHaRaSKXZzm9pLCTGsCExxirjxwBdS8aPNjMDWhZbQ
 XYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019687; x=1781624487;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSIRu0QFfSpCUCFry4zKUag3tEQGML+zoXgufqW8XCM=;
 b=IfSoKlpYWjNnUest6gVwFzvxUbZlP70cTjC8UayKcPDEKwTHrLZXeOZit4ij8TToPv
 CUx/EnCGJi5nVG5GAff34We2+fuf9bJiIcoikintBMnj6iHvF4ujJqMoHJ02ChtnZ+P3
 0lG22Q8Voycl7fzXDlRw7h67AYFZqVkrYFm+pzAeNa8XbyLFbqY6+w63ogyehDiTOwRf
 tQfOuB1OoWlKhtxs1/TgasUZjU0wvRBt1C0uHn6xoC8gxKKVAHlGXIBQAYlh/bzpXrNI
 iO+6BF9GWNUE0OV1WdMmCeLWf8EEU+ITPyaRUAxEC0NgSw7adRRWVMHzlpYZKDM1yRdZ
 /i2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+G+aadDdHSb0DtgsHr34BRg8v0mReM810WV5gTGj2UEUIsgNpjpsNbMm+THrC0Dk3aEw8rXFUqjVhe5CnH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxcpHr7mK7LD1JWYZSuBE7QSnA6ZH3n5BUPTENuLI0TSzEQ2ren
 FHq8huy7Tfl5Qi3LgKl+rjoTfZm60K2QQJejKDyGmAExRrQaf9Bn58BIdd+jfWWIpyg0IAHpkPA
 pE4himZVLuq03EbVc+0z7qYXeRDEh1HoO9UdJGMGGIIklfA9Ks8kSkVHqCSMVr9DX+l1gzEzMaV
 /ra30eTg==
X-Gm-Gg: Acq92OEyjVEnqWuYEXlTY0rgS98nI7NntVvyVbxOoJKVibN7SOFGdhZljl84mHgTNrv
 hlx+wWH2xc++uVgyw2saAtDrw9GPQ+OXIzCFpJD9jSV8jztc/SD5S50bOwwZzxNrYoj0D6U//4Y
 MXcQp9oAA6VPfGaInhnHww4BqH+Gsti09Gb3N0a5l0RonFcQ7jg9xQCMXJb5vbCnNTfqqNLLXF4
 YKpugs5dORKwhMcQawnuYf1XHUpX7aceIU7f4pcpxwUN54wDB2/uqUnwWirclKFMI0vKxYPQvGO
 aviNRQT8Enl+2nuuLNjAG49R9LsTMCVaSfGlT4ktxAS7R/x66RasbBMEAoZrqdVB7UxcvNkPxYy
 TdfwcQkCN9iKGz2gQeSCd4kn4xbF/RcJSckn1junjm9Hv3Uw3qXJLzQsB1YzKHW1URMfRPGJdyS
 f5XlRDwBWM9Q7yFBu3jIVJVFFlh5wCe05D8PfI4IrarZwM/+mXrUAzVTeUpTOejVz1rCwEWx9wq
 KjkUr8mTRHQxSfKyjmkrUN171Wrj/tkA2nX7DmAa8CXh+nE9xhHSVkunM+l0NrjLBho+nqltwuF
 8hYA7PJ0dDzDI3xqyo2YWr94
X-Received: by 2002:adf:f209:0:b0:460:1301:ded1 with SMTP id
 ffacd0b85a97d-460302dc4d0mr19684554f8f.6.1780991014939; 
 Tue, 09 Jun 2026 00:43:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm62413586f8f.17.2026.06.09.00.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:43:34 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:43:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 9bb6c3cf8378bba2bd4c7ae2495f6882de92cd95
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 07:43:33 +0000
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <34fca11bb5bd474b9f65a3b305e32065b014d57c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWyaA-0006iS-95
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: send HMAC
 reset reply synchronously
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3422336877829274721=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3422336877829274721==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aH73AkBPp9o="; charset=UTF-8

--aH73AkBPp9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

its_Giaan has po=
sted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset rep=
ly synchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(2 comments)

File src/openvpn/mudp=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1702/comment/050409ab_49c408e4?usp=3Demail :
P=
S1, Line 61:      * dropping on EAGAIN is acceptable as the client retransm=
its its HARD_RESET=2E */
> Also, I would reduce this comment to focus on "w=
hat we do", not "how we did it in the past, which di [=E2=80=A6]
Done


htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702/comment/1fbca709_dfbaaa38?usp=
=3Demail :
PS1, Line 70:     msg(D_MULTI_DEBUG, "Reset packet from client, =
sending HMAC based reset challenge");
> having this `msg()` *after* we alre=
ady sent out the packet does not make sense -> this should go upw [=E2=80=
=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
702?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2df0fec7=
86184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number: 1702
Gerrit-PatchSet=
: 2
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cr=
on2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Comment-Date: Tue, 09 Jun 2026 07:43:33 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=
=2Ede>

--aH73AkBPp9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
702/comment/050409ab_49c408e4?usp=3Demail">Patch Set #1, Line 61:</a> <code=
 style=3D"font-family:monospace,monospace">     * dropping on EAGAIN is acc=
eptable as the client retransmits its HARD_RESET=2E */</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Also, I would reduce this comment to focus on &quot;what we do&quot;, not=
 &quot;how we did it in the past, which di [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702/com=
ment/1fbca709_dfbaaa38?usp=3Demail">Patch Set #1, Line 70:</a> <code style=
=3D"font-family:monospace,monospace">    msg(D_MULTI_DEBUG, &quot;Reset pac=
ket from client, sending HMAC based reset challenge&quot;);</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">having this `msg()` *after* we already sent out the packet does not =
make sense -&gt; this should go upw [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1702?usp=3Demail">change 1702</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325c=
db6942 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1702 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Tue, 09 Jun 2026 07:43:33 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--aH73AkBPp9o=--


--===============3422336877829274721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3422336877829274721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3422336877829274721==--

