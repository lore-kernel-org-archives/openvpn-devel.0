Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7303CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACkjClrsbCKzSB9rBNgBqBEWzx2Arj4eQn7wUVnWfTs=; b=FBsoABoGozHdv0UOxG7TwB5S0/
	cPgz59LTyWK5bTUCX3tjdERZWjcXUxTC1Ekh3sqrbps8H7AFlFSRuE2iidySJcbbXaZRY5/oPA7kv
	XBYc/ANTSrzCKcNNa6aU87oTzPK8sfQ6TwFekL2nlHDpfs6qA3pKAgWv5Q0tEzEJjgCM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIPva-0000Ng-7F;
	Sun, 18 Oct 2026 12:23:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIPvY-0000NZ-8M
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fUNZY9b/yuZd0rtD8EJZVRtL+Mu9ehNjrVq5MIpcYFo=; b=GpiTDiZ7e54FFnRwptb83nO9Ue
 P13Batas00DobH6OxrkGPEa7nWQG/4ZW7UbTs2CEqGOI6IBA/XWrdKIUmDmDqPO0oIzZILZl6C3N3
 LV9slKtA/s24fe7QS/SgzUxhHHDBovza5IUihIgWyt7fK9hprMr6gmdBpUxYtf3i0LII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fUNZY9b/yuZd0rtD8EJZVRtL+Mu9ehNjrVq5MIpcYFo=; b=d
 tUoii4PQfcSAo/Zl+Oh71nUHt5pt2NfLamsxs7CiVJSVZNjxKYXvrqQBnP587upKssigVxWFdFtl6
 MiAVPwkIOviH00O+zUHXJs33hHe18aAFfD9pxXBngZsZa0tyTVpt8z1Z3mSe2CR4DVplNv08W6uyS
 Z7VB0eDnVzMuiBgU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIPvU-0003ep-Uz for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:23:45 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso15180975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792326218; x=1792931018; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fUNZY9b/yuZd0rtD8EJZVRtL+Mu9ehNjrVq5MIpcYFo=;
 b=RgWFgYZTfPojgH3OOcsyTgsWIi69Qsl1XYWt45pzS2ScHpzrVxXSu+xIHfWNlxe7dT
 36VTrkB3RqvDAhkupaQuAkD2rc5gsPxrlVH5uCHPzDCR/Kp9Z8O7ZxzUVeUwOpKu+i7s
 P3vSFnGj6gFmOdm9PIbLC3kQuPx/4yNm6ez4sOianYeQvfVYsf4p1DIlXweypAJ7JnJZ
 /veSUJxfduZnwDXaONFEqqyAPhspiXEB8UgCxchXRn7MNxyp7gKW5uu2V90uhdlv+cC0
 PMBoZwgCB6JvAJKpl3bM9Zv+d+hgxxp9MF+VZzL6e7n6hG7mdsQfPswUkdj8MH4ZaLdu
 4HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792326218; x=1792931018;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fUNZY9b/yuZd0rtD8EJZVRtL+Mu9ehNjrVq5MIpcYFo=;
 b=jf5E608YXF8ZRouYjETNufLcVk3Dig0mk4AuC9XQAPqwKhrHZfluB/9jyb4RX5gk93
 cYIT9Fbf0aab32yICZDccEzRxUWUS/CKux7iD54h7bKZwVAxldtkBOgzJOdsoN8zCaHC
 k0Gej61a3p8pbe9LDqxXSf0hXJjH/QQ1VLQKgb5cVEB+T+buZBZRTPvcTEkAG83LJPOX
 xRAD6jR216hsBvaAZ8/NfiPFMxTShtkJOSCdzaMX7TrSVEJJyV2lcJUS1ACNZPQi7CA8
 oll+Uf/fQ0boWT2twW+49kUeEkQzzt6WCali08zlNHshzz+Jbw580aEMyA3Su9WUDTEF
 xImw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcNVlzDNewWPNp54f+adqQKgqhOXE0+I5hMOxi+KMII88E1JcHut2kJFionpNydOxI7CghaRRD6xBhDu4S@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI7KwA/V5zvBdPwkzSJA7F4xp41OnNQc1rBhBQy8Ind46omH58w
 fwGw7Z00wTfpROyn2dIGGDxIxt3REYcXJOUrap15az18dwcpzW6Kgc/MWSQT3mxT3wpBuZiStWR
 kjL2F7J5LgB161knfnt0CXR53WemBjLiWnBunoydDPIZx3WfLFd+CSPPuX7zgwrpxL0fx
X-Gm-Gg: AYBFou0dL6fY+XRbgwiA4yF3lv4T8j4WXd5oRacno3u1htiYK3xJiMlPpanImUwDGhi
 jpG5VlCUJIIlqz40rwYG2G8n3ihbT3yG99q+bLWJI0z8rP0x3lj7mtay/ex3Z6SFzKsT3RBxhb6
 q5V0a9jn3k6ftpPkqcU1tOcmK4diZc3GU1lg5tbBQZC4KB8aNBepGw3k/9cGtnxEs07pNT9vI0c
 DsMRJFzXpp/9RYJmYu6xZyFDHsHZDPBY84wjNFzL/TcDX3MppAp1HkU/Sis6OR1EvetGdXQP6YZ
 M7HxqQBUaNGzfLDRJL4lUepcBygk+n5U41XNciKirz9QSIXo4aMmISbK2ZW+JmfzO24EftGt0wU
 BM67MWVIONlSwn+pCRrhuRm2+e+l8M4J0IIn5udVgUoLBmmiDsLHojmKiQeRoaPQysaAz43+ueG
 QkaSfsa7Q6ANpEQI2D7RaDL6vzkVZp1D5s5siyF2Gk4g1dKGlkPnY8Ec9EPdXYsp/c9iiB0kpiP
 KshmZ+X/uf43KY+K8JtoAVE5FZpJZJg7vCL2BYZgEFsUzv5V09AmciMQrqqCENjeYCOJV5gex5I
 QyVVxk+N8IYyCGV4Rgs0t1ZtamgvfMcNDHWxcOTZPDhCxRRMLQz0EIfOJF3m
X-Received: by 2002:a05:600c:5254:b0:4a1:e57b:667e with SMTP id
 5b1f17b1804b1-4a1e57b68c7mr19210825e9.4.1792326218296; 
 Sun, 18 Oct 2026 05:23:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b35a6sm274840945e9.6.2026.10.18.05.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:23:37 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 12:23:36 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 12:23:36 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47cf02694c71881bef0dbe5df2b54f1413d334eb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIPvU-0003ep-Uz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3184203800822161421=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3184203800822161421==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qN59GgzqAG8="; charset=UTF-8

--qN59GgzqAG8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

P=
S1: 
> ``` [=E2=80=A6]
One fix seems to be:

```
--- a/sample/sample-keys/o=
penssl=2Ecnf
+++ b/sample/sample-keys/openssl=2Ecnf
@@ -15,6 +15,7 @@ new_c=
erts_dir =3D $dir                  # default place for new certs=2E

 certi=
ficate    =3D $dir/ca=2Ecrt           # The CA certificate
 serial         =
=3D $dir/serial           # The current serial number
+rand_serial    =3D y=
es                   # Use random serial numbers
 crl            =3D $dir/c=
rl=2Epem          # The current CRL
 private_key    =3D $dir/ca=2Ekey      =
     # The private key
 RANDFILE       =3D $dir/=2Erand            # privat=
e random number file
```



-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2010?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerrit-Change-Number: 201=
0
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Steffan Karger <steff=
an@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Sun, 18 Oct 2026 12:23:36 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Comment-In-Reply-To: Steffan Karger <steffan@karger=2Eme>

--qN59GgzqAG8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Steffan Karger=2E</p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2010?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
``` [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">One fix seems to be:</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>--- a/samp=
le/sample-keys/openssl=2Ecnf<br>+++ b/sample/sample-keys/openssl=2Ecnf<br>@=
@ -15,6 +15,7 @@ new_certs_dir =3D $dir                  # default place fo=
r new certs=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"> certificate    =3D $dir/ca=2Ecrt          =
 # The CA certificate<br> serial         =3D $dir/serial           # The cu=
rrent serial number<br>+rand_serial    =3D yes                   # Use rand=
om serial numbers<br> crl            =3D $dir/crl=2Epem          # The curr=
ent CRL<br> private_key    =3D $dir/ca=2Ekey           # The private key<br=
> RANDFILE       =3D $dir/=2Erand            # private random number file<b=
r>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">change 2010</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic36123c5a4a2b2295ff=
df47174e2aceb9d17d668 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2010 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=
=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 12=
:23:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--qN59GgzqAG8=--


--===============3184203800822161421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3184203800822161421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3184203800822161421==--

