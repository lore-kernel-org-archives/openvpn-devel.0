Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF3606A31F
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q2nJedRg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DicMZHMz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YpUlQaUY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=enuCM1yZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ql9srdmNCfDpcQ9P/K4aU0LVGLZmCTDu3XAmERQT8YI=; b=Q2nJedRgT9X4nk28udb5aI75nY
	S5e2Mw1u5jWWaeexLDk0xKP4w0RCVaS8QXidGnc1VOCBpOodYmMKeuYeJA2VfKi5s4rLz6zZQbp29
	TmOQ+D5BOJumcrNo/WtEWfwINrtIm8xIZKPejE6KrfagVKEWiI6qGZngzwule3KuiANM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVXmW-000000000Mf-0ZmN;
	Mon, 23 Nov 2026 17:24:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVXmU-000000000MR-3Mvd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RYpmZQF0qPRwngCA5KlCiHdgjA78nLIbpbehsfdU3nM=; b=DicMZHMz5x8wIeyhFVpIfmRoQX
 AMswwDFCz1U4oG31yjitQEgrUvyFcqcFMO+B4FYyRVEY5CuVibjrUBT1E7YUnqOly1wwnbT6ClX9E
 OgN6RGvzdU4lc3eTQV81gO7ZulpsYBd0BV9V4KBysNlMcNgx0stv5B7ZFRCpn6EZfep4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RYpmZQF0qPRwngCA5KlCiHdgjA78nLIbpbehsfdU3nM=; b=YpUlQaUYIw/FI3r3SLbrhWU6y1
 CSA7EyumvOeVmoT/oGRFvtnSMjr7Skbja0Z/x6ZlFwak8/6hZQUjTviF7TrWImaLfvaY1biyAZ+Qi
 c/TqQlbaY0NezNMgCDwTijtSKkzo8/PbeVlSe1q/dAa25tfpYYsX+FYx/HezkG6NAFP8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVXmS-000000001ib-2kpu for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:24:42 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so34644445e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795454674; x=1796059474; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RYpmZQF0qPRwngCA5KlCiHdgjA78nLIbpbehsfdU3nM=;
 b=enuCM1yZUOiVVvuWJgwhV1cqlzP3TxjFXM/ZKDwzDgn4ZMdDEe+6XuKiiy+lri+/UM
 UIdDJ2CyK+/jxTEz3cOemuq5q7Enlf3p56bJ5jLzd12bWIwOJjLhrvt8jsLsAfFY5ZQK
 DGZI/cfz7JkFsgqRZGwvfHhuDzpVYL+N5Gj1Hi86WmPPQsHoDuBAvDd7BEDm3PL5AxXl
 hul0reSXgEdzwMycL37TDSA/qpCaSF+aJEJ8MUVuWu84WyUz746d0+C99FOGjBOqKgkq
 0OpgpjYQrWrpKEIVRU3yFYwDmPRh6GA0iHagO9Ov2Ddn83AoMvZTYrlHkVovdgURaCd/
 CzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795454674; x=1796059474;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RYpmZQF0qPRwngCA5KlCiHdgjA78nLIbpbehsfdU3nM=;
 b=WQfbj+XfL6oWUWelxxWMebB6p4jcbLctktr7BQkwKdxsw//BGOpvMM8cMH8pIOYeK+
 leKMtufaIe4iz7E5G5MuKgUBQbIePGvkKZdpQwIpXsXTVFsLdMjqVR3m/XMKyF9AGnvi
 T8XwM/rWyFNXv60HB2Hw8RSmJ4eFlThHLWkDCQqFdXHkz0v3RKjxMdV4+sfX8JK2R4Hi
 cWQP91qP8oDDS/U+JRiS3mY3+zJlTYcnz29940ulAh6a/QwUh1gpLGzEuue3EEx2raNt
 y3lb6pLAnjGZu+lH7jwIxZy6COaTh6xFE9LoXKAptU+SX6/UrPRvefM1VLeNskR6LnMx
 5y5g==
X-Forwarded-Encrypted: i=1;
 AL+hErEgrsrrD+AEyyw3+mtjWC6lldCSWSlPr7c4m5FqzRpDJi9WEbkSUVjOzkP6asS97D9xxrRG5idjF5KpBeMq@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8La4xNCW1gWMCgZxGWIEMrCUn82t7B3GmAZZElwRzuxH2VCQYj
 V0G0d6JI6FtyAPDvTQKhrg+9dX+MG/rRZ4fAKMve2CVMCSSouhBszRrwFoxfcMQldtfLSiFoSp7
 6VaBoVVEWOidCNMprptjs3xuMC0xhEwzLG6c9uhE9knFs6PZIBsHRQ5Z6KXsMwgeB5fRPjh+Ayf
 ToMUf19w==
X-Gm-Gg: AZFdTZctZlo3wk06wEXtfGpayPlJ1p5Y1upuVd213FdDKe5zkMMZeTw/2SKr9LzTw1J
 Nw8nHYzacBpUMJ5wLn60XwhHGKAfkYVqKx7JaiI13GwyP/wQ0sVLu6zS/+GddXtXQYYF88FTW31
 05sTUtMlupsovTT9t5C9zh2BFPHIVJkSazJqNM0JQLuXwimIkUNcVS2XPRCkAuDkduLUyFFrddZ
 bMPWd+bwP2CtJQPLXTmIkdkQtJgGCjcn0K8jxVRDv5D7rSr9fijrshQXtSXbxWIaDXHk8bAxEXv
 83aRyUxL24fmo/j8DYIUHVf3hnsYYt0J6oCh7KL8shJXqW34CpTH2+ym8XmdcdS53BZ/4m4F5Mr
 /8elYbrreTXjAw/R7twdCsyHUim1eSATp6deOrFMG8z+In9jIKe3L06KhRAFwHtTFjNS+UEn7J8
 I9szDP7H+uk5QU6ajUPwWYvPi3p3JTxDpvmEB7yHrbpJ29PrQGMrf7N//1lPjF1KwGQjYnhCyjj
 cRw/q2M845IRF5o41KmXFsNprg9OMEaatnoN7s4VsEsv3BsVL3LFVo+oFiugm3ctoVtLBTVrOZp
 LZO62MQVKqYIIsnIyr2RxB6n4/CoSaEHchcQOAG35LID/TGpTDWoWS69gTk8a/1oUW2aFgkh4y9
 Uby5Mvk60Eu9Ib9N2Q3yYDSZyQZwBqsh6rmrAWWeWLhpn8aYoxRb6jtmNC3JItVb0bmQmM99iTu
 XUo9zCRBYGmoZoqG4=
X-Received: by 2002:a05:600c:a085:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb887ca0dfmr270562615e9.4.1795454673907; 
 Mon, 23 Nov 2026 09:24:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm371752315e9.1.2026.11.23.09.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:24:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:24:32 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
X-Gerrit-Change-Number: 2195
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2195?usp=email>
X-Gerrit-Commit: b091ec1e334d9e3fcf809775f4a359ed0e32fab8
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 17:24:32 +0000
In-Reply-To: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0Mjg2MDAwLkkwMGIzNDBmMzBkYzM1MTg5OTRiNzRjNDk1NjU3MzY1MjRiN2RmMzE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60251ac45d5d987ccb8aa67a5d02509189167937-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVXmS-000000001ib-2kpu
Subject: [Openvpn-devel] [S] Change in openvpn[master]: gerrit-send-mail:
 Support user authentication
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6514945711021227317=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6514945711021227317==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BtV7/7eDR2U="; charset=UTF-8

--BtV7/7eDR2U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail )

Change subject=
: gerrit-send-mail: Support user authentication
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I00b340f30dc3518994b74c495657=
36524b7df318
Gerrit-Change-Number: 2195
Gerrit-PatchSet: 2
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 23 =
Nov 2026 17:24:32 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--BtV7/7eDR2U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">View C=
hange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail=
">change 2195</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
195?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I00b340f30dc3518994b74c49565736524b7df318 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2195 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Mon, 23 Nov 2026 17:24:32 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--BtV7/7eDR2U=--


--===============6514945711021227317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6514945711021227317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6514945711021227317==--

