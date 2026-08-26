Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AD6C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NlXG+YXWsNQCRKC69HNKKtSgKIAQ/odCHpOLgcMat/o=; b=GkwQL+VdCjDzAGuF5qh7yyQ7yi
	AmGTBps6odZ4Raiad/IZf8AUgIJBHZfJ4gpHXDN8EW8OOij0PyL04/iMraHFbel5Jxwcvnoxt7M+8
	qcsrwp1OPuVRLTVcQP/m+OJo6RBRAyhezhe/lyYXjrg3RsA7jOkcSfoYmRu+HCV6m2pU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGU9-0004J2-0a;
	Wed, 26 Aug 2026 16:28:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGU7-0004Iv-72
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zpYz9j7gT77Tz/3e22TN5GZ2/02bJZmBdLnDc7Ff9W8=; b=fMOaZ1WiHWdVwCXgcsPkwe1uTA
 s5cIxsYPSY0Hgir+U7IvAolaqQdmSNv/bGycDLmebDZfPgEQV4HpgrCOdYQp2UQFhII6ypnLYresA
 5SZB+xSsmoKQe+S1tzmu9wqbNCFYRCURoR9/w2EUj6Ti7W4EmGhNK/4TgSKxVxzcjpus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zpYz9j7gT77Tz/3e22TN5GZ2/02bJZmBdLnDc7Ff9W8=; b=f
 caRfjNbGqEP1hrX7jp0xt8KTdTjm48TN3OpHiAZej4LLvzxsVDFZ+vE0ltvYlGjj2S1DRf2xDeuHK
 YEjbjdLLDJk2CY/zqLW6Fri0FdHCi+LOAOWvQbfne4gchfz8IFZjR4tBiU7u1ZqNB829m/BwKWyvP
 V2dPN/V1lOacpTdo=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGU6-0001dT-4k for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:28:19 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso1920964a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787761684; x=1788366484; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zpYz9j7gT77Tz/3e22TN5GZ2/02bJZmBdLnDc7Ff9W8=;
 b=FtIyn+gc5LCUB5V+VxyDuCR/uLmbBOvmmbg4DHDYtBI/O+SpM3aQw6rne+FY5Fv1h5
 eoDOWvg7Fb9byw53C+1Cy/Ydhu64LSDxPIwVfEOkIbyNDTx6Vpt1xle4mOsPVqlgA4ss
 JqkbPODj2urE0piyB8gF1ssq6HdewMDJAQ8/dlL4746ZqtxZi5NXyYPYVcv7QUNdfz08
 6qyEiHiUuTSLaYUUhnFtmIA+CPVAe8ruvXeW81gEqfGj2v956hS4PsM7kCV7gWtGoueK
 LN2wuCY7rXzZTkC5q1Mw2byKG4QF+XUYGphgPxJyKI49A4Qz2X1nqL+JIXILVVc2Yknb
 5gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761684; x=1788366484;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zpYz9j7gT77Tz/3e22TN5GZ2/02bJZmBdLnDc7Ff9W8=;
 b=tDm1KvALVhgVd0iyvTMTkGp5SFQ9uP0nqBzIEpae8vnK71FLQPOcNS+o+7n4uIriIb
 2rFD2wMprPn4J/Rf9a/R1F0odctCzPQjfE2C7ImM/9M/IlJdzCJQ+vugLr/D0LoPUZSk
 KsMMq6SurPzDk7h44MXgsmRZ1D3MIppg5JVlPllNIsAMmSbiXDW3lXaoMFWiS5BUiCvo
 LhlUBVjZdvMceYcBXo8Y7iL5Ao4loFkDAHkyH56neFUCoZ0nWRW2L0kTK/ZonlWmJA5U
 kYQODQX4GF1u4PeqKJWXMRc6AFLheA6q5XhJBlrqXa6Z7pIwfFnz2dLRkLk+ZxevufRM
 Erzw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqxzqa0n1zvlqchFccwEQjF+OSh8AJpsrJBrnJe01yJXnXR1GNONbqMkip2pBXntbOzSRKBnltD1G4Nix3q@lists.sourceforge.net
X-Gm-Message-State: AFuF++ljECgJRabP/FfRH3o8b4lsOihu6mu6YFM7ro4vLmddPm404age
 XIRa2g7C4J1M+a+2slT5ioe2h+wBQfh2pHgwPG+wvdfvSgmF6E1+mjNhFtAqnqPaA7CgcEQPAHz
 B3t1pmoUZ+KHcBTcomYWDjjdZTy4eRYoTEzXZx0NE023SaBUOZGYnaK/fyejiXWUE7kbxJbw8l5
 QeRchF5w==
X-Gm-Gg: AR+sD10daBHRfnhsS8j4Sq5l/RP2eKcD3+pI1V9Hxek2sc6yoo5bWqzVj4eU6qJjoKs
 997tXTO8q+uyLWa4sG5HDnDqBJ6MMRUURwvIhc/QeWcefcYkOAYViJAbdMjDNpykqUT073drh6k
 HIM/j5EooeSymVdBR+DiDt3EvPBQlCzKE/3lhSkeowEhgi44R+cHYuHyYhyZOYUNz2I1quFnqyX
 FvB+xPEhlTEQDTx9KTnt7v1LIpwkvv8l5cOKlwSuMq3IJse5F8JD1D0LQiK2kgjX1z6UqwiSCux
 W39pTOLxUnKNtfxJucyDK70l8ylq98KxQWLmqYBk+XY6gYKQHsSh6Kbpr8PPb1j3briYxs0+8YM
 eku3OYqBOwtMdQU720DbLU+vRxcKu/wZRDK7G5JilLZBkH4tp8EKPOJE6bfm0HdAWpm5tpzA5Hj
 ak7ieNfUWXWA8tTBpUSzrELOyWBhNbdWscu3AOZE0szY+7fJsyckViz9UUtcLBHXtKwcZ7HbI20
 hVnpHP+M/R5u7Qo2Kyh9+63Wisg1pqdZD1A7RPKxVsFPzTXxLs2nlJVRVp7DrYLRiOTIoYe9S1z
 eGIdLlIS/C9oi57eq4Zp3O5q1P/mv6//bZREj/eyc8KF5KjouYA=
X-Received: by 2002:a05:6402:21d9:b0:69f:4c65:86c2 with SMTP id
 4fb4d7f45d1cf-6a5df5cab27mr9527361a12.2.1787761683761; 
 Wed, 26 Aug 2026 09:28:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1afcsm6870595a12.8.2026.08.26.09.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:28:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:28:02 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: d15ed8dc6abe2c8b89e8b92a64c461ae9ee1024f
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 16:28:02 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95f0f8100fddb3c555262e41d64a34c61d570a81-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGU6-0001dT-4k
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4407488416550567127=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4407488416550567127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aNHCySyj0Gg="; charset=UTF-8

--aNHCySyj0Gg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1852?usp=3Demail )

Change subject: Add unix-script functionality=
 to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 8:

(3 comments)

File doc/man-sections/managem=
ent-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852/comment/=
9af954f4_383728c3?usp=3Demail :
PS8, Line 33:   variables :code:`MANAGEMENT=
_SOCKET`, :code:`MANAGEMENT_PASSWORD`
> The user variable is missing in the=
 list
That is because there is none=2E Our management interface is password=
 only=2E But the text mentioning a user is incorrect=2E


http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1852/comment/29c5b029_6f84605e?usp=3Demail :
PS8, =
Line 143:   :code:`SIGTERM`=2E
> The other documentation and the code says =
"SIGINT", not "SIGTERM"
The code says SIGTERM:

        if (man->settings=
=2Eflags & MF_UNIX_SOCK_SCRIPT && !man_password_needed(man))
        {
    =
        msg(D_MANAGEMENT, "MANAGEMENT: Triggering exit on unix-script disco=
nnect");
            throw_signal_soft(SIGTERM, "management-exit");
       =
 }

        if (man->settings=2Eflags & MF_CONNECT_AS_CLIENT)
        {
   =
         {
                msg(D_MANAGEMENT, "MANAGEMENT: Triggering manage=
ment exit");
                throw_signal_soft(SIGTERM, "management-exit");=

            }
        }
        
I tried to reword the section to make it =
better understandable=2E


File src/openvpn/init=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852/comment/9712adb6_31be8957?usp=3Demail :
PS8, Lin=
e 4382:             c->options=2Emanagement_addr =3D platform_create_temp_f=
ile(
> Are there any "insecure use of temp file" concerns here? If we ignor=
e that actual file and just use  [=E2=80=A6]
You could monitor /tmp and the=
n theoretically create the socket in the right moment to let the client con=
nect to that fake socket=2E I replaced that code by just using a random soc=
ketname=2E So we don't have to worry about that=2E

But if creating the soc=
ket fails, OpenVPN will just exit anyway=2E



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit=
-Change-Number: 1852
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 2=
6 Aug 2026 16:28:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Com=
ment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--aNHCySyj0Gg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File doc/man-sections/management-options=2Erst:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852/comment/9af954f4_383728c3?usp=3Demail">Patch Set #8=
, Line 33:</a> <code style=3D"font-family:monospace,monospace">  variables =
:code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">The user variable is missing in the list</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">That is because=
 there is none=2E Our management interface is password only=2E But the text=
 mentioning a user is incorrect=2E</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1852/comment/29c5b029_6f84605e?usp=3Demail">Patch =
Set #8, Line 143:</a> <code style=3D"font-family:monospace,monospace">  :co=
de:`SIGTERM`=2E</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">The other documentation and the code =
says &quot;SIGINT&quot;, not &quot;SIGTERM&quot;</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The cod=
e says SIGTERM:</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">        if (man-&gt;settings=2Eflags &amp;=
 MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_needed(man))<br>        {<br>=
            msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering exit on unix-scr=
ipt disconnect&quot;);<br>            throw_signal_soft(SIGTERM, &quot;mana=
gement-exit&quot;);<br>        }</pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">        if (man-&gt;set=
tings=2Eflags &amp; MF_CONNECT_AS_CLIENT)<br>        {<br>            {<br>=
                msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering management e=
xit&quot;);<br>                throw_signal_soft(SIGTERM, &quot;management-=
exit&quot;);<br>            }<br>        }<br>        <br>I tried to reword=
 the section to make it better understandable=2E</pre></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852/comment/9712adb6_31be8957?usp=3Demail">Patch Set #8=
, Line 4382:</a> <code style=3D"font-family:monospace,monospace">          =
  c-&gt;options=2Emanagement_addr =3D platform_create_temp_file(</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Are there any &quot;insecure use of temp file&quot; concerns he=
re? If we ignore that actual file and just use  [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">You could monitor /tmp and then theoretically create the socket in the ri=
ght moment to let the client connect to that fake socket=2E I replaced that=
 code by just using a random socketname=2E So we don&#39;t have to worry ab=
out that=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">But if creating the socket fails, OpenVPN will just exit an=
yway=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e=
24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 26 Aug 2026 16:28:02 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--aNHCySyj0Gg=--


--===============4407488416550567127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4407488416550567127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4407488416550567127==--

