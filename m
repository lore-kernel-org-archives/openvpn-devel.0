Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED9606A335
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DFvM/CAR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aJjNLToq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SHIBAa0T;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=G2TcCD98
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XOfGOAUn/SRSPQ4THWoKxqphF3VQJW2jT+RNALeGFoo=; b=DFvM/CAR/7lDOgqsrUeyjaqlDN
	BXHPvibdwJKiOa64UJs5/xryAIAjEpuo1zuRVqnrKHLZn7xfvdrCXwymiLjo1f+C5cD2iB9pw6b07
	zcaAlij4pyuK4u8aTaLYu3eDN5rf3GtB4lBmvgM1ppRhNviN4XwBjlcrPU3yC4+UyPBo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgwV-000000004An-1ebm;
	Wed, 18 Nov 2026 14:47:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgwU-000000004Ag-0YcS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:47:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KI8n4msLgnMq/HtgPoPNGJwAj+CdsSKUHD6Gv9LI5qI=; b=aJjNLToqQl5By0jXaF+DY4ysAE
 RE3+zw3k0vrQSLD4TPVhX9oZ6pCF7f7C4yGSt7SnL+lIHHKa/lpEeXWWvr1w7Yb741RlM4mWLP/Kb
 GBSbEUkD1A2TLttGAyzECGlBv8QCHk5LHrxIDIL7dvxhw6dtU16hxKCDbh7DcjD12PqU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KI8n4msLgnMq/HtgPoPNGJwAj+CdsSKUHD6Gv9LI5qI=; b=SHIBAa0TIdBKcikgaCtDuSwPAE
 43d0mGq6peRLHmcGvRQ+1BWQ8WlmUiFQIMJDtkpcJAJHYHepaRJGuz9HSkEkb4qx9e1kzYnwbCy7t
 oFowwV3oJ+0k1h98M+zelaL/w3mqbBTt0t8L5p/HFGwXFuVw/B0JXTUtZguGfiiYGE4w=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgwS-000000001EZ-3HLn for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:47:22 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so11262735e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795013234; x=1795618034; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KI8n4msLgnMq/HtgPoPNGJwAj+CdsSKUHD6Gv9LI5qI=;
 b=G2TcCD98x4bb2Vh4hCucW080Wjj/Xe91++IECPcjlKvci3weP3cHMgKp5GmSP0rAYm
 CeTw0PFnazuIQHTQKp+WFkH9Y80B/AAC3h4nxb0ZsGuQ/d10KallvpW8CKraiFvRSPvi
 HrxMHFzYxeErOqpvbwMdKsL1ihPNvcXFhq+/U8fwsJIL2PLKxhjCydjISmma9vRywXD1
 AoHLxTZZef6PO6WrexZidAPZybC0mXR+TmItFbHmMkZs4KWZaDFyEhe7FhSVJZowXKUG
 rHL21ygDtn9Dwyee3LXSIb5O0IkrFwMBmVpkIhQ+88C+brKo/2/wSBQFAKU9o3tCJlQ+
 nW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795013234; x=1795618034;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KI8n4msLgnMq/HtgPoPNGJwAj+CdsSKUHD6Gv9LI5qI=;
 b=mMtFnI6tzVHspCM0AtP/FR4duRgeezkpYTJ+HFrk2Cioy8uHLioQoPGqu1EA/+99on
 PjRkxcD67hdeVOgVhexjY1MfGUnEtrDN+wPRK5HbbgNXoGGkSUjEWCCiuqh69PTBwrMz
 yycdrKbPMIY6/1eq+0a8vY2MS8FWd+MVrgYkjv7RkajfQnulA9A2gh0TTNLCue7YZqHO
 rUfyKNy0chFPkryBFacuIPeOysoiP/++CEmJ93e+/vLHpgWrtQJ+MlIJD3we2og+3cki
 b+SMVIEa7so8BE1KhAot3Fb8Kbtxr0f9mytThcIPMSBq3ZiL+RrnAvNJpz4kvIAJM/0X
 e3xg==
X-Forwarded-Encrypted: i=1;
 AL+hErG+Xqq4PYgWvYXcSEKm6CzmSKoWHKKDzDlK15tFgRXdQFXhOWjuodx76sJur9sIG1ob7ipjaIDKux0xbh+K@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+/NbfBzX5Xrbhp4sgH35gY2uZDvgQZEgqh9255zPQ1dkDZb9mV
 Gs5YDELQg94SFDEOh56/eO4WxDC9kz8NsCWrtQ1BizAEmszgqw1DJtJJEOzpTql5u+nVJAwLQsd
 6ADNEKXtZAGHbuocekBuXZjdx+7bxbBwmdm6uGXgDy7WWI0OkQHCFHppA89OKUmVI1NM2VonxxU
 4MQR9eSA==
X-Gm-Gg: AYBFou0B/5RRZhfDfD11eHahleFC2kAEbcrBJrbkkwsu5ofECiuMolT7LNEIzbVj1kB
 +cNCZCjmGIMNTftAD078DnHzOdd2vSUB0rIpO7orYJax+5fPGBDu9Z8LAcfFBknebOKTc2pSlvg
 b40cg/zn2Gdqt3VowKQVEiq+79LcfyGc894GQ67swJLVCyYRyQxNyEgTx2GfvThDdQ9gpJjLJBi
 HL9wo8t9iIOoHVBLm8Pr3P86SRO9YKfcoyRudE2FsdX0mCsd3tR6vB7+nfH5um5DQqidWjAX6eK
 Hd+LAfw/hTwW/sJs9XbOH0oxTDH4RpDqaVFeuxKS41d7V93M7yNAT4qtj3bKdjbQL9AU2rUdBUX
 r/MOi6WAWEbAup499vPtnx7e0p3F7s9zW8TzpTSzhXpwF6fFRgEteAZb7xClAHU9PlduBKXkr0z
 IUvmAJGsnDilV82odt6jtCdBc7PmtGUtn35QsnzCqXguDb8dm8eDrLorbYryOyNDTEZIBMQf4BD
 W6Fl7xFl3RMGdeyeSqcUwY53DPwaOWoert4/JrFr7BhzK8qinYK7U89IDZAgqUJsn4yvAxaemej
 5jQgFMZRPI9L7qox+/tPQuYpFqqx6VXjTYYL6tqMQfJ2a0pPk4rG/IAXC0utfQThgeBWALdybA7
 FLodgWPCzISHhvE0DCMbEAu/8ARj2jL+Cqo6BUvQuGiCQW5S94dZCPJiUsIzOZgx022ZLaoNzId
 tHJpyyI5zbBstnc2nyixdBEOooAtqVtr/XfGAeTg==
X-Received: by 2002:a05:600c:4e04:b0:4a2:1612:6367 with SMTP id
 5b1f17b1804b1-4bb7da18a01mr47239505e9.15.1795013233414; 
 Wed, 18 Nov 2026 06:47:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2ec62sm4856958f8f.3.2026.11.18.06.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:47:13 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:47:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: a3bfc9f8644faca79e584f82b239f2d7899f7727
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 14:47:11 +0000
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e8bd34adbb32465f108628181fd6873686e7770-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgwS-000000001EZ-3HLn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket_util: check
 the address family in addrlist_match()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1321475784898530777=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1321475784898530777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="94QVAzp0WMs="; charset=UTF-8

--94QVAzp0WMs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail )

Cha=
nge subject: socket_util: check the address family in addrlist_match()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review-1

(1 comment)

File src/openvpn/socket_util=2Eh:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2215/comment/0cb3e10c_e12ae1b5?usp=3Demail :
P=
S1, Line 315:         switch (a1->addr=2Esa=2Esa_family)
Would look much ni=
cer like this?

```suggestion
        if (a1->addr=2Esa=2Esa_family !=3D cu=
rele->ai_family)
        {
           continue;
        }
        switch (a=
1->addr=2Esa=2Esa_family)
```



-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2215?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Change-Number=
: 2215
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 18 Nov 2026 14:47:11 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--94QVAzp0WMs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket_u=
til=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215/comment/0cb3e10c_e12ae1b5?usp=
=3Demail">Patch Set #1, Line 315:</a> <code style=3D"font-family:monospace,=
monospace">        switch (a1-&gt;addr=2Esa=2Esa_family)</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Would l=
ook much nicer like this?</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">```suggestion<br>        if (a1-=
&gt;addr=2Esa=2Esa_family !=3D curele-&gt;ai_family)<br>        {<br>      =
     continue;<br>        }<br>        switch (a1-&gt;addr=2Esa=2Esa_family=
)<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail">change 2215</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic3efcdb7bc4e60a8=
1b9292adfe7f8e22b86e274a </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2215 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 18 Nov 2026 14:47:11 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--94QVAzp0WMs=--


--===============1321475784898530777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1321475784898530777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1321475784898530777==--

