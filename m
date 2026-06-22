Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C9FCDB471
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79+ghZiuNJn3JHxwfuP0NvvJB1Nyp2XaSIT2GnYPhos=; b=hdDec5zNja82kM7fXBkyRLLDT3
	9uYkwFStt1n59hv3FPJhMsK8LrmPJg+Qd+pEWu5iO0tfENRfO/cFzm+GIgqezzn6L5sjLQvqRrhfN
	52vJniqzPe7+YjGSc+4/SPXHDQdYH0d2QBwQsuUhsVlpT/vqZquhAMGKL+wBh2KiWSiE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbZeR-0006Bw-8b;
	Mon, 22 Jun 2026 08:05:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbZeN-0006AP-9f
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 08:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VMtOjgRkLgCUVz2g6bFPVoDgj8nSUqnnWZJ3YYz1Zt8=; b=CEwMlcQmJIyJ2XzXxOhfFTvqi7
 TKWPmx2Vd0ZgRtWb1a0rjJemSQ3EIqXci9SnZfDs+mZEslh9jdL8rjhFlvzDCcHaShqmtvCP8EEie
 3QDdlIRZ+YnejgTWH38WRMHTrti3Z4rdIBA3QYyuTOsueVGpdBdZ/wBGdqA949u82vD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VMtOjgRkLgCUVz2g6bFPVoDgj8nSUqnnWZJ3YYz1Zt8=; b=C
 c40z8Iq3HFnw4COOt/5PjBFLZJm1q3CILMYBS/VMQBgBs45cSRqIwNeVNNDRvUTYlf3YEgc/fKIV6
 Mqyjd5Q8gfLuujUSMxvgnTPRpWT335RoKJYq/NXun6yFRQm2E9q7XzkpXJv+xnHitJY7c8xsAwaNh
 Q+1TCt9VfnDtQ8nQ=;
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbZeH-0003Q0-Od for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 08:04:56 +0000
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-697763eeafcso2832470a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782115487; x=1782720287; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMtOjgRkLgCUVz2g6bFPVoDgj8nSUqnnWZJ3YYz1Zt8=;
 b=OseEGSwpVURiO9GD/tWm/kc1qEvw5MXxsmk8Y18cCjyE+ry2VF8dSqe6gJUK0hhVLl
 3aOV19xQc0HNeGsPIofO8+WZDQtxJw2tyV+of0mp5wIBPYQhs6uAjgjRks/hJvh/h+CB
 3qAZqtpRe/SoBkGIzruaxsUXiLr9rBOcw/78UHfspb+/FYtLayfhxdb9eaHbu8H7UIcN
 mtTWPOO1iDTP/h2fPC/6pDoeQRdbO72WiCFdxqWSNfv7h+GkBJ+MAQtj2+qqIhee3iiJ
 MBZ/fIUSyn41XKT+LTavAXgVdJZXSfTKD85IwCXcf1Rmtve2N7JDJ8hsETS/Ic0zEP25
 fjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115487; x=1782720287;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VMtOjgRkLgCUVz2g6bFPVoDgj8nSUqnnWZJ3YYz1Zt8=;
 b=BWD5D30Ov0gLot0qJkO+VgCSIic/8VenVK0hLm9ENMUVb03hZlTL7fq0rQvVGWYRl5
 5Tisn8z+j9aIo9zC+iFKvffhAq8iCOrExEfzMWY9mLxX2Id2iqKYeoVtyjj4ngyTLkk4
 WJvG2IG7NkyVm0NieI4N/ABD6VhlalkLtYlPXdWpBzlEtoXqEKJ92PkGUEaafy2oLzw2
 U/IJRc5GHAv/q4hDv9bFQp8CIzsXVnQ12T90bvJF1qGl24mWW9O37BwkHDTwN4TIAFvq
 okLtMa8Xq6Moq+Xtjq9SYVacbx5AED4khB0Hq1d4Yp6DDJ1K7BiNpwpDOsZLA8WJ6q44
 kjow==
X-Forwarded-Encrypted: i=1;
 AFNElJ956MBQSrKESWUhLGKJcYcFVgm6e5NbY5RUBG8SyoeMweCVaOa6X5ZJbZtcgNkbdPQO5eub0oYHC4Jcmtb5@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy+N7uci7ZZTuVbHLDXUY67io1IXS/niHGRwCSjJaJCxR14crT0
 PdqvwZeYrRIr9TzuDi8Yeug8a1o1JVGWBCUDEEauycnTvkaix4hUqQBnxhIhQEEixNbM7CE4XyM
 mu8fFxc7bS9Q+ILkDMtDY/DEB2jECKqODCgPun0VJMLvwo0DFPaUJ2McpfcPXwL3o0Ew8
X-Gm-Gg: AfdE7cmyLGGwKJIZTj+ZR6EQV0D3q/OMGplDhrki09EcaNIx1sTNVSj8GybosJ7TY5A
 HN+Lx3eGVYM7aHg08HtY0nyIG98suLS9JbbzkwqkLOVqjlPY8ClmHftK0XKKk2SUMq1lwHhgbPQ
 ZaFiDZcKC/16naBEc7H6r6xPgAgg3ukjSouoezzGJj/Ye5GuqlogSmb3a6j5g3rzC4nPxc/B9zW
 xKRs9cYnUIFoAMgHaHhXYP8ng1RkJXwry8OZ7yFmX2QLUb78LACNOTAW9lCfhOE6XkmG+rdG9zX
 jY7WheKFZYS24pVX+UU09CgnnpLpWwSJz2VPzu+PHIGwyiC3bAId5OTVUSSsHsiP1BWFcP+m5gL
 8ksfQJedsK0lR1i+OUovz335lOyvLj9TYLzHgnm8Q+LGEgr1V0463zvhSdF1sZfvHuQFzkuem26
 AVZEFipkV6yOYSYauE3d3fPdAblO6b7gbXbsMLdDLfFaWHcEbo5bDhNiQQPP/WRJ/a4xT8h8Gx+
 GnmOoSYteCe8uHxbEwMl+kHqb+MP9QSXMza3Zrpvabbc7yk8R+4ON1RoJds6RSVywNtEzQZS/fb
 kIw=
X-Received: by 2002:a17:907:9606:b0:c0d:43b2:e8e6 with SMTP id
 a640c23a62f3a-c0d43b2f1ebmr324782166b.42.1782115486218; 
 Mon, 22 Jun 2026 01:04:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667881b4sm22259743f8f.24.2026.06.22.01.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 01:04:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 08:04:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: a7817549891e7005fc0ca408396cfef95a1d30dd
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 08:04:42 +0000
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc7d172cef7e17ab6c98c0e6a68c6f1d846d9310-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbZeH-0003Q0-Od
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9187470157193234404=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9187470157193234404==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dnTGL6g+Tzs="; charset=UTF-8

--dnTGL6g+Tzs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1715?usp=3Demail )

Change subject: options: fix use-after-free of DN=
S options on client connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:=
 
good find, and likely correct code, but I think the comment could be impr=
oved


File src/openvpn/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1715/comment/304399b5_36de541d?usp=3Demail :
PS1, Line 1539:      * le=
ading to a use-after-free/double-free=2E */
I'm not sure this comment is al=
l that useful in the grand scheme of things (why does it explain lots of de=
tail about `dns_options=2Egc`, and no work about `o->gc`?) - the in-code co=
mment should not try to repeat the commit message, but explain the code :-)=


So maybe a comment before the first `gc_detach()` that basically says the=
 same, just for both?

```
  /* the option struct carriers two GC arenas, o=
ne generic and one for DNS options,
   * which the by-value (=2E=2E=2E)
   =
* gc_detach() basically just re-initializes the GC structure in the clone,
=
   * so a gc_free() will never lead to a double free()
   */
```
or somethi=
ng like that?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1715?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49b3=
7b5a90554fa2d4a83c8fc5608dad2a36b835
Gerrit-Change-Number: 1715
Gerrit-Patc=
hSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention:=
 ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 22 Jun 2026 08:0=
4:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--dnTGL6g+Tzs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">good find, and likely correc=
t code, but I think the comment could be improved</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1715/comment/304399b5_36de541d?usp=3Demail">Patch Set #1=
, Line 1539:</a> <code style=3D"font-family:monospace,monospace">     * lea=
ding to a use-after-free/double-free=2E */</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;m not sure this=
 comment is all that useful in the grand scheme of things (why does it expl=
ain lots of detail about `dns_options=2Egc`, and no work about `o-&gt;gc`?)=
 - the in-code comment should not try to repeat the commit message, but exp=
lain the code :-)</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">So maybe a comment before the first `gc_detach()` tha=
t basically says the same, just for both?</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">```<br>  /* the =
option struct carriers two GC arenas, one generic and one for DNS options,<=
br>   * which the by-value (=2E=2E=2E)<br>   * gc_detach() basically just r=
e-initializes the GC structure in the clone,<br>   * so a gc_free() will ne=
ver lead to a double free()<br>   */<br>```<br>or something like that?</pre=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1715?usp=3Demail">change 1715</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608=
dad2a36b835 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1715 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Mon, 22 Jun 2026 08:04:42 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--dnTGL6g+Tzs=--


--===============9187470157193234404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9187470157193234404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9187470157193234404==--

