Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD8CC43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHFIgcz6Qj8h7cShXkbrZMl9k62D07HGM2tv6f/jAMo=; b=K78RR1nUgQ6KtdA9jnNHWXglPN
	WqhfOBH6zZ3+yMyzcDKTrvMF0wP6uTTd24izGzLBJ+xHzYjg2oeornWXvfKVt2pI4ejwlFA03xQH7
	PN+E0Lt1o0wF4iBGlRX3wi1T0mGDwgp4f5oxLJEBSiEhMXC4MNTVTEHzgDT4owkR3XD4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgiPb-0005dK-Fe;
	Mon, 06 Jul 2026 12:27:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgiPT-0005cR-2m
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:26:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=prOfbTBzTf2I/gZFeA5DsX0vEhLiS0n4hG98KCCikGI=; b=jJfW3YhehLf3lJkmiY3tHDXY4C
 wyL7c0JSvukyAOTg0bo8gT/6dVtl+CfWyqSIYGMg6fl1tYoaSoFdrVpS3HUFaVET5cyPhaCZVtRpK
 j8MkXXmCwrrZh3X0DpuBFB0fbXkbkmSxtnp7sxhBnPUvIN8/+mGESi8NdfEqlH/YNIPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=prOfbTBzTf2I/gZFeA5DsX0vEhLiS0n4hG98KCCikGI=; b=O
 oMj+SQw63IgSuFeBEmHjNeTgr1fcEGtnCloyu8/B27cgO8RTSV6KDId7z0jdBsSeHZqgw8skSA9Wu
 3BuqCMGhICWYerpUUfCUEdyf8Eg20EE4TIHE/t6MZj1ilV/GiF6JSIzSaLIByjoDqcgHzSoqSuXll
 LLSvA72vcu9HkCbI=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgiPN-00062T-OD for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:26:50 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so35847955e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 05:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783340795; x=1783945595; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=prOfbTBzTf2I/gZFeA5DsX0vEhLiS0n4hG98KCCikGI=;
 b=D+f2LBzLRQTNcD76/vF8ezANFTm4a4NYdH396xmC4In5YgC6eACk2xy5mTV8/Ql+U/
 gSy3FXkNZA9g1sALy4w939tmJYvBhcTEVjqVFkBv5qis51o06+SEuV2ayoqT6+XuU6ny
 1+3cYaTV0US/BuH7RQJDkBNHGEQkLXSQLtGqEi0wxUfY3+/2c13RImtnttkJjNdfc5vm
 FJf0SnLGxb0e5A9fwWfWDfwyUFqeaDas1Eo+4AFM5Z4WxJ75gBiqcM77dnTVW5lBYLNw
 0SQARvKOk5yvWCdXh8VbUkd/dioRSUG0PmXSSFtYcZXrlJy1kqq3w2uXch5k4Qy60H9E
 2nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340795; x=1783945595;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prOfbTBzTf2I/gZFeA5DsX0vEhLiS0n4hG98KCCikGI=;
 b=MYDJfcgT12BK1+1zYFhVFhCudBG9MOXe2Y3n110VvL/EDeyEgvMScSghAt8H7Mc3X0
 r2jb6l5R0tOl+Ro1LFC1yq4XXYD30fd6C+xgRSDwEGru0lkrpQGcbXxnAZC0UGugtVbT
 02y10lkbXqm11q+X4DjbZ9o/LHKK/bJ2LkvjmYSNeXlSOX9F9uscMdlmHiJnOOYGrC2Q
 J1Qa1F339AUKKrOQb1zCcL9O7o5iuJdmnmSrWKMarF+6mpNgcGudbM6YssmBs4//XwGU
 1KVLvzRNcZ0+Y87JNW9bgiAWHcq7prExZCxaU9o5TmE3f2GrVBaq6T1gfl+QAp6hL8NX
 j/Nw==
X-Gm-Message-State: AOJu0YzmeO5PJ9JEVNh4MQk1yZCzPXqdttiYIkidkMY8RFdvRa3TWt5x
 cHpcP6jU3UFf0v1tZNi39wZdNy9JWSmYqhxRLN177ufvAIi/1H3oVcjdD4F89UNbBjI1W9Kwm/1
 CQ4JI5z74cJt4ZtiAy9Bxi8VQgstaIMd7Fx+lU+RXhp2txgIE4oASZMkQDGfqBswesKF7b5lF82
 MaQb3KMQ==
X-Gm-Gg: AfdE7clKs51SKI5dyAG9ke54WB/wpn5TzS09imOOEQWpyAtNA3u8PXKaBRPXZIkAx3t
 XWQG3wm2YX1EJrC5qJW9NyncI3KzSNhzU0acDoc/mvPLGyqn/7+Aw0KQqrOowledAkkC3aj5j2f
 SbSilE12sRJcxO8ffYoNZ7LYYhbDPu7wRPYdTapHfblkrqvd77Tk408jt6tcw08gF5gW4zGmpVM
 SP1yYhSWpdCPFIm1764L3Sfpv1ifnN8nqKYstvcoKR7jRT/TkE6ir7Os1FWkN7nYW1feV+m0v+Y
 r7zV51/wAtEot7jyQj1TNMdktzIY/0ee4y9LKHzr8SrDPLmt1Rk77YGcWbbLCUlKn2rBJcO78CY
 nyoqBwwE2K0wBo2Yuw2Q9M7DQ8+puRbiP6VUBGP6J7Ym586PbXmKaBKfUAg1vOh1ZDX5BgRzr7i
 m5I3+NzAV/3kgGMTh+qRbYv0fRL6OdaEsLhrFoGzRlz3wJB7aPtDjk2GI6V8oo8zZ2UC2TcHAx0
 wtRxCq+7OCj6Q/fsJpnvWLeO3DcFmDKCenxMMPfJGh6pqFV9dNu5LhY7Kp+cM8qlft03cnOk+AF
 7eM=
X-Received: by 2002:a05:600c:1908:b0:493:d3c5:6c32 with SMTP id
 5b1f17b1804b1-493decbf10amr6551985e9.6.1783340794441; 
 Mon, 06 Jul 2026 05:26:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6381e4fsm424423735e9.8.2026.07.06.05.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:26:34 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 12:26:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: 30112912578226bfe2e750920037a567b6ca5a16
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 12:26:32 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cf1f54f9735f2ca9fdf736a06a7bb61bb8aec63-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgiPN-00062T-OD
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
Content-Type: multipart/mixed; boundary="===============1183477258318389897=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1183477258318389897==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WWYBGKn1wDE="; charset=UTF-8

--WWYBGKn1wDE=
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


Patch Set 3: Code-Review-2

(1 comment)

File src/o=
penvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/comment/5f=
0803e5_1b073337?usp=3Demail :
PS3, Line 297:         return multi_get_insta=
nce_real_udp_real(m, &real);
```
mudp=2Ec:297:16: error: call to undeclared=
 function 'multi_get_instance_real_udp_real'; ISO C99 and later do not supp=
ort implicit function declarations [-Werror,-Wimplicit-function-declaration=
]
  297 |         return multi_get_instance_real_udp_real(m, &real);
      =
|                ^
mudp=2Ec:297:16: note: did you mean 'multi_get_instance_=
udp_real'?
mudp=2Ec:275:1: note: 'multi_get_instance_udp_real' declared her=
e
  275 | multi_get_instance_udp_real(struct multi_context *m, struct mrout=
e_addr *real)
      | ^
```



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1726?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Gerrit-Change-Number: =
1726
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 06 Jul 2026 12:26=
:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--WWYBGKn1wDE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/c=
omment/5f0803e5_1b073337?usp=3Demail">Patch Set #3, Line 297:</a> <code sty=
le=3D"font-family:monospace,monospace">        return multi_get_instance_re=
al_udp_real(m, &amp;real);</code></p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">```<br>mudp=2Ec:297:16: =
error: call to undeclared function &#39;multi_get_instance_real_udp_real&#3=
9;; ISO C99 and later do not support implicit function declarations [-Werro=
r,-Wimplicit-function-declaration]<br>  297 |         return multi_get_inst=
ance_real_udp_real(m, &amp;real);<br>      |                ^<br>mudp=2Ec:2=
97:16: note: did you mean &#39;multi_get_instance_udp_real&#39;?<br>mudp=2E=
c:275:1: note: &#39;multi_get_instance_udp_real&#39; declared here<br>  275=
 | multi_get_instance_udp_real(struct multi_context *m, struct mroute_addr =
*real)<br>      | ^<br>```</pre></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 17=
26</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
8e9923b51b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1726 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Mon, 06 Jul 2026 12:26:32 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--WWYBGKn1wDE=--


--===============1183477258318389897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1183477258318389897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1183477258318389897==--

