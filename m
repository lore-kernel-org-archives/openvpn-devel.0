Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD61606A32F
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k2yDaZJi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jpPaYK8t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MNc4YCfP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fnb+bYnF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qCZGT+wUlnydg0XaTjKZ1Y6By7uHG+LhKxBHqG6UU/k=; b=k2yDaZJia1LGBt6xzisShWyai1
	+UjF3Ep5Z6lt6Xti1WFUdpIcnVi+9M2CdgmLraM+uK1g/srPm2oHAuZIXEFqF6bimTGMgK6/CciWk
	UnPBrmFx39RYVELj+6FPuefYxaJyo3P3dvO2EbiQe78JcXW9IttrgtneJKTES55K5NHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNiJ-000000003rd-2Va7;
	Tue, 17 Nov 2026 18:15:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNiI-000000003rX-0NGn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=762ZkKFNSjvT1LeDlAupvDXwS4bLCgQPR+XjAjYBy7Q=; b=jpPaYK8tevhdqFf5moBt1j4Eof
 riUSbecuTvQNWywM8jSGpNMtahMvvN628DTu8lc0AICPv0s2h4mHzxJahiMxNi1XEuusTC6GwEpny
 Dm6kc7XWglZwlKoHRWCxQ7wnnajG/L8/MzipCqoM+Edaqvch4RGhVrlnQl3e1U0vl548=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=762ZkKFNSjvT1LeDlAupvDXwS4bLCgQPR+XjAjYBy7Q=; b=MNc4YCfPqOjPgFHb4IP3oPuuTR
 Rcem6br7KQCT5GiTwckTUcMnLRb+rSHwIs74UnkbIPzz7q2nhFDT8cd74+sPmMOK3SZTBWmv3VZ9T
 a0EaoWqQeyvClvFrkcbKx6RphIR310tgGzNBxrUPPgYyGnIQMIUd2PJyzxNsCogHfZpE=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNiG-000000005zz-1oaI for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:15:26 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so1823725e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794939318; x=1795544118; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=762ZkKFNSjvT1LeDlAupvDXwS4bLCgQPR+XjAjYBy7Q=;
 b=fnb+bYnF8nHMEcronIZb3hV4O+eDWcp0k+2r/Ctm6e+EcYGdz7f0tzSLSqbDWJEyB3
 vH4fFkTPf5ShPC/1UZu4wyIAYa3AtxYR1hqQ1lOywvAEgc+QaJgGb8sCu87lTUr3ahjR
 TipQZWg2TdGge1W93zvZ0qUkWa82oDFzmissf4RNjY4YXY+X1aquYP/SOmyntFCt6Bx6
 rbGJ3y3i7cmtR4w1e1xfDB8Ipflev1fy73c9azhD2fsrfYEXZQjxCwGI+viCF0HektXS
 3P0n7qXGBdckBnWVPIQimXeLcBEZXtebeweYIV4d+ZiqNu1jqfdx8MTZIuS1iiWLo12y
 YScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939318; x=1795544118;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=762ZkKFNSjvT1LeDlAupvDXwS4bLCgQPR+XjAjYBy7Q=;
 b=h7InNTZs0LY/eMY9zV7ctjgrA7c1RjbF1gonkHuyPtW3cqFouqhYBZLe3UwcL7Z263
 wHBZO6MkZmBvfUDH7U6NTeHxWEmQ6iXdMiMor7ya9K77N3+oKz68B4wQv5hZe1OZpM8T
 EWzKbhUlM9DWs6jp8YNFP/c8uuyWORxmRr37lDNd0zYlt9CWkIGnLBT7qdJYl7Tzs8UP
 apKWiaRZsPwGH9I+E+hAoEuuLFWtk2gArgSlpK7gtZnDz4ls2ic0EO9Nz5Z/3n4CQFqo
 jjiSsTlskmNId4Q9eYzW7sKVY9t5KqA5gniG957OSMZAuMR9p3b2LGfLk7Rv21U/2P6A
 vjMg==
X-Forwarded-Encrypted: i=1;
 AL+hErEQ6WI+Ot0AsmFGI5YVbwHFJUOT2JpTmNtuzXjeH2/0TIZJWZsWNcHF9xnW1lY1FC86npau8TItOy2Q8QhK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/6DEuDHoDIQjSMnPBwwqGsoM820coqbUt4QbkNCsza8yjZSuky
 cBXn7oBWqxr8cKAYQo9rog6P0rW6/VQGs5rAE84awoy1S9HePuqaLM+iTJrqjiS8cWJd+3SGUCu
 5XYK3I6HcwAxeiWtooXFdqtCGkLG43EXAzN3Jadj9EN56uFiBw3tASAAa8xDALhekk67qOxposL
 J10wUkjg==
X-Gm-Gg: AYBFou0FR3e97EjtaciMC/P/DAFzkVjgtZdMv5dLOa2xhT8r2YiNJivkkKy2Kgj88JE
 vTUqCluXQMHpu9nEx6Cey5hQIB2u2m9Qs59fiFOyTcDQlx4C8fgKhrfWedfmpm9x7eAWCV4d/hh
 y0I4Bd63A9iEUvrJYqsiM1L2gejOgoiOHy23semmIXIgHvVDcANzgZhkIZGkLfbaJ1fK8lZFEgm
 psYx3Tj0SPHaoG7bFXRKlp41IiTRbBo655VLgMsSrr/yS/d4tnRTePcyExlJ7H6t3hz7MV3b+1a
 UkoTqQj5oQei0/eX8tT1chmPvX0o6mQkF/BWSJSKSlcs8qMXci6AeTg/fznp/fzQ7cDDuUgsJsy
 qVMiqqrWqD7I7MR8LCxH6npmflxbO/Yfl1Q+1LHAqQBrStOud7zA6eU8/VBZSF8BKSGmE+m+Mvf
 KZZM/FIYFWrztYR+jHwlZzjf+q/nlit/C3TiT1Zia8VEPZK6dK3K/87yPsAg7tf/lCiJ0yqLf9o
 itdCsuVjoh3XSPb/3TYXkS9/VVTTPyp8Fa4UDuloRY18eGzsfuFgLAvKu5qpUshiFPp+gBf+jVQ
 rueHOyNqlzZUnrCh9KJqdjDrjALThQjH/iH/KAuLwzm36G8z3AV/Nh0GXFCJB/KZviFTPr4pRQI
 KlcQFXR07C9Db7PJrSVSBEsKwRcNsUcG8kNQ3DA3q4WuHhmivirflVUfQ9zQ5sqD2vmNh8KsyhQ
 BctQUcXPtC2gbX5Ec=
X-Received: by 2002:a05:600c:3b9d:b0:4bb:5dbf:af06 with SMTP id
 5b1f17b1804b1-4bb5dbfb103mr305902955e9.9.1794939317594; 
 Tue, 17 Nov 2026 10:15:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6560962adsm100007f8f.41.2026.11.17.10.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:15:17 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 18:15:15 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: 73d6fdaccd4651e1b6d73577ed932559f7b5c483
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 18:15:15 +0000
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1b2f9277611089363d7de98c4c62561b4506ca19-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNiG-000000005zz-1oaI
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: raise the
 open files limit for --max-clients
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8966394235556864423=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8966394235556864423==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ej3NAsjnvQQ="; charset=UTF-8

--Ej3NAsjnvQQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Gert Doering has posted comments on this change by Gianmarco De Gregori=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail )

Change=
 subject: multi: raise the open files limit for --max-clients
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
-1

(1 comment)

File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2211/comment/3b5947bd_b36b1497?usp=3Demail :
PS2, Line 319:  =
   }
this should print an error message if it does not work - I tried this =
(Gentoo, setting `ulimit -n 30` beforehand) and what I got in the log was
`=
``
2026-11-17 19:10:40 us=3D71040 WARNING: the open files limit (30) is too=
 low for --max-clients 1024, TCP clients may be refused before --max-client=
s is reached
```
but no indication that it actually tried to raise it, and =
bumped into some error (which is surprising since it should have had root p=
rivs=2E=2E=2E)

with default shell settings increasing *did* work
```
2026-=
11-17 19:14:24 us=3D888551 Raised the open files limit from 1024 to 1088
``=
`
(maybe add a NOTE: here?)



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2211?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
Gerrit-Change-Number:=
 2211
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mand=
elbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianm=
arco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov 2026 18:15:15 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Ej3NAsjnvQQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Gert Do=
ering has posted comments on this change by Gianmarco De Gregori=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2211/comment/3b5947bd_b36b1497?usp=3Demail">Pa=
tch Set #2, Line 319:</a> <code style=3D"font-family:monospace,monospace"> =
   }</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">this should print an error message if it does not work - I =
tried this (Gentoo, setting `ulimit -n 30` beforehand) and what I got in th=
e log was<br>```<br>2026-11-17 19:10:40 us=3D71040 WARNING: the open files =
limit (30) is too low for --max-clients 1024, TCP clients may be refused be=
fore --max-clients is reached<br>```<br>but no indication that it actually =
tried to raise it, and bumped into some error (which is surprising since it=
 should have had root privs=2E=2E=2E)</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">with default shell settings incre=
asing *did* work<br>```<br>2026-11-17 19:14:24 us=3D888551 Raised the open =
files limit from 1024 to 1088<br>```<br>(maybe add a NOTE: here?)</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2211?usp=3Demail">change 2211</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2211?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343f=
ad2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2211 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 18:1=
5:15 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--Ej3NAsjnvQQ=--


--===============8966394235556864423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8966394235556864423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8966394235556864423==--

