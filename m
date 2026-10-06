Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2022ACA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5JV/WI8NxXgfXqaIxFnxCO07i/dtbtX0MRT8jZTJJA=; b=UWWXGk4e7U2xFYnBFFD9aow3LB
	pkJMNzNhyhDc21jctEVD3D5mXVOYIMO1jdpRK6muv+bgIAPN67i5n/Ivc3mUTuLCnOFnKRu/X68m3
	a7ogg/GLv31y8u+NYvfMlCevVkd1u6KI13abXgLViARI/NNaj07kAKYmqe9V6arQ/2nk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xED6U-0004oA-Ah;
	Tue, 06 Oct 2026 21:53:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xED6S-0004o2-GV
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 21:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w/GIApfgsvdB/5/Eid4K9hzUmeBFecj+iw84pDxKSRc=; b=U1SOIHAI1vy5rBA9EfrsrlbS7E
 xKO8z6ErlyP4cG5bj9qhN3XhKIXhtCSIOc8ntvGT+vo0gZDPl3JlV9BFpOO8Zsp4RD6E2RjdGpa1p
 tz7ae3rMvCibzFc9yh1qicz0ejU5Cmq770X7bvcI+/qAf3khbS5yE6BaUwTsxY++s6Ec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w/GIApfgsvdB/5/Eid4K9hzUmeBFecj+iw84pDxKSRc=; b=I
 MuwOvo+q0WNBYHyTQE09MYNRKOtdIL3r0Ic9fWvcBQee4K5bAs80/leP6vZDS2Y39djhIwWXPyWz6
 4XqjVzvhVW9rrXm16ZwdZStRcNjN8sT/H9KKsA6ytTS3vYNKWuvqPUER+5lBQI/nYPvBYos2lymQ/
 4tw7ouGc5Hp3jo1U=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xED6R-000433-2v for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 21:53:40 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b0be347b8so946554f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791323612; x=1791928412; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w/GIApfgsvdB/5/Eid4K9hzUmeBFecj+iw84pDxKSRc=;
 b=BJHHkvGjQ3cSJVfLXmRxdZ7otyN9HyCWXy0FZcdBcoCTSZzmr+PS14/0QSuREIgPE1
 FBx7GO5vekff6befx3yU6RxCbBFk7/WspE/FpzizGdcYtnfdYlOvH64XoCYzRnn2LahH
 aTRcHkqKIPerTnAld+FdZs2xfyRL81J8a7tME+ID1L+9jm8WMtRJBz6ZV4D/KEei33w4
 badDexepNdkO+OXgD15vIGET7RUWBH7RHBqVo/G+yFLCNAy95GBz3NId8xCv1BSnw56T
 3Zz3Ub03FprO5CH2GCof+13Fojfae6nAAC/Pgcpnk1v0APMkJtNp4KXjr/WN3eyxdu5c
 yUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791323612; x=1791928412;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w/GIApfgsvdB/5/Eid4K9hzUmeBFecj+iw84pDxKSRc=;
 b=ek6r7YtdWLmRg5TcvFfxHVvazWpGm4R0GwakRciMG+PM/EH0rilQVFA/iy+MXHaa64
 HBjM9kRkyw5SDPPKe0O9FqgxZAFNWmoiPxbuuh8f1vCiwNIxO2XA2xI76tgdqYRtpX9z
 CtyzaVUORZIWrPElpEnoYcT6v13fOqKkqqSryXwniUYgl6HjjrCYlkh0BOVhRoGUgil+
 IrB2NSXzGistslI6J8HZUChOmkJrqjTawtxms3SwfLbOeGGWtUPHWSWWSO2UsTUEMV3S
 OpeK2muo66EzfswAipLeaqNuLEN2UDGbFMVO1pZ8v8LYaTvoLEjwCZKKbiKzofSgjuyT
 /q5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzod5Vlpw8+JSKwdS8uc2VZysa6pimNP0CXAb7J1Vn0Rp3I//r0ikJ7GFnaEPaImyO+cXabpcCHWOgrXpxX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI280EmjFBrPi3ngRqMXRauNXulCPyD2nzZnXi1jxaTmCwPcrSH
 5ZV2/vaYIzaVm+sQgHVl+rvfBeqL2+xhHqO9I9f7OkiP7v1YBpwfYNTI2ryh/GC1VvMIirQtNhU
 CbOAespq4fZhXcs7jtYwnddMiu7GPAlZ7u1eY8ihralsOpUfZTUf6nWqnHkqFQmzvXGgr
X-Gm-Gg: AYBFou0HH3lfmUw5uexCqOPERR52D/0LX1F/0leMRAeBnUU7qo7Cd/m+tuvZAQst9MR
 kydSSbwv/AECNxAvURTGxVGHknjflWVvR5qNaQgekI9GY5u1IIhU9WZ0Z17efdngxWXZ2aYPt5I
 LRmdCmhrpNdbOQtrh+JQcpeHcDiMl6t3hpTw6SRSh5nc+2KG+88zq3ezo1gb/0Gmdzz2zdMVFRg
 vgNUy0aSYNSMgBnQDz/k0XMMDnLXvDdwQW2h4GIojdJRXY4ppQoyHofofkNnVVTZ2qeyQ1gm/9A
 4wKQoV0pQZsqMBjATKq427/qU6+s0pzWKe63WxJVF0gFV3FOEZuaYD9ORda4vgBpDrALirswlSK
 dSUsdZbnRc/CAHV2kiDQtQUdqiQzSEinUNpf2QF5kAT5lY4fUBIMJatDTykKpvX5MRXTwSwgHS/
 6p9IUzuUoNS5mEVxTWO4oX2hEijxZShn2XL1GaZdh4SX+JZY9Q50bDoQ4QfqJWo/b37qKL4NYS4
 W42FXq7Zn04MANcS6U5AMnyYEMCLT4ouPTedIMzPbBoBpRtRQH3v4HAeAo17+SaFQL5cDmLNewp
 5IkYdFrKmyZF4ElRZt9DkIU+oQPMw9PIiQ9GXs0963A0Gg/HBP4AWd4vOhjY
X-Received: by 2002:a05:6000:993:b0:483:3695:6ea6 with SMTP id
 ffacd0b85a97d-48c727807eamr963625f8f.20.1791323612443; 
 Tue, 06 Oct 2026 14:53:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d22ec8sm1642235f8f.39.2026.10.06.14.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:53:32 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 21:53:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 839053fc589d76782e799c427b5f9cce59aa2221
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 21:53:30 +0000
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08e8c42140add2409b47792f66c93d19febcecdc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xED6R-000433-2v
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.5]: Move
 check_session_buf_not_used method into the method that free the ...
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
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1251818923777303963=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1251818923777303963==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dg7z1/cy90o="; charset=UTF-8

--Dg7z1/cy90o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Steffan Karger=2E

Max Fillinger has =
posted comments on this change by Max Fillinger=2E ( https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1985?usp=3Demail )

Change subject: Move check_session=
_buf_not_used method into the method that free the buffer
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(4 comments)
=

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985=
/comment/6c2ee96f_dfd03e49?usp=3Demail :
PS1, Line 2276:         if (sessio=
n->opt->pull)
> Whitespace-only change=2E Not needed, but doesn't hurt eith=
er=2E
The uncrustify hook wouldn't let me commit it without this change=2E
=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/9afd2831_7b00a2d6=
?usp=3Demail :
PS1, Line 2453:                                  || multi->m=
ulti_state =3D=3D CAS_SUCCEEDED))
> Another whitespace-only change=2E
Uncru=
stify, again=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/a=
f10120b_b214ca1d?usp=3Demail :
PS1, Line 3106:             "still in use (t=
ls_wrap=2Ework=2Edata)");
> Whitespace-only
Uncrustify, again=2E


https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/854a9a57_0d293370?usp=3Dema=
il :
PS1, Line 3250:             "session promoted to %strusted",
> This ch=
anges the log message and logic around it=2E [=E2=80=A6]
Accidental, I reve=
rted to the old log message=2E While doing so, uncrustify found something e=
lse unrelated to complain about for some reason=2E



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: release/2=2E5
Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20=
ce7626d
Gerrit-Change-Number: 1985
Gerrit-PatchSet: 1
Gerrit-Owner: Max Fil=
linger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Steffan Karger <steffan@k=
arger=2Eme>
Gerrit-CC: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Steffan Karger <steffan@karger=2Eme>
Gerrit-Comment-Date: Tue, 06 Oct 2026 =
21:53:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: Steffan Karger <steffan@karger=2Eme>

--Dg7z1/cy90o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Steffan Karger=2E </p>
<p>Max Fillinger has posted co=
mments on this change by Max Fillinger=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">View Change</a></p><p>4 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
985/comment/6c2ee96f_dfd03e49?usp=3Demail">Patch Set #1, Line 2276:</a> <co=
de style=3D"font-family:monospace,monospace">        if (session-&gt;opt-&g=
t;pull)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Whitespace-only change=2E Not needed, but doe=
sn&#39;t hurt either=2E</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">The uncrustify hook wouldn&#39;t l=
et me commit it without this change=2E</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/9afd2831_7b00a2d6?usp=3Demail">P=
atch Set #1, Line 2453:</a> <code style=3D"font-family:monospace,monospace"=
>                                 || multi-&gt;multi_state =3D=3D CAS_SUCCE=
EDED))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Another whitespace-only change=2E</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Uncrustify, again=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1985/comment/af10120b_b214ca1d?usp=3Demail">Patch Set #1=
, Line 3106:</a> <code style=3D"font-family:monospace,monospace">          =
  &quot;still in use (tls_wrap=2Ework=2Edata)&quot;);</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Whitespace-only</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Uncrustify, again=2E</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/854a9a57_0d2933=
70?usp=3Demail">Patch Set #1, Line 3250:</a> <code style=3D"font-family:mon=
ospace,monospace">            &quot;session promoted to %strusted&quot;,</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">This changes the log message and logic around it=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Accidental, I reverted to the old log message=
=2E While doing so, uncrustify found something else unrelated to complain a=
bout for some reason=2E</p></li></ul></li></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">change 1985</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: release/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-I=
d: I64920ed9f714803604d76c6df6b38cf20ce7626d </div>
<div style=3D"display:n=
one"> Gerrit-Change-Number: 1985 </div>
<div style=3D"display:none"> Gerrit=
-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinge=
r &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 06 Oct 2026 21:53:30 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>

<=
/body></html>
--Dg7z1/cy90o=--


--===============1251818923777303963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1251818923777303963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1251818923777303963==--

