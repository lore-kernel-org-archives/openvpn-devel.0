Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1439ECDB479
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aiayVT97lcbdjSRtXd6jo2+KT8m3HcVgU4KRBGLTqrM=; b=E9ZgRWfF5LXHmnd3BO3lgB5OwN
	IUSWGpCUL8UwGE5Vlof0o9QWBoObkeI09EezCehWgxGyOPbIIGJnLOBZuaJU4gpZjZtv9lsVSmBrG
	2efPAQteHLGTufBHp3HIiK963j4nCSj9BrERuot2au/QscMAPqyn71q6eF0WS8BvoZB8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcKGi-0006f8-JH;
	Wed, 24 Jun 2026 09:51:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcKGh-0006eq-7r
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eum4ZDcafobgjSJ2YbXK9iET3wIkBcs+QMwQWj17kFc=; b=ZvtY/WvALrGcJVnVRK5zGRfuDt
 UNakFDukWMipHBpjqiZ5Vl3SekS41DaRtqlNHdIbYjpMUdmhzl4iRyuPu0jPMvkWGyxa2LI1/oAOP
 qsVnXohO+QnE7lolgc46xEiR3md9JlVBCcl/CV02Ch0B8BbyjsL2o5Gwu/TJv7PdTRJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eum4ZDcafobgjSJ2YbXK9iET3wIkBcs+QMwQWj17kFc=; b=k
 qTUGyPWIFw8qdRqGHPGxqA1AfUiZE4pbaL+3VVSdDsC0/P+XkPGqHWYPcSH2AFYuyy1RgmmhesFL0
 /lny/b+KMl6xXuKb2VmVWhVMiiYAbyZl+YtOI+sWc52fFSt3Nl8IwpjK1B5ZeeWeY1VnRxia17+6g
 HZ4GmZ94UlW/mIf4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcKGc-0004Hx-3x for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:51:36 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso4332245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782294683; x=1782899483; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eum4ZDcafobgjSJ2YbXK9iET3wIkBcs+QMwQWj17kFc=;
 b=UC+nV2qVpg+8o+p1JQj5ESKUVBlVxtU0iwlYnJLSwzNGtMGbLhkKF8GYQk2QT2mFDy
 P6H+O0Q7vvVEFXbKhNMVFCgtqmjWEL7JraTPb7R3ST2Ru9Dj2rJBoRAbvfTvC7LV6rKh
 14cfak1o3XT/vvEt1nXzPzZkTA3bDkI8iKTpV3O/UIA1wYgHFr4gMNaib2cxAUNmPw+0
 NhGiFOmXJtk3fdTINjhBhjVd3N0ngJzj23FRiNUNcIHXSIbeF0po+KHSNMr9hpLGZTif
 S88C6gmZVwN5WspuBDyRpdUDxeRbkRUeK0tXSTHZzjKtPqLncDmmQ7v3PWvCztJ42BMT
 w8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782294683; x=1782899483;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eum4ZDcafobgjSJ2YbXK9iET3wIkBcs+QMwQWj17kFc=;
 b=br0rC7Qm3Nx5ZEyUTY9lDhcvdNYE/iTo4TchP0QU0zwAtE/VQvqPujASabeeMIrmy/
 Rq33euY3vWPTO9frcFwaVGT5ED8j0HyugtvyfB+haO/Tp9Vlxx9Tgun//NWGravbI7Ri
 IdGwUQVWSeBt3EWDhbIokqw+20vdp2ZNhDl1biIcpLge30VYrLOaMHMjCo8vIP1cgwbq
 khcpufxTIwOzeik259pKOMM5maPU7DEtE6HVzbqFVMf16xPYU72KCrJ1QZ7ryMbEQb9t
 IFiq15/oGVnAzFB27YZQvE0paKXFb1fvu87GQYlF7lwdc0hXgoAWrUlex22ErMr/lYEK
 XqJg==
X-Gm-Message-State: AOJu0YzFav0J1EYkWG8fZ4gyfba0dhbTGQzY2hAK2suZQyxYyUBTmcyN
 iS5XAL8SHnooIzy6qitDqcvxH2URyjJvJxzgSrWyML6qSCPkoq//FWowju24AUhvddABlWs69iJ
 /WEwUmqBzv2ST5czBc9YEecVm8ttPqpB2bkYJ0PJMnvV/hnNYXa+E1h8O9gMjR7iae5rWGLvSpW
 /xsQZRQw==
X-Gm-Gg: AfdE7cmaTaFkG6jcXW1dhYfusRGZB22IqEnz2k4H2iwvZehYi6UaZQYRQj+fXKUOrFj
 uKSXFmcImNiEtYmokXISfbHq9cvSiS7W6TJWbkMvwbFENmcAPBAgQ0OyOQ7kdgLkqxYS8vrp8rb
 Qc0P6IY8G39w8+Gb3jws9dVo+oD16IYdb8lFpjerg0AiY/fkHqgJj+Xud2FDU1H/XkeEMMQamXf
 Nc4lqcZO8wRrJpiFyOZr2ptvKN7xh39YxY2eitVsFIg0KDa+cAPsfspsaxtqapP7WBSkcqICAM+
 1+pgV6NTw18yX78u7gRJPnsdE6bTzqdU8jxtgz6iwmdBbGh7LjJafQ67nW6CX8MLfMWLjzkXK3/
 C1HCvPkgtGf2F7OKjvn9H0iYHU5zevT6isqMaIdvDfvmYMvMZnxx/GQe7UpCnLGttq3cDfB+kyL
 StlBucFRUlR+DkxZDZvj3UrIIVyI//1B8LIXOhmB3UZJddNDwfwYQ8KmmjdKrbf6SN0qxnNYEh3
 JVqxFeYWbiW8kH4i8Y9Yq9xyUNI+E44DWr+rPwysoIerspDSP8PFNcR5pgL545elLPgSL3R4MC0
 rwU=
X-Received: by 2002:a05:600d:10b:b0:490:b642:ce31 with SMTP id
 5b1f17b1804b1-49260840c5amr22305675e9.2.1782294681974; 
 Wed, 24 Jun 2026 02:51:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923c862sm339873805e9.7.2026.06.24.02.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 02:51:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 09:51:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
X-Gerrit-Change-Number: 1729
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1729?usp=email>
X-Gerrit-Commit: 78a52c142ef1f4957c01f932c088fb78e58ac5a7
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 09:51:20 +0000
In-Reply-To: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjUyMDMzMDAwLkkzZjk4MzRjYzEzYzQ5YjkyNDk2NTNkN2Q4NjM3MzgzZjUwYzJmYjg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c72d771eeb31ebbd4571c4b6013e7253a7f83ef-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcKGc-0004Hx-3x
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: don't let
 stale-routes-check delete permanent routes
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
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8386246780949377525=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8386246780949377525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M9aI8H05jjY="; charset=UTF-8

--M9aI8H05jjY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
729?usp=3Demail )

Change subject: multi: don't let stale-routes-check dele=
te permanent routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/multi=2Ec:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1729/comment/edd0f44c_5462d744?usp=3Demail =
:
PS1, Line 1363:         if (multi_route_defined(m, r) && !(r->flags & MUL=
TI_ROUTE_PERMANENT)
Why do we need the PERMANENT flag? Cannot we just use h=
ere r->flags & MULTI_ROUTE_CACHE? Or are there routes that are not cached t=
hat we want to remove here as well?



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1729?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
Gerrit-Change-Nu=
mber: 1729
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <a=
ntonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 24 Jun 2026 09:51:20 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--M9aI8H05jjY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1729?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729/commen=
t/edd0f44c_5462d744?usp=3Demail">Patch Set #1, Line 1363:</a> <code style=
=3D"font-family:monospace,monospace">        if (multi_route_defined(m, r) =
&amp;&amp; !(r-&gt;flags &amp; MULTI_ROUTE_PERMANENT)</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Why do we =
need the PERMANENT flag? Cannot we just use here r-&gt;flags &amp; MULTI_RO=
UTE_CACHE? Or are there routes that are not cached that we want to remove h=
ere as well?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail">change 1729</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f9834cc13c49b924=
9653d7d8637383f50c2fb87 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1729 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 24 Jun 20=
26 09:51:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body=
></html>
--M9aI8H05jjY=--


--===============8386246780949377525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8386246780949377525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8386246780949377525==--

