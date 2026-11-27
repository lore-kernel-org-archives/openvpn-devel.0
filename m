Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72B606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I9Vq3fvK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ExbseXi1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HPiN+VYt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HDPDyVDU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SSCkEbd/IB0XcLu7/fLmGqIEdI1aOas6JiT16/+tplc=; b=I9Vq3fvKYNSsgHCRMWtsUWgXyt
	P78UbVDISwMUJ42fT7gY2xHBx4aWZZVCnmHZenjqkxoL3c6XE5OrMy45T11VpycDIQXeDDWfP1o6J
	z5I30X4lB9bvHwRzfsniWanR4fx0r6TbsvAjb0Qsn2R7KoJdMT+wleTB2LKHGgZVPdTk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxPg-000000000XD-265s;
	Fri, 27 Nov 2026 14:59:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxPe-000000000X5-1E08
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UnDyJacmhwusmFX2yAZ1Q1x69x10upmWyYzme3WbtQU=; b=ExbseXi17OBd1SDgtqCRlk9wok
 Jl51HPKx2gMIum605QcYdEzwMkI0hz9oE0TOevnf/vSgN/mu4Jrfqb1Hv/meKPEeaZEvSxKjR5DAB
 m18whrFdgoFNuT405kZkHEqBDRnS3ln2x4EePL6H4O4vMjwVIlT1ki9RWi0c7l4lbhOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UnDyJacmhwusmFX2yAZ1Q1x69x10upmWyYzme3WbtQU=; b=HPiN+VYtvKnWrYnpXhhQGgBBnn
 XriIDpAwLDIgDndKBPjPgsXGc4f4H+nOjk8Lx82vUMmRVlR79hynNtj6lWp6uHgi0Bj1U6MD7Fvfh
 GNHwjx8d0B0EoU5W0IamVewr4162jzmZjiNeE56CkEpTOjF1H4xrtyiEFvjZJ1Oix3zk=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxPd-000000003e5-2alj for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:58:58 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so4888927f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791531; x=1796396331; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UnDyJacmhwusmFX2yAZ1Q1x69x10upmWyYzme3WbtQU=;
 b=HDPDyVDUvT/ET5aKVY3qW0suwM+Ic56/zUipislQBbEfRMiW7fSOLScZRAYpCmnK+h
 qqy24MVi7KbBfvibSohebVAeifMzsO0Mp3gt0QGVOMacQLhjhJz20ebUuJBOKIO2dNjA
 w5/YDEuCuqrxsUAud1UpRv1Gux92aTGfHyu9WIGqIQkFTZ0t/wtBAkCWUZdPwDix1/6V
 rRiH3PVUXsVZymiRZU/jV86rxs/cvOx5XsvffF952SW8WDmI1P6rOCE9fUliL+T7C3IJ
 36Uqx12aK4HEQfZ58dpndzEreCWxv9f1jjk9q3eR997S8oJlTC35kTnKjuWJtMZUzKdz
 2Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791531; x=1796396331;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UnDyJacmhwusmFX2yAZ1Q1x69x10upmWyYzme3WbtQU=;
 b=Ha5u1NUCqGXHO7Nz8oV2M8+RVrGU6ZlEqsw8eBC2AgCzOqrcfO+infAsqhtYh8nky+
 LutlVabGxBwbt7hajoexkIHnzyHX9Zy4L9WFk6Fy/Q1WOJa2/Dss9FlV8Q0czaTJf1c8
 zd40Ly4mlilJXkfIJVVjXrDSAD48reBDVQmTxR4PvGLjH2q19Znw8MGtK+9LvvIxPuET
 swJVE76LWSE5WyPQa+6wulH/M4iIWa39jCQWNX4y2WQXb8qp+K4fd8QW+FdqcsBQlE+s
 zH/Za/xHuq/XF4kr+PTpebFccmpTSG9Dge25aPfWkro4jYQ/Z7xtyuksnrc2Wzh2aiDm
 pKHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGIPuVPC5V/aC5hPUpyx0Zez8CKw6xB8ErMhuMhn4kaTOY7iuaItwsJ4M/m8BfCkZX/Wcx09nvd4yqAoQD+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9NIVpaNa12sMVOmYteGBKs2TeRNDLh+TkQwqfJ8KdBVbcq5vzn
 qiPtqQ4Q9ECizSgt1YT5X4xzoVLpUUlVKJp0/hILEYjybUGb9i5MlRKHLTH98yDmywuV/1POFvm
 1EfokLy5DFOGH3HmN9CuFP80TYq92Cs9v5MumOhMWXpVrtsh5pRzIo+cwaBXR8BSnT+Ik
X-Gm-Gg: AZFdTZc7JbeAFAQ67vFnKQTYniMqpITsgm5gkeaUPXe3YAEZU8ckHHvK4oMDsKk07fr
 fJBCrQxIJwiKXuwX0bATfHdoNAKqOIF7VIAKq9AFGce/clpSyp1/myzQ4js2vScVtQVqqNebrzE
 Fe7tKrScMMLVqp0L93WTeJE++l/rdmyQoj5ECcRlWFZEI6CvKw8gB05cHfWuxfmWogDsrJ8Xe9S
 5JmyT4RVUV8fJZ+fZxW63dUqRqpKswH1I2eW71YOboFJjAgi6qM/YYbh3jtUsIlS+vx4kgAeUhb
 8zNuBErYvoKrBzorT28SDsZInVONzyhWqb+IHrt4JZtHz7vLJa3EBynkShuiiI0UgrgPU0iXBkT
 4d1+R4kYkhjJADRln2zyLIjuAkZrxFbI6oPPQWQrFEiJK2SX42jWONzE7FcjzZxOJAzhYcG8kyY
 OagzkcsebWGihudc24fjmkYyO7JKaUO1SSjt8wsaHBGPCjpE2I+3Zw0EyqRHkG8O61CJdGgxmSf
 1OUu3iwYQAt8Vh8ACLJ7KxmaoiJ7KqXi6FrIFn6PqjaK5EerqsDGnRQAIXMfmjvgSD5C1xnGhIk
 NEPZ+hqGyh0lStGpQzammIzmMwycRYqUk2siZGx59p+e2Mgv4sEKj303iKETUP1qWnoHXyel8Ht
 pmamnM19bnG085r6U59W0c89VaRf011qXst4NqAzOBNu3ITZHJLiE0K3N3Y7gGf360gVfLNi6az
 CeL75qYh76MARyoWQ=
X-Received: by 2002:a05:6000:2c09:b0:4a6:4687:2cec with SMTP id
 ffacd0b85a97d-4abacfea516mr48539861f8f.5.1795791529839; 
 Fri, 27 Nov 2026 06:58:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm57818169f8f.21.2026.11.27.06.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:58:49 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:58:48 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 02e1598c759109ca5a6c7176aeb6bf03ecbf0cb3
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 14:58:48 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38e7e2870815bb82f9aebb956f1365fb086dee5a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxPd-000000003e5-2alj
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0559987393534143981=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0559987393534143981==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qJO8xzOhl/k="; charset=UTF-8

--qJO8xzOhl/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Antonio Quartulli has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail )

Cha=
nge subject: dco: detect local kernel capabilities through netlink policies=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 4: Code-Review+2

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1981/comment/33646522_9a839b2d?usp=3Demail :
PS4, Line 2=
4: The query needs uapi headers from 5=2E10 or later=2E Built against older=

> why 5=2E10 and not 5=2E [=E2=80=A6]
ah because of the command map=2E



=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0051effe7f0636e305=
57d9ce92c50c458002f9e6
Gerrit-Change-Number: 1981
Gerrit-PatchSet: 4
Gerrit=
-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gia=
nmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 27 =
Nov 2026 14:58:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comm=
ent-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>

--qJO8xzOhl/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1981/comment/33646522_9a839b2d?usp=3Demail">Patch Set =
#4, Line 24:</a> <code style=3D"font-family:monospace,monospace">The query =
needs uapi headers from 5=2E10 or later=2E Built against older</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">why 5=2E10 and not 5=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">ah because o=
f the command map=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">change 1981</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0051e=
ffe7f0636e30557d9ce92c50c458002f9e6 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1981 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori =
&lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gianm=
arco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 14:58:48 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</=
body></html>
--qJO8xzOhl/k=--


--===============0559987393534143981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0559987393534143981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0559987393534143981==--

