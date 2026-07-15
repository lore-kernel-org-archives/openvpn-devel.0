Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29022C44507
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gt0s3PcRpTXa5hT3DBrPUjeBxwLl3vVoNrNcymMsM9Q=; b=Fd5aTNB+mFc8ry/mXcakE3QTAw
	n4zNQD55m0xWaz+lhHynS4c2/4WRviHRqgfGLN2nLkgizTx45UD3eSUSdxLkmks9xs2PZkREYYhMl
	gXDJnyF1+jdflA5EqIB9J5LPnlX9vsdSe7MYE6db4tt1zZ/7qCc0FAdJrddEk8a3J9GU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjwY6-0007nX-IR;
	Wed, 15 Jul 2026 10:09:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjwY5-0007nQ-Qe
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AGfSkoqEIAwNeN6YZxufglXjwNLJbu8yHNi3TLrnUb8=; b=mn+Hq5yK1RAjTPHGMqohSVemJI
 Eo1AzHUBzms4cIozC0qVkWiPPEWziLisVACeuO4bpGcyutkGtf5D52+oVt/YFYb/dnecQswpzFG0y
 WfJLABySNCMdRi+hgR+fb3/ZoZDplIotVDKubQ7Jw3oncu1/4F646w8ZJTo7ihdvRrS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AGfSkoqEIAwNeN6YZxufglXjwNLJbu8yHNi3TLrnUb8=; b=I
 uDbbUtNN3xTILJOcKMuI6jYZ2BFobQ85aRaUWtMHhOtOlUDB1AZnGX4TLvqGMt7E34WNK7FB6Xe1G
 u9vU7rWrVTRKUkkBgdImHNq0bpo1jx8EIXOR0uM9VQ2DoghMEwMr0M7GiFRbkTKTQlP5Hj9w+8irx
 10/qwkCKrcTyW0B4=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjwY1-00005e-GJ for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:09:03 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47d70879764so3526408f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784110130; x=1784714930; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AGfSkoqEIAwNeN6YZxufglXjwNLJbu8yHNi3TLrnUb8=;
 b=MzGNSjWvf0+S+4XMf5DQHpdknys5MhAVE70+xPncomHyO9ufJ3lE05CqSyLsl4kfIl
 a8NTkln3NzsL4bAas+eSQZgUzln3ubZ1kSHMuKVJgL0jsq5onwbRwJ4nern+mJBMpLC6
 JuM5bEKydjwK/UW+yD0Vp+T2BHdNAAgwBVYvLaFXCORBbAL4uw2MCiOO5cmBfsBZhpOW
 wuTsSkJBiFTZrz6PwKC/OijwbWQhV+pZt/b66Azbnzze09FBUEyrG/AGxlqhvyzg57ae
 iXRe87LSjp+UubJB6y25qQzvrsEPojTE08FuzAdsKIrV9Kh9EF/9SBtT1zAM62+/94kT
 gO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784110130; x=1784714930;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AGfSkoqEIAwNeN6YZxufglXjwNLJbu8yHNi3TLrnUb8=;
 b=X3r4rjP/1PTeJS7i5OoRqX0itETf0OPPE1ieEo/F81kVNBjJTTj/WvPe6uHXyNV+QO
 At/0ZzDC4NbpOGJx1hgWnVSLlBMFAoGUWjn0sIaGdhJKW0ODlRpOrz6OSr07tMl67OLs
 UW8Gydcx+HQV5fR2gq+pl0CwD2XzG5M5RG8Jcb37qxoNswMmzpBFEm34vBPcTEZQAXea
 Unxzi9jfMsu7of4yPbCfx20il31QuRYX1/ekLLpDbEqESDBw7qVxiXHzEh13QXlDqeXI
 6qZb684cv8sfofssLMNMWf82zO4xjRs6nXpKG4q1khh8d3wzmiKGcJk+20+pkZUevGiQ
 adlA==
X-Gm-Message-State: AOJu0YxPnRmICCyTKMon4PEiaFWeDtoumW0h1ByLEBnoDsvc7/oUWrpB
 LqAGPIJVG+PgoLd/GWMRC/CoU78wDwpL8qfFHJOdFUeyI78VYPWK9rVyszebq+jDaM6HXMshWb1
 QB1OCKKUVJnywFyrviptoVt/RTn2a128oWaFRzhjBLRTFnMYx/vsJdrGLCO3HaDPRQBtR
X-Gm-Gg: AfdE7ck3yr4BS2dOjdkxPQ2I/ZqjXOuXYdpEIu98cFAkclF2qq0VlbF0lgN6OmoG47c
 F1VsA3tjV/iXO7162yxBiQM+I3f/+VxbcZuiPOfXwLMRYIeNJ9elIKXiZ06nokVIHGld92mtgz6
 c/rB3mz8zlYUCBj95zW14YFX37QzZQNiYnyXQGw9XlhnUPcxt9yhXSpRmkXj3hxqi1XZgL6Q5XS
 w7HoE3onRIrBjHwUsN1UcrPGZc97J7W9Dt/UlcVyy9/0WnbyxcHnzfgZnSK7Ft7DAUPHGjodT8e
 1MEoC9vBQv3vlT5IfhbIJJy/tvdJmw+9+19O58+K0ruO1JPIP2wT1vjkQnvMZGhK+9YUplnB5Wv
 zwxOvBQgMdVX7kVl682N7VT+SCZOKDWXL05hRFl1t+kMfquokBpxK0XWusIILcHOqpLjLzUj6i/
 RQ6vTeMxjw1o3M8GdwXBFjqoNtHFsaJOWhCnCxmdZP5Pbfy+ufT1bo39SS0uzwmDOO0u/I/ebs8
 OFeZoRm5pGfab5tmJ/TceN6wqH5pclkFolrEcm+v0clOo89jS9Ku6QibV3bUhK36aWU9zx1toxp
 +Gs=
X-Received: by 2002:a05:600c:3547:b0:492:4e1c:120 with SMTP id
 5b1f17b1804b1-4953c280a09mr22389975e9.32.1784110129402; 
 Wed, 15 Jul 2026 03:08:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953f9cbec5sm3958495e9.7.2026.07.15.03.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:08:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 10:08:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 4a81c72f784f0878124a097af3574c29ff185564
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 10:08:45 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3a60e58cb89167670d70aa1ed96d5cccfe779f5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjwY1-00005e-GJ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0458167950925423590=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0458167950925423590==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8JVCMIjlbfI="; charset=UTF-8

--8JVCMIjlbfI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1726?usp=3Demail )

Change subject: Split multi_get_create_instan=
ce_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-2

(1 comment)

File src/o=
penvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/comment/46=
00a392_e77fc5ec?usp=3Demail :
PS4, Line 364:     if (!mroute_extract_openvp=
n_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) || m->top=2Ec2=2Ebuf=2E=
len =3D=3D 0)
This check is too late now and it is wrong=2E In t_server tes=
tbed we see segfaults:

```
Program terminated with signal SIGSEGV, Segment=
ation fault=2E
#0  multi_get_create_instance_udp (m=3D0x7fff74cfe0a0, 
    =
floated=3Dfloated@entry=3D0x7fff74cfdfcf, sock=3Dsock@entry=3D0x2525b90) at=
 mudp=2Ec:359

warning: Source file is more recent than executable=2E
359	 =
   uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
(gdb) print m->top=2Ec2=2Ebuf
$=
2 =3D {capacity =3D 2466, offset =3D 136, len =3D -1, data =3D 0x2563f40 ""=
}

```



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b7=
7f184c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 4=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Wed, 15 Jul 2026 10:08:45 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--8JVCMIjlbfI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/c=
omment/4600a392_e77fc5ec?usp=3Demail">Patch Set #4, Line 364:</a> <code sty=
le=3D"font-family:monospace,monospace">    if (!mroute_extract_openvpn_sock=
addr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) || m-&gt;top=2Ec2=
=2Ebuf=2Elen =3D=3D 0)</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">This check is too late now and it is wron=
g=2E In t_server testbed we see segfaults:</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>Progra=
m terminated with signal SIGSEGV, Segmentation fault=2E<br>#0  multi_get_cr=
eate_instance_udp (m=3D0x7fff74cfe0a0, <br>    floated=3Dfloated@entry=3D0x=
7fff74cfdfcf, sock=3Dsock@entry=3D0x2525b90) at mudp=2Ec:359</pre><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">warning=
: Source file is more recent than executable=2E<br>359	    uint8_t op =3D p=
tr[0] &gt;&gt; P_OPCODE_SHIFT;<br>(gdb) print m-&gt;top=2Ec2=2Ebuf<br>$2 =
=3D {capacity =3D 2466, offset =3D 136, len =3D -1, data =3D 0x2563f40 &quo=
t;&quot;}</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">```</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 1726</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e9923b51b77f=
184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Wed, 15 Jul 2026 10:08:45 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--8JVCMIjlbfI=--


--===============0458167950925423590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0458167950925423590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0458167950925423590==--

