Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D1606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jhGcVpQq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B/4o+qZH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HQSKL+5j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GXaX9gTy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FWFWLGg4qp9mYySw+sEkmxLRh6wxZr+gprZE0tmgYp0=; b=jhGcVpQqR5xQLarlFN48Fm96pg
	cN7o/OKPR9286sjw6SBxXxPZZSO/o518P77O7S2Tgkay+Y6rgpELwDzK4OWkOVWB6+RysJc9KXB5Y
	z1c2D3srM206zNzespB6tTEbvk+JCggppR7i7jaM1PZ1+5GZ9n1I0P1ZsIz/TDvkKPBM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6vf-00000000770-32To;
	Wed, 28 Oct 2026 16:55:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6vd-0000000076n-3gzo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gy5gzSAnJE6AREbxxomO1mAfak7Vw9YvSVXE/nFuzI8=; b=B/4o+qZHPVcnc+dr+yeHqJmi3W
 dZrYLStxGPRY616lAkCBfurPoJzdKhEQ1aU5LEAvfU/yotvqkdhrXQcGcXGPpIu2XbCiaWe9AWJGA
 Eaq8hwyOgckjwEBVM3B/vBVpRctyq6xgaP0Fq3RpzZv9w6w+xzpeby/619ClTHyOQEpQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gy5gzSAnJE6AREbxxomO1mAfak7Vw9YvSVXE/nFuzI8=; b=HQSKL+5j1mRsG0zLB2NM6Q0CXt
 QN96sEr1wEPfA6vbX4NT0viliNkGUDG1KcxfNed2v46NhvliEAgy0uCK2ui86g1EXaoG/iGmO7r8a
 1iV3S0f18IkyNghJg0GF8w+vYAf3mQmtH7QV57krCCpOamE6zGguwQdtGJ+cCf4bdt24=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6vd-000000005tm-04B5 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:55:09 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so13689935e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793206502; x=1793811302; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gy5gzSAnJE6AREbxxomO1mAfak7Vw9YvSVXE/nFuzI8=;
 b=GXaX9gTysqV4t3mU3DgPNzGJYl5Z8YTqVfSwjzpEy/Yx5uRsfwOG7SF2GM63vZKIkx
 jdEQ0Iu9HKhsykfEVqzKaZRP4AI93d0Y2UhRi9RQJG3HAVjcQdDFmt4uOFE5feSmEix/
 UJdZ0F3DogJ3zuEaommEheigxiATXJZVQcCt8LCNctAEKSoQJgpsuzUIwsIF+4/IJRZO
 b1LQ2phuoB5Mwdv3Dkns46V0ox2+G4PjcHaZJoMRR6nekemjUri0QkukMYWSBWJZGKWi
 bMSq2t4r8Tyn5pvgHXf/qLhJw//7V2go4bcJtOJdiUiIp8JT0Lj6iID9sUfYijXvcCEg
 ROPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793206502; x=1793811302;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gy5gzSAnJE6AREbxxomO1mAfak7Vw9YvSVXE/nFuzI8=;
 b=TXf4ngTvMumbpH2dJyiUkVdc4/TdmVUg4lHAdRK/rbIspKVMJHz1jrKcSROonM+9xl
 bbKgZavjRVXypFOFxSWnNTc9WtIBmPH/M7fZeyItWj6OHulHrXn612kIyBz2540wNVAF
 ETsReT85F4VZzUNgRqWxFWKG0PctovPnK53bG3CFltLx30z3pssQ0fY4VpAZi68K+GP2
 7VOG+ip0Z1y/sZbkRQSRgyFhM4kQoZ6rsw1UPYCkxqxfrm55hNlXN40p6jiVlRSMBL7d
 7TZiIgR6dLNFGjvsSW8Kc48dkMzFFdXZ/OcZ3AD3r1KMB7XCFe+8GwXHFTl3ijbZuACO
 FiIg==
X-Gm-Message-State: AFq9FYJHDgmkK7enCvgg/OfyFv5G/PaBFSzfA6mM5s9958jcyu4IXdma
 ITVzz9OGc5QI46sHTPvGCAEMlwVC8UPyJtaa8+nUkQQpJersiP+o2slfeor2sB7aWjuf7oUXmk+
 /TFhu8xhHfLG1t1P/+1/NJ6ET5Fim1HEp5F+63VwMe2DCQRT0IMMLMVLYIC+OxP5lWs2BKs6PF1
 AaYlZ2Vg==
X-Gm-Gg: AYBFou0Ff+9RvJ5ye/2xjYjLQQVWFh9aQkPCCxI4z5cVPu61PuHVdhI+QbU72Gwo0dw
 8+NQm5dbLXrqoGdij0oOxRQdu/1ZdVZ5nL6qB7B6/BiJ2ZHXWcg0di08bxgKIXAb/giV6ESg0Oh
 +hzOnPpMl8zlqalsVgssNjJpvvJHRoWotK84Sf2x9mDtWR4uiFrq7Vx3MoBrNbsDuxpzjjR+QdE
 DuaFzFw7NsKwsXhzKbV7E8mpHSiONapevZ8U+kbFcJIZt+0O5Oj6l5gdaM5vbax0D8tP4kS5mn3
 XhnT9nIOF9LqhVo9OAvGfEvyGsp1C9feXN1m+LfBTMvV5PZTORuuHE6bawl9pOmYO2jITAqgl/x
 3vyqnA6ZUEVSKt+uYIoS9emU+LfX/WYQV9FDsDtXHpVJ1+dPjB3wnlsX/ZTZNyn3E7BNBnJqYRF
 TyMVrNSqShdpyifUb1d6J8Mb46IaqE/wurk5RXbP47Yh8djzKvpF41gZ0nhYruwc/M43DEmm9Xz
 xl+5FrLwOQ48MNKpCXFo6X9C38uthFRUUB3QragGpcTP7MYuSXBVnstmppbNfFui1QuTstZPofm
 UQan0n3lQdgv3vSivPNb/3o6LWJUgHXLX+CC8gH8XTwZ18hMpQrhHUCGo5DCBkBF6cKCrczLBVA
 B++6LSuP2XAodvwXZlby3jx0mEYdkfh073xlNmZ/iWZD2YCpVi62EtRb4zTsYIIa42xS5Pv/c8+
 mYsCiuawfYYdiw7Wk=
X-Received: by 2002:a05:600c:e547:20b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4a96667c854mr41502935e9.7.1793206502260; 
 Wed, 28 Oct 2026 09:55:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm4601415e9.9.2026.10.28.09.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:55:01 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:54:59 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: 68be535fade5b99045fd568bb35a354d57647e57
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec49392c6cb8a5499ad47afbe36cdb1c4d2eb010-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM6vd-000000005tm-04B5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3826055487525690457=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3826055487525690457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ooQ42O2kuZg="; charset=UTF-8

--ooQ42O2kuZg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello R=C4=83zvan Co=
jocaru, 

I'd like you to reexamine a change=2E Please visit

    https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail

to look at the new patc=
h set (#3)=2E

The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E


Change subject: Mark buffer invalid with username =
mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Mark buffer invalid with username mismatch in server side =
float

Commit d42a9912c1 introduced a check to ensure that also the usernam=
e
is identical for floats and not only the certificate=2E This check did
no=
t mark the buffer as invalid in those cases like the certificate
check=2E

=
Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issues/1137

=
GitHub: closes OpenVPN/openvpn#1137
Change-Id: Ide5a3064e51d4a22f914e76c1d8=
165fdd4d005f4
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/op=
envpn/multi=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2058/3

diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 79e6bae=2E=2E0553=
05d 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3169=
,6 +3169,7 @@
         {
             msg(D_MULTI_LOW, "Disallow float/conn=
ect to an address taken by another client %s",
                 multi_insta=
nce_string(ex_mi, false, &gc));
+            mi->context=2Ec2=2Ebuf=2Elen =
=3D 0;
             goto done;
         }
     }

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4=

Gerrit-Change-Number: 2058
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ooQ42O2kuZg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Arne Schwabe <strong>uploaded=
 patch set #3</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><p>The chang=
e is no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</=
p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">Mark buffer invalid with username mismatch in server side f=
loat<br><br>Commit d42a9912c1 introduced a check to ensure that also the us=
ername<br>is identical for floats and not only the certificate=2E This chec=
k did<br>not mark the buffer as invalid in those cases like the certificate=
<br>check=2E<br><br>Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/o=
penvpn/issues/1137<br><br>GitHub: closes OpenVPN/openvpn#1137<br>Change-Id:=
 Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4<br>Signed-off-by: Arne Schwabe &=
lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file chang=
ed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2058/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index=
 79e6bae=2E=2E055305d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3169,6 +3169,=
7 @@</span><br><span>         {</span><br><span>             msg(D_MULTI_LO=
W, &quot;Disallow float/connect to an address taken by another client %s&qu=
ot;,</span><br><span>                 multi_instance_string(ex_mi, false, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>             goto =
done;</span><br><span>         }</span><br><span>     }</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?u=
sp=3Demail">change 2058</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2058?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2058 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--ooQ42O2kuZg=--


--===============3826055487525690457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3826055487525690457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3826055487525690457==--

