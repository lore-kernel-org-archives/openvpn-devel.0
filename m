Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDE606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VrUuZfmx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IqeG00iH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XyFW7LKh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZfyyCTNi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MiF2ZgFY/G630imRmX0Lx5ct+Q+ZRivpBsKiWqluw2k=; b=VrUuZfmxRE6NmZBz8m9jAkF3Ag
	MEmPl/7/+O+uRY26AdaYrbZ+g/JhkIZ6fSIMzLjNMFeLg7IzBVx6Rve2ssRrgK3kmklxWwyDVYKox
	b6+xFjganbL7AnXM5jIaqKs/ubvB7cPMPnUcXDdO95HT+1cEZ5ZX9s0zzA/5P4KxpYG0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWToz-000000006bB-06Ht;
	Thu, 26 Nov 2026 07:23:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTow-000000006b4-2Itp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FdnlJ62i4m9YnYKZdTNOADGwCgG0bwdxj1rPreZ2yRA=; b=IqeG00iHXiEwjrF8Vg2MsWz3Bg
 PPqzqUmwW6KKQ/4WVLUIdJd9DV9IBJo+hbSyhkzrMXPEV4XKj0iiCXNB9XCcPqQjsfGjbuA4VKixN
 cGwor1cYrrWTz7DjZhK/YLMhswUHIUNsbw8QJm3CwACvb8gmK6BvqEWHZVpeIC6PIWUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FdnlJ62i4m9YnYKZdTNOADGwCgG0bwdxj1rPreZ2yRA=; b=XyFW7LKhUURW7RrfgMkqlQfXr1
 jMgGE/XgjdEEr++Xr6MLygHsdh4rFcVIBdKDQWMxNUECPcsDs6tCQQ0/+FHvg8si7QtI2k6IpQ0Av
 Yt+mGej7WF5PAKtUX5Kp77IWMTR06cMOgunZXgub+iRzdg4ixhPE1BLIxJMTkk7EQ9Ig=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTou-000000004Uv-3let for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:23:06 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso47279055e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 23:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795677778; x=1796282578; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FdnlJ62i4m9YnYKZdTNOADGwCgG0bwdxj1rPreZ2yRA=;
 b=ZfyyCTNi41coEd2zm1kzeIadzLRrGK9NhJINArN2g+ZNjcw4dJqoCuI0YCEhCgq0e6
 FmRH/1+En/lcaiwPNbQfDLaMma+A7kpsC/a74STzvBs43F+ExNupPqQONqKc/yxCIAwt
 WAfxttg76I+NsuEeJufeDFOhZ6h9DrLnkbh4OI+cR4H+zixT9/B2gl2lV6zHbO7PNo1U
 8HUp7OqOx4085gYZF43SmyHHazdtdFcN4VJG/SunTgj9UOmTRHQQlUK7kBmiBDbhpbhF
 puvE1Dsq1kuoZB8wAgNmLRdhMBOYcBwSnLRhTtrDBsHhtsbPtq8T4ohnbwfbYsbvgRr9
 lqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677778; x=1796282578;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FdnlJ62i4m9YnYKZdTNOADGwCgG0bwdxj1rPreZ2yRA=;
 b=BSMnlbM+3tZEU0Gl4copCz4PJNgkjbXrTTBe13K//Imbg9btazwR8aAoY95t3sQQ+5
 ynUIeJRufNwWbS3hJR3YQTooNoh9fdhUG7Pzdxs0+CPN5/ynWu/+mAmu9/faRZ8sS7j2
 dnqfgKod+Q91yLLi8twWqU+4zdqZxbbySpMCDozjXEGhKacRhAOQBGViNB9UwtAXwLPr
 U1FuM3pV5OdcKykckEruSorb0Fs+sCtoYDFlnVGZvDRn1WFcd43AN9mh6zSHCsWL8zv0
 NoITHc8adMh6eESlSNLeBYYY3b498lYhozJBwplY996zrPYXtJBqtaYGqnVuDft73q9n
 Wcew==
X-Forwarded-Encrypted: i=1;
 AL+hErHfWjDaS9bFwxLkzA7eTlq0LXv7o8czJm+6ldUjRSogM7xVNQl2nN+oAAxRa4m2O6sUhMtaDy2RAYzMJQKa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8XPX5cXSOHwd6z3JKrAFUL0jBZazyAwH2ePN5Q6mshbgcWFpYX
 rJ4k4MLpP6/1PIq4SzDXvyz2GgS1xHc8d1uIknNQAjaHakx6uPLWlbTwPznUbTV55jOgLEaQ9bW
 TQ+CBXxryXfLTM8VZ1Jgerdi11oYG8cl/OX5G0dxjEaGmjVAu1D4lm391lx95SJ+6gsE8Veze3c
 fMOCVM7g==
X-Gm-Gg: AZFdTZdzrr5/njUdtQXcqvYoYvug2Sp2w2hpbWX7ZobbjckXZHJxvxn8CghnyaiQqBc
 BFHKdkq1kwA4Piy23+z12FN+uDqhZAqiMM2I81R6faLSu6hkPjf852UClwumuCQmkcTk+59uxPY
 lUY/fR0WuBrJ3mN1XKpk3bCoapaqiqTOBVX5jWVMxM2NDY7hK/wPPr5BwqLf3NaGEUKLgBetG9T
 3i9rSf1gbdXYCaI/O7EGARTWmKIaTJzRnEBpXEspyVk6+EE3xGTBgUcbUn4hgnUsIyhYvpTwIuv
 AgMkJs0084G9wE1FvtoOHTiQ+IZvhCt4eKK7w6Dzs21lSvUTfybjZVlMCKfd/+NV88u9BRHpLZT
 tFmz5z/ErtfnTU4Wsl5klHzmVVpt/VrfI+fFT/JJcufeIg5yeND2Rw0ETqXsjnWvXrQ1lzBhSc0
 uN6tfUHjY1yBdzhU6H4Z/xL8I2hnE0wYsl/bN2lek8RSERPOvuLvCu9diYOR/mHV4I8gT//fq+q
 VxO3kP+vlxyzzv+GsrUWfebO6ZLXDkuJ9nZrNn9/fVH8dR60JC/HaRItc14hxcyXs31ZlH/UnBy
 TBIOGmKkL5UBDsd6ASBdHL471s8bcaDvwbg/guT41PVpSFJETCFFslEzZ5Zb9Ph+lvChExGFK6V
 FIngKBbPaiFpXbvqhs7NLFIRYYgfrscsSBCssxjqKHeOoxHAR7Tj3MN4etkCFhyh7eWzW2lpypx
 T+TOC6CNwRfSJWH0g=
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id
 5b1f17b1804b1-4bb888169d0mr432294225e9.20.1795677778116; 
 Wed, 25 Nov 2026 23:22:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm646072075e9.10.2026.11.25.23.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 23:22:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 07:22:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: b1a80291769a90ec1763a5b2b2120adba051e3ba
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 07:22:56 +0000
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fcabbb103ef1712359f2735c4a56eff73bc18df4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWTou-000000004Uv-3let
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2555337524031505557=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2555337524031505557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cXIqAvs1mQI="; charset=UTF-8

--cXIqAvs1mQI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail )

Change subject: dns:=
 pass dns vars to the updown runner via pipe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(3 comments)

=
Patchset:

PS2: 
Changing my vote to +2 because I was reviewing these in or=
der and the next patch does exactly what I requested with the -1=2E =F0=9F=
=99=82

As long as these two go in together, all is well with the world=2E
=


File src/openvpn/dns=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/234=
8/comment/685c52b3_bb9169e1?usp=3Demail :
PS2, Line 606: dns_vars_setenv(ch=
ar *vars, size_t size, struct env_set *es)
> If I understand this correctly=
, here we take any name from the unprivileged side and pass it on to a [=E2=
=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348/comment/0af1=
9ac5_9a40f4e3?usp=3Demail :
PS2, Line 626:         setenv_str(es, var, eq +=
 1);
> `setenv_str_ex()` asserts `strlen(name) > 1`, so `=3Dx` or `a=3Dx` a=
borts the runner (not just get rejec [=E2=80=A6]
Done



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438=
441
Gerrit-Change-Number: 2348
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund =
<heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 202=
6 07:22:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-=
Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--cXIqAvs1mQI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2348?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Changing my vo=
te to +2 because I was reviewing these in order and the next patch does exa=
ctly what I requested with the -1=2E =F0=9F=99=82</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">As long as these two =
go in together, all is well with the world=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/dns=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2348/comment/685c52b3_bb9169e1?usp=3Demail">Patch Set #2, Line =
606:</a> <code style=3D"font-family:monospace,monospace">dns_vars_setenv(ch=
ar *vars, size_t size, struct env_set *es)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If I und=
erstand this correctly, here we take any name from the unprivileged side an=
d pass it on to a [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348/comment/0af19ac5_9a40f4e3?u=
sp=3Demail">Patch Set #2, Line 626:</a> <code style=3D"font-family:monospac=
e,monospace">        setenv_str(es, var, eq + 1);</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`se=
tenv_str_ex()` asserts `strlen(name) &gt; 1`, so `=3Dx` or `a=3Dx` aborts t=
he runner (not just get rejec [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></u=
l></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2348?usp=3Demail">change 2348</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2348?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438=
441 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2348 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hund=
 &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 2026 07:22:56 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"displa=
y:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>

</body></html>
--cXIqAvs1mQI=--


--===============2555337524031505557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2555337524031505557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2555337524031505557==--

