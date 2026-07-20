Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D7EC44515
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uc+42gR7Zj7VEb1+X54l34vtKmluxDJfBLVeoqUgM+g=; b=Hzj5CkrlSQlzg4eYOIkUdDU++5
	0V2EZU8FtVAghItj9IV3Fw69ltyqfseaIbjniN5fn6hCMRJ1yYFqlInaG/ww1lZeqffPKL+MhT1Vt
	Dorhjbfwh2Rmo5ErUuFFk4zqdODOa6EwdAqeFi4tuukz2t2S1mo4bFyjUX7cdbru87ok=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlleo-0001Pv-91;
	Mon, 20 Jul 2026 10:55:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wllej-0001PR-LQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 10:55:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Js4jJDSikBPfXJHTyWGKxFSWMO1x3jvWCp+T9aNorOU=; b=JvcJwyKlD2ERDJQugGEWljbXrg
 SL1wgoJtLO8iwg71b+BLQ6w2uQ9mM6sJfptUUHFSU2PiKA5LtzLfUTNR/Fgr27CoaW4PSJmHPasVv
 U89wpHE4l8Qeo5JHYvmk4ldTBrT3JVYIiOzfSIeyPiVdfQJ41AmhKmr+2JUX4sqOy5Vs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Js4jJDSikBPfXJHTyWGKxFSWMO1x3jvWCp+T9aNorOU=; b=R
 GwUsBSgUoPU7Fr4Kmgr+1tG2N17IYlktqFsijWTJrfeNEbMSia0b7EfzUE4nnk835+O3Kvb6zBl8+
 CaXUM6E2djiads4vKBSqXhCsD19IIFNeOaKJjqkLWmwFy3L4yHv25AbgqU159rsdeDKphrpxfvVI7
 yxFYSDszHZIpp4tQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wllei-0004dL-Qv for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 10:55:30 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso11432675e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784544917; x=1785149717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Js4jJDSikBPfXJHTyWGKxFSWMO1x3jvWCp+T9aNorOU=;
 b=cZccu1Xqau16g3DfIiVvLj0kUzNmQqEsq7y+OZGyeP/mJgnh27KmJWM2TYhOXkYXx+
 jAX9ilr6G6bLgGvLKXC8KOQadLyfwIWJvUv1CH8+a/aA4Ovqzh00IqNCQpLbaDOnkTlw
 LnW7FNcF8i+yn+rHYBOHKT7HZbqVfISsGgH3nl3yGWkT/zBuVw1uniwUvWpGZ1tb2E3K
 e7fGVQ3RixxN81TAF2VSNalMbDarlP3QCQwvIucriuliKjoxlg12CBCLQP7F1pm9Bcq7
 j4vDCZi5ppAHH0bUBwuX9+lflgbqpjPZ50njlVZ98YMY02JX6cZ4+SwaMfzN/NIXgT1H
 kSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784544917; x=1785149717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Js4jJDSikBPfXJHTyWGKxFSWMO1x3jvWCp+T9aNorOU=;
 b=Jg8KqgwLSd9MCkRXicbwFbveTurzm4miMXH6z8FCF1gi3fdtHrocCteWa3+EpCVGP+
 lOZbVXrsq0WK/X+hK0szKUV66tZYFbxG7P9dtvV92cDCowTzkkWzQqBQNXMGJ7PyPher
 XYyoSXzKIpphKTGFR2kv9qjWXelQMIRLfKsX1oTBnLYJz4770VsNfevcewZ93ckDYASX
 othxIinnoEUx71b/blKQ/JORC4iIyjFxz2K86gg71r7bhLNcTLs6zADTzAz7nBjd5dki
 N6J4bBfIDgTE8qhbrgK7TGeh3JGSeHrFKjjeLQtkxCnnlcVarAk76FC2gjjJhvwzTt/A
 u1gA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAycyYpU9g5f/zvGuyp58lek2O4hilahxxhPjg24t9DyOeBWQzUDuHdif0DjpIPyKkz5NERIBfot8ANVGd@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLVsexEPdHjHUfREXtWnhoyOA+8EDoFgTwd0vqUrj8LozLnhX+
 bd4ZcRt0v+fuiUNFiSFHiUThxB04tTmF0RB5eoWaZy+oZ7efVDzYq6GfEyCywjk6er30Km6vevB
 JuNNouQ8CnWXTshRgxUUak3zml4kK3YjAuK+4NX+usHwoIhecpGLplnHRL/6LKDgkfZFKsI3BHP
 XX5JBTTQ==
X-Gm-Gg: AfdE7cmLzngk1saIsJHxlISLzJ7lhT98Ztwl5ZsAs/E8vBl2xgW/B67y1TUMjG6Degs
 qv5qDcEEYw9Bpuz/1dhMEywfuWPBuCZ5q0gurlrhAYu4ypJ/mH+O/e0ya49w8FgB4IcriQKdt+8
 WVdcv71RNwLnfEl0ZqPX9sGn/fy8KFanY989pMUWomeJUPasTAkHQ7iziyLUMtqHyq20c4AQDpx
 3P/PjB8w9JR/cfrARxfW1Bv7b/cYEBU4HNWSVp/8AbwJ/4CGdeZPFlIi77NCcBR5efHC5s3ZUlL
 M0Lcz3YQEUd+PI49AuEiRdpAspbtNsv136f0jz/GJFy393YSuVOGVAImNVuU49IfrYIvA1eb+3P
 q+IVrAw21kHXq9EwOtEpPJ+/D/msndSuiWEaPkdtOX0BQpaHqlVl+urTZg8zYivYPnbnE/ZNH1c
 E8rO+/TnmaFMZBdbNGgg7v5ik+AmkSTSMS9i49jlzQ0z2GOr2B4YH4qiD2AN6l5yhOw3l/Zbhui
 kPv/GBcSjg4cpIChDcL3ELlw8iu9jT5VjP58bndO/K7XemmVheDoA5bjN7CP2gff5+l
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id
 5b1f17b1804b1-4954aa1a10amr141588475e9.36.1784544917013; 
 Mon, 20 Jul 2026 03:55:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm282230705e9.3.2026.07.20.03.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 03:55:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 10:55:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 2c063aab2095cb86186f395d73a59626431ea289
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 10:55:13 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93f4f02de467bc31a37f30c79b35794251df215f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wllei-0004dL-Qv
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0290323802537185386=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0290323802537185386==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1JXW6v/0Ddc="; charset=UTF-8

--1JXW6v/0Ddc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5:

(2 comments)

File src/openvpn/sid_hash=2Eh:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/710c4a27_8bb4a5f3?usp=3Demail :
=
PS5, Line 59:     struct hash_element *he =3D multi_hash_sid_lookup(m, sid)=
;
> ``` [=E2=80=A6]
yeah looks like the "just quickly inline the function" =
in last iteration was not a good or quick fix=2E I reverted that since it i=
s different enough to not easily work that way=2E


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/b4b7f9d6_c2a71540?usp=3Demail :
PS5, Line 6=
4:         ASSERT(hash_remove_fast(m->sid_hash, bucket, sid, hv));
> ``` [=
=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb=
59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-Pa=
tchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 20 Jul 2026 10:55:13 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld=
 <frank@lichtenheld=2Ecom>

--1JXW6v/0Ddc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
27/comment/710c4a27_8bb4a5f3?usp=3Demail">Patch Set #5, Line 59:</a> <code =
style=3D"font-family:monospace,monospace">    struct hash_element *he =3D m=
ulti_hash_sid_lookup(m, sid);</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">``` [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">yeah looks like the &quot;just quickly inline the function&quot; =
in last iteration was not a good or quick fix=2E I reverted that since it i=
s different enough to not easily work that way=2E</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/b4b7f9d6_c2a71540?usp=
=3Demail">Patch Set #5, Line 64:</a> <code style=3D"font-family:monospace,m=
onospace">        ASSERT(hash_remove_fast(m-&gt;sid_hash, bucket, sid, hv))=
;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">``` [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 10:55:13 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"displa=
y:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>

</body></html>
--1JXW6v/0Ddc=--


--===============0290323802537185386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0290323802537185386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0290323802537185386==--

