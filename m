Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92124606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XEc2C+v4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LnObfXOp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b5yEWTvK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UDg1OeiZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=82FW5ALzyjV+wbBc1mmaUNrj3ikpOFIdbGpEFXgwZ/8=; b=XEc2C+v4Esg1Y2zw0WS737/LEr
	Yqjchj3rI7/IJz3nASaqH0EfJhJJLlfX+GToTmMP6HqKIwEaePgFGf6aa8xfTpIoln9bL+vkdzK4d
	ZPvq0mAMtytXCOYOd4JiDVCPHEJGUcyExh++Oj0s0/D2wx+tYLemmjI6GydTfRenihgg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTb4a-000000000Lp-1S2V;
	Wed, 18 Nov 2026 08:31:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTb4P-000000000Kr-0g93
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OOlhuk+xpOKORDS7JnOvTLDWYac7ODFN++jT7bm04zg=; b=LnObfXOpiuixzeNwxkj1XzV3av
 0V/fcwHXKpQNSnOqbn4vH+dYCLEfyKn+VQthIKUicfBqCqVWdE4RgG0vTR6Kf0CeR9MPx2YJV85SW
 VZTVfnBqw+Inz89zkinBQPU1mOGWOlAV38L0gzTBqBvd8R6D8/OOM5uA/xdVgI1z3ysc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OOlhuk+xpOKORDS7JnOvTLDWYac7ODFN++jT7bm04zg=; b=b5yEWTvKwgoWbJH1WKDft8sfj1
 /gJ7LJoCo7rD0c3PKyRVVZ/HiEbLLK+15guKQ4+rrTkPjVNukvIyjfUdBaql3JCkcMtAPxJq6Yr8Z
 il9GAt4iG17bmjArzGrYHPPmYS9tcFgZhhjl6sDHMk9Z4IHVOC4HHVBorgPe8Ac+PWjE=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTb4N-000000001Be-1aVO for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:31:09 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso447888f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 00:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794990661; x=1795595461; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OOlhuk+xpOKORDS7JnOvTLDWYac7ODFN++jT7bm04zg=;
 b=UDg1OeiZeE3YXNiIbAs3mzCzdfzNEpc+IKz+Qn5dNbBUtvW6gdN+djVHAz1GDHEsVO
 vfsu7itBKzIiIlQALQF/Dok5qMKAx8ffXmx2JUBl7YclCv7XFD3txSSaNRaQ+5rcMVsN
 k9qV8cp0rt1ODkhfFXRpbcghOdKD/58FA1wLalHqumKwFQXMhFtEQa3IEbWhD/x5sFLF
 9t7jPmyjCSnR8cJAwBKMDoOUzu4GsLnl2oh7yYwDLuMKmjx/c6n86OkMdcLZT/2rDsfF
 yJSDzQPz2qC00UmmxJDbfPIf4UJ74nWMT5Ngt3IYllGbMdsuRgoptR/AV60LlArQbyRk
 CHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990661; x=1795595461;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OOlhuk+xpOKORDS7JnOvTLDWYac7ODFN++jT7bm04zg=;
 b=PIorPXO6CbcYkXXl6JmVsoFa8vmGhS//HSxMWPVtzqAu377CP/r9L19A7r7t/lxYRc
 PivDzeEJjQcBVUtvFGIOqQWsxpYEn0U18mRyslSE+W7bbGFWmSDf0twp+P3CTHNLPsy8
 HvCwPl+2s65T1APa5kDvXsvA9ZhSEh+rDcdyIuKxp1P9aFw6Jr+GgLLCOHn6spZpYVRv
 hDKNalcpnSxnUkkFhUBVxUW45w3xamu22Cb44NCtuhfKCNhAlpVTsNNrSQY+RWiqF68k
 YGgGIC5rXq8RNv4GX3Ypz2KZpsQhfhgSJjHR8AOuWltly/qGaSVKU1Km/fh6FN4V+sPh
 V37g==
X-Gm-Message-State: APuU4Z/229kKDnJxBUydM0W1rmIt0JhRbYOzymW5iZfjJI5/TBD5pJjT
 xuDnhrd5GbxsLdK3+pXY12k6ftU07RBseQCLed6vipnahyeCLRy/UBZTZRpon+0QTkS920IdBRx
 z3yc6fsCHe54LBNGyxbiy+XFRvBIm4m6VneKwY9UZZNp7Ia2QGy1eK58RzNaxyw2jeWrbhQSMly
 gKCloNAA==
X-Gm-Gg: AZFdTZemYLj63XdlPsnpNFGrn58zLgfhXkA/PyDnuigtIsHRg3mDQxyoLjgW9rujYtc
 5XMD4gQKToJqpCA2wJ+hGcEJ2yLbVfRTO6wi+KBed/3MCY8MzauoXZrvh9/NE7zWNu9hp9wy3WX
 FN+xKIqIZyHqRBNwxKgKRZfI2H7PV4BTBFlC988OVWl/Z9bl2JYkyoR0cxNNmnKrunbhkngZU/x
 0IUONNEtMSpFyTRw2cuDr6s0YiUzM170wmybQ+8WwLKcXlL1z5b8Vc7QorAalEcAJF7Wb0er6XQ
 CQKf8fTh9qY/FnBiKIhjRHsgMXi9aZwQS/GgpVgn5SKky61DY2/lF42HrYnaj5v2dICBgtWKUlb
 QB09gBvVafd20uvYUqVBVP7VyenjWHjTBr2b0OtbnwIqYjVaA2PE5GI6/WmqXFTDcxUg5ZWh497
 CPnG6eOVRD1FopETri5gCxaM+10wwCloJ2JEFuulrSGIjKQ7Pt1pgq4vmYHpqMp9Vm1rXr/T4y3
 ljOMB3UG5MoTl0/OJT8RI1SlNXzJXgjDMPp6YfSohweMIvIGtA4n4/yaHnCX2jhh9HUHJnJ8LiV
 sNDxS7iNTCHR77z47GgS/kfROXp3lx3fmO3p8U2HTkzCqbA7A7GwRSC7SdpFcwp25wfRWYOEe6F
 j/lA/tfxXDmN9qH818uy4HTp6Ia/H6mz5prMNxenpe4P7yu2dqRc5p+iifRyaLdC/yec0jnebzP
 FbGdgzEMLzcVr/5PI=
X-Received: by 2002:a05:6000:4102:b0:48b:118e:7454 with SMTP id
 ffacd0b85a97d-4a639ff5e82mr3341686f8f.31.1794990660429; 
 Wed, 18 Nov 2026 00:31:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65560ab70sm3645202f8f.30.2026.11.18.00.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:31:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 08:30:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: a3bfc9f8644faca79e584f82b239f2d7899f7727
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9366c93f8d76747eb376feca88b1d6ab28f2f194-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTb4N-000000001Be-1aVO
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6790163558316649347=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6790163558316649347==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lQqIwoD40sU="; charset=UTF-8

--lQqIwoD40sU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2215?usp=3Demail

to review the following change=2E
=


Change subject: socket_util: check the address family in addrlist_match()=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket_uti=
l: check the address family in addrlist_match()

addrlist_match() cast each=
 remote list entry to the peer's address
family without checking ai_family=
=2E With a dual-stack remote list, an
IPv6 peer compared against an IPv4 en=
try read past the end of its
sockaddr_in, and 0=2E0=2E0=2E0 matched any IPv=
6 entry=2E Skip entries of the
other family, as addrlist_port_match() alrea=
dy does=2E

Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Signed-off=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/socket_util=
=2Eh
1 file changed, 6 insertions(+), 4 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/2215/1

diff --git a/src=
/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index a1a61af=2E=2E0=
12bded 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_ut=
il=2Eh
@@ -315,16 +315,18 @@
         switch (a1->addr=2Esa=2Esa_family)
  =
       {
             case AF_INET:
-                if (a1->addr=2Ein4=2Es=
in_addr=2Es_addr
-                    =3D=3D ((struct sockaddr_in *)curele-=
>ai_addr)->sin_addr=2Es_addr)
+                if (curele->ai_family =3D=3D=
 AF_INET
+                    && a1->addr=2Ein4=2Esin_addr=2Es_addr
+      =
                     =3D=3D ((struct sockaddr_in *)curele->ai_addr)->sin_ad=
dr=2Es_addr)
                 {
                     return true;
         =
        }
                 break;
 
             case AF_INET6:
-          =
      if (IN6_ARE_ADDR_EQUAL(&a1->addr=2Ein6=2Esin6_addr,
-                =
                       &((struct sockaddr_in6 *)curele->ai_addr)->sin6_addr=
))
+                if (curele->ai_family =3D=3D AF_INET6
+                =
    && IN6_ARE_ADDR_EQUAL(&a1->addr=2Ein6=2Esin6_addr,
+                   =
                       &((struct sockaddr_in6 *)curele->ai_addr)->sin6_addr=
))
                 {
                     return true;
                 }
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic3efcdb7bc4e60a8=
1b9292adfe7f8e22b86e274a
Gerrit-Change-Number: 2215
Gerrit-PatchSet: 1
Gerr=
it-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--lQqIwoD40sU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socket_util: check the address family in addrlist_match=
()<br><br>addrlist_match() cast each remote list entry to the peer&#39;s ad=
dress<br>family without checking ai_family=2E With a dual-stack remote list=
, an<br>IPv6 peer compared against an IPv4 entry read past the end of its<b=
r>sockaddr_in, and 0=2E0=2E0=2E0 matched any IPv6 entry=2E Skip entries of =
the<br>other family, as addrlist_port_match() already does=2E<br><br>Change=
-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a<br>Signed-off-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/socket_util=2Eh=
<br>1 file changed, 6 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/221=
5/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_u=
til=2Eh</span><br><span>index a1a61af=2E=2E012bded 100644</span><br><span>-=
-- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_u=
til=2Eh</span><br><span>@@ -315,16 +315,18 @@</span><br><span>         swit=
ch (a1-&gt;addr=2Esa=2Esa_family)</span><br><span>         {</span><br><spa=
n>             case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (a1-&gt;addr=2Ein4=2Esin_addr=2Es_addr</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    =3D=3D ((str=
uct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr=2Es_addr)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                if (curele-&gt;ai_=
family =3D=3D AF_INET</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    &amp;&amp; a1-&gt;addr=2Ein4=2Esin_addr=2Es_addr</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
   =3D=3D ((struct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr=2Es_addr)=
</span><br><span>                 {</span><br><span>                     re=
turn true;</span><br><span>                 }</span><br><span>             =
    break;</span><br><span> </span><br><span>             case AF_INET6:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (IN6_=
ARE_ADDR_EQUAL(&amp;a1-&gt;addr=2Ein6=2Esin6_addr,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                       &amp;((=
struct sockaddr_in6 *)curele-&gt;ai_addr)-&gt;sin6_addr))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (curele-&gt;ai_fam=
ily =3D=3D AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &amp;&amp; IN6_ARE_ADDR_EQUAL(&amp;a1-&gt;addr=2Ein6=2E=
sin6_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                 &amp;((struct sockaddr_in6 *)curele-&gt;ai=
_addr)-&gt;sin6_addr))</span><br><span>                 {</span><br><span> =
                    return true;</span><br><span>                 }</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2215?usp=3Demail">change 2215</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2215?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2215 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--lQqIwoD40sU=--


--===============6790163558316649347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6790163558316649347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6790163558316649347==--

