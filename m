Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A5C88E75
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HnNEtDvcTQ2Na6/+3AzFDqC/6pwruTU6mVLW7bR9XXo=; b=I91Te2Er1Zo7EBM8bxpmpoYVXH
	J0W2M5f647t5oopV4PNPZlECSTe1g7FPTHh4ihV1iLgklCx76DADQAY+PNF8jWqfzBdK6OBAfJxDp
	ydRAvxQRjsnCz1A7DY3LAwuf8A4R0edYRl/tygmPHtTR+cQzZT/+SFadmjQNAIPy5P4A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U2Y-0005p8-Si;
	Fri, 18 Sep 2026 08:33:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U2X-0005p0-Mk
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:33:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KsaoLUiiNssQTAIPA9csqZkvgJNvF3g1sFVDXyctmg0=; b=j9MI4ltZpj2wOAzKBDviZc3+B+
 TEGz926a4S/qeDNzQ3Elbppn/BgMuNMVHf88G997Fw62UkAEwQ9K10WL961ux2VBemBjyXfmohfwb
 szMHimneRDUtTlqp75/CGnZV/xKQlszqWg8Cdt/nKZobUYXepgFU2P6ItYs6V/7EeM2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KsaoLUiiNssQTAIPA9csqZkvgJNvF3g1sFVDXyctmg0=; b=m
 n2YTdjwiL8b/OYJfQTaM+aU4IpC/hTOzlwhie2GqXm+Ya8FdB9vZn67LplWGy5fe4SfnhU1bVehBF
 Gjz+dZNC9kEhV0FZ7/qSr3Zk27ECr1t4L0AUAwJY69PqsUowccmxseprWQJX9TIX6nA4HDQn84Z9x
 HvULkU56I8VmaAus=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U2F-0003Sc-Iz for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:33:49 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso144321f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720405; x=1790325205; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KsaoLUiiNssQTAIPA9csqZkvgJNvF3g1sFVDXyctmg0=;
 b=NYsLX7jmSzpg0TpWGnQbG3dS1bpWNRfKO2G+YGk0D0ZYhuyxlOQiwb3a8JedjNI7Lc
 vbpbau7EHdULY1030s4a4ix2I1U7k2Ac5/5wrDG+ZQMfOhM6vH+nbib2MesCIJIgVSEW
 aJuu5vdo6UX6Aeblc5vJMxTTXb5EXXxttxouem0VJyGdpyPVYjlSXoVeCGekFE5FxCbr
 /gL64XmmpRIa8lRVFXxtvFZJmXR7OZfayzzejsPspz0SFhrqVCO1xK2rmGr+id7e0nxH
 AnbEdzWvETGLGbuTmQSRoFgY2j603mvA+3W4VDS1LDlJ7vF/NYC2ZjDbvtrukrFt75k9
 NiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720405; x=1790325205;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KsaoLUiiNssQTAIPA9csqZkvgJNvF3g1sFVDXyctmg0=;
 b=zL6Y+5ZnOH5KrjlGlFAiJF09hwxmiw1eRtmrkvUWWXDpp3Fgrn03KstV/V0Qp1nCA+
 WBHVx0/6fErvAAFkeVNZrnCCk1UZrbLe+kdeXzZsfkwtAIlNw1rTJJ9at6z/Ji0/Cu+p
 UVWNVIxD3XEPz9NRP3zyzYEdOgKmphT7g+bcHHt8KnfR1YPaEBLGt/7e1AuJY1d75t7k
 srhk4DvOniQOseoFtmuw3KiVMBEkzotmGBxN4BDCgkvAzCIakIP1/sOFGcvI63ZFy+Kr
 OhghcSlmccgeXRsg3+Jafvrh951oSBPCY275qap+EGFYNP/j1YX0rAH7fNyCBeDNj6hT
 lqpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByN5AWIFKRMm2iJFSfD5Pv1BN5zYjPieanZLS48vZIBjG104xS5DEmQTGefxvIf76t7Qcd7Gg7zL7yHIWGk@lists.sourceforge.net
X-Gm-Message-State: AFuF++nbelv82dOUGUB+LwvxXyaKyEnUTUl2fizAkvds1/pLWMEgXXD0
 F/AhrAObOrY9NlLFasOWxAQp1NeD42Np6WLWq8ow/H8Ctx5immzW90rclQ72FPZ0qFlwdzk+68g
 npEBV6mWzpFP60NAoA7sbkdnqAwhlq/xMWfKnBuAr/KlgwLpRRp2/duUFd+eAUs7p8Uj8
X-Gm-Gg: AYBFou0FyCQGMC4d3Zm1XPykPdIWXKFcWu4T51tYcIEdJUf/9ghzz2PPNXuBtiodOBU
 PCsrjVuvxDnNMqd3nepzvdvZmFutEBfzSK2nUtdm2ngZj4PhqIWemqdSK7jSZr4piVIP3FcDJP1
 TuHNTSRufjCJGSI40kqUkWkIV54RPuf18pBgvuDZZfmQuS3VWNMLqIHjSNRmnBa1kb8nNm3t3NJ
 KXZeBbIwWjd6DRZ544M6IqgrYZb+RKhYtnlqHNi3Qe8eBBksD3mXYU8S7x21ImaaUzNKXqGN2FL
 PDosKt+/H/ZWITvDvbZMmRKcGS8ytgSw12bnu4fkG5ZQHB76zoSkR0g7FbblbNJfk+Rtz63qN9d
 zWip2DCiD32syOCTdiuiQiwh0qRirTTj4NkCTlGLIoAExZTbp7BaNDhUcE92lKzXignFmYg8uaV
 xkefRIkJbT67FH/ROdyNyqLo30CejjKADnwhbTJE7VZnmbyqlBD+cTGlAQBahhCg4dQgJoeprVi
 RD+30Bn+WnhwyL4Cqafi3F5SNHYs37Y654VQfTdcLOWCpCymJUcR1P6CY7jDgf364x2JTqQ1AbR
 OpriOMS/7KzhJKDgLFVFaVhXVvv7UsuoxH67vbY6+2ZGa5AGuSRnUtXWmROgCA==
X-Received: by 2002:a05:600c:1d06:b0:49e:8222:3451 with SMTP id
 5b1f17b1804b1-49fc5001358mr24691605e9.14.1789720404768; 
 Fri, 18 Sep 2026 01:33:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7ce03e7sm39195555e9.3.2026.09.18.01.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:33:24 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:33:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 4d012d1a365a805f9abeae9014602d3556083bac
X-Gerrit-Comment-Date: Fri, 18 Sep 2026 08:33:23 +0000
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e26e11bf5acb94e23bcf3b1c75c553bce4e7399-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U2F-0003Sc-Iz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6771757542736971378=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6771757542736971378==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n0e8AHRRnf8="; charset=UTF-8

--n0e8AHRRnf8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail )

Change subject: oob: Add --server-probe-reply=
 to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 29:

(5 comments)

File doc/man-sections/ser=
ver-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/=
ae876caf_30795eec?usp=3Demail :
PS24, Line 671:      server-probe-reply off=

> Since the goal was to allow eventually the server probe to be a better w=
ay of three way handshake al [=E2=80=A6]
No good reason, I added it just in=
 case=2E A server doesn't answer only makes its own clients slower, and wha=
t an admin might wait is covered by the values (priority - "dont prefer me"=
, connect_livetime - "no handshake handover"=2E Removed off=2E


File doc/m=
an-sections/server-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1752/comment/dadd641e_e771cdac?usp=3Demail :
PS28, Line 688:   servers of=
 the same priority proportionally to their weights=2E
> Should mention if l=
ow number or high number of priority means better priority=2E
"clients try =
servers with a lower priority value first" is already there, make it explic=
it "lower value =3D preferred, as in DNS SRV"


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1752/comment/e2e0ae8e_26408188?usp=3Demail :
PS28, Line 701:=
 
> gets little what?
changed to "while a replayed probe is answered at mos=
t that often"


File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1752/comment/e17f2771_aedddbcb?usp=3Demail :
PS24, Line 259:    =
         =2Epriority =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_pr=
iority,
> If only uint16 is the valid range, then the type should be uint16=
 and not doing casting here=2E
oob_probe_reply_{priority,weight,max_latency=
_diff} become uint16_t in options=2Eh, casts are gone=2E


File src/openvpn=
/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/c77c9465=
_3697676c?usp=3Demail :
PS28, Line 249:             return false; /* --serv=
er-probe-reply off: exactly the probe reply, nothing else */
> I don't unde=
rstand what "exactly the probe reply, nothing else" means here=2E
"off" is =
gone now=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1752?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfa=
e7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchS=
et: 29
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 18 Sep 2026 08:3=
3:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-T=
o: plaisthos <arne-openvpn@rfc2549=2Eorg>

--n0e8AHRRnf8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>5 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File doc/man-sections/server-options=2Erst:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752/comment/ae876caf_30795eec?usp=3Demail">Patch Set #2=
4, Line 671:</a> <code style=3D"font-family:monospace,monospace">     serve=
r-probe-reply off</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Since the goal was to allow eventua=
lly the server probe to be a better way of three way handshake al [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">No good reason, I added it just in case=2E A server d=
oesn&#39;t answer only makes its own clients slower, and what an admin migh=
t wait is covered by the values (priority - &quot;dont prefer me&quot;, con=
nect_livetime - &quot;no handshake handover&quot;=2E Removed off=2E</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/se=
rver-options=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/dadd641e_e771=
cdac?usp=3Demail">Patch Set #28, Line 688:</a> <code style=3D"font-family:m=
onospace,monospace">  servers of the same priority proportionally to their =
weights=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Should mention if low number or high numbe=
r of priority means better priority=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;clients try s=
ervers with a lower priority value first&quot; is already there, make it ex=
plicit &quot;lower value =3D preferred, as in DNS SRV&quot;</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/e2e0ae8e_264=
08188?usp=3Demail">Patch Set #28, Line 701:</a> <code style=3D"font-family:=
monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">gets little what?</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">changed to &quot;while a replayed probe is answered at most that often&=
quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/e17f2771_aedddbc=
b?usp=3Demail">Patch Set #24, Line 259:</a> <code style=3D"font-family:mono=
space,monospace">            =2Epriority =3D (uint16_t)m-&gt;top=2Eoptions=
=2Eserver_probe_reply_priority,</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If only uint16 is the=
 valid range, then the type should be uint16 and not doing casting here=2E<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">oob_probe_reply_{priority,weight,max_latency_diff} become =
uint16_t in options=2Eh, casts are gone=2E</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1752/comment/c77c9465_3697676c?usp=3Demail">Patch Set #28, Line 249:=
</a> <code style=3D"font-family:monospace,monospace">            return fal=
se; /* --server-probe-reply off: exactly the probe reply, nothing else */</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">I don&#39;t understand what &quot;exactly the probe re=
ply, nothing else&quot; means here=2E</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;off&quot; is g=
one now=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2dd=
bf635ee85a2a6cedc3d8 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1752 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 29 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Fri, 18 Sep 2026 08:33:23 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--n0e8AHRRnf8=--


--===============6771757542736971378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6771757542736971378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6771757542736971378==--

