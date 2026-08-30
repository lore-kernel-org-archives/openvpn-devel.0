Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12822C61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnocIvgkPQjFtmzNDO0mxEzVJOegZyNAKHaSGqfKrjI=; b=j/QiOEABKaJYTxw8nr8EMx6v6t
	kuMVmmTousoY5TbbNH85G3239GC0z7s3Z2wdLtxXCjlIAcNm+jF3YXBYvqzEAqwO7LOSRi20cp3HE
	F/9cuZHJ8DdNG2DR6MSdg0mzDgC8t28hMHs/5X9X1oD0hahwFstTBtIfuhPFoqyBEbEw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jL2-0004vN-8O;
	Sun, 30 Aug 2026 17:29:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0jL0-0004vD-Di
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Mt89rPLJBKpTaPCMa7rTY8gbTgUbNHDjyGFfXf7eOC8=; b=Wutd1rRT+mrdLNtKcP7cXc3975
 V+1nxfnc3wXE4olU6/j/wdSrQ1WCnLRcJzdATmxFiwXZDYW8LfZogc3ZZDjinlsf5WNrEUg//ctNp
 ZwAWMlEe9dOztdVm8IaazsczRGewBW9WTjSgdpDcsT+JSUxDP2uIn1R0hvgXpyMD/AMQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mt89rPLJBKpTaPCMa7rTY8gbTgUbNHDjyGFfXf7eOC8=; b=L
 E7Uel+MVvmRyDHC52GRZS1C0klR7unInoDkAxnXNAHwbJn3JuT4RVIMKN4SedbwJWY551QOfgqnKj
 pA71Co0ru4uGblakGB35ifwTYUR2GoAc6340x5XyOyjgLy7fg4UchqSFFIgabqzJ1+DbI9i/hilC+
 8UnLCaND5bTksCkU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0jL0-0004Q4-IN for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:28:59 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-482e2904915so1818591f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788110932; x=1788715732; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mt89rPLJBKpTaPCMa7rTY8gbTgUbNHDjyGFfXf7eOC8=;
 b=QbMNZpu+J8J+Ju6OzHuv2GlTr8FIelGEskBNwB8jDMD899N7r6PEb9VvNwxdRobHHX
 p7rJRdYZUUlUoxzFWpfDpss5s7yuDqUX1McKO3C+aeRncdCfqVp5/sVAr4M4Xhoe286t
 jQ4s5LiI5BHagHJxJ7L155/m3ZkPdcNZYkQMozu+jc5ntiwN5Ls0btK+dwb+tA5sfgi0
 cjGSOKe7IulxhYfwpUImB4xFm9vovgE32XOOcGvCIcAFaBdZdTPkokrCn455V8rYirlU
 0p7H5QdbinTkm9VKPNlhU5pi8XWN1OdQeVikSD/jNxN+6pYlA1hlw8f81HDlAD8tKQbG
 KFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788110932; x=1788715732;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mt89rPLJBKpTaPCMa7rTY8gbTgUbNHDjyGFfXf7eOC8=;
 b=TVpDNuEqK8MFJ6hkrFmHk4V2coR77dA4FyM4GXnBCL7QFU5itqRmN+CQUzbfEsGvL2
 gswkLOXsDLZc+cnX9WMKffddrghpVVIhQfg0ukYsY4fxzp5aj7tWm9ujgNTh73VNkWLW
 l9VgznqvUnL87OzevmhJ/E8ylKgytpP1r8Y6vh4eLZvg3Nf7vNRbviWWR3AHNCAEZu8r
 qyiQwVOwF8v1DqSSbFrjM3m7LPkbUhRPnVsDXW5Ckxvh1KF1HdJhsVQ3SvWxm/Nr3Vfu
 0gykEjUQ2iji790rCrqd27J+TQOHb/EruZRDf2fo3+I0tWOl/ggM0H1pxqJF+2aV1+dC
 9tdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSVlXOBknhsGXJ9UrRZM3okK8VBbjR6awsIxf0FU9Z5B+qZsGqnbLBPHZIbawhcJQ3EbqSRf28In4lBbAL@lists.sourceforge.net
X-Gm-Message-State: AFuF++nw9tWJepm9iUShI9HAQXdmRXPx/Ru+CwMeio9FAFRJiwdgOy92
 /QJuhBGJRgs9Pr5t5Dh9AFNFLgQ5+NJmAoVZf1+r41dUKq+BXx4GMJz3hUru8SOzcVvDK9EG8Yk
 acLJrg4F5lRsveTPgBcCI6BsrGTImux4Jiwx+q8ovbCKzJuxn0BQwJYJrNYkDYqBppHpr
X-Gm-Gg: AYBFou20Pzsap2pFsBYVNWxtgsHBlgXQtIx4jq9PnxP+o+MxvupQL0aGa7Bcm9elPhd
 hM0uMKUPOl7K7teDE1+3+QO/DVpUDWkQkSD7LyWJzSuOmiUkMtwmreVjt34aCwD+1JBMgW5kg50
 w6uD8+aY/ShEMhA3hsL5R5v600L5CJ9BfSg7aqrAdzky9SDsicUb2BklBZJLT8X7dpMTDWkTdin
 hcZr1prhUuO+Lu8ve8Yj523I5s3SJp+NKsEvldkjpxhxsj5udgHGgmA9UBnyLctzEInXu0RKV48
 3RXDpLAcjsxBfIR+RyXcVm+G82uAaIZqmNkwHDX1VKqwq2VJfXvT86FH8IkunmXv0tq9veyh+I+
 E62hlO2BkTxu1q+qULg3t3jWKA6lZejURauGRfugLSt7nocecJo209wWTC51BWk4A9nisdSrZv4
 vz9d36u7L6/5pDp7N/QusAGH15oqZw9iRXmppHmMHWAPskG6MpzALnH7pjicz0HZRnpLmzNlgYH
 7EWGzq4x1WOb/HfndF0mcEHV3w8THfzKYjh7JWniIzJMKejtav/9g6pt+hOd4Q2tftHsHm+7af1
 0ffFrBjwUuB7/X1VZ6YW1I3RNP12jWu+SIPhvJ1SXnb8D/xsbOM=
X-Received: by 2002:a05:6000:46ca:b0:482:d98f:ec9c with SMTP id
 ffacd0b85a97d-482f79b1e87mr23916507f8f.10.1788110931946; 
 Sun, 30 Aug 2026 10:28:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20737sm15354734f8f.22.2026.08.30.10.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:28:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 17:28:50 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 7b3fc92556d90c37f743d98ba1b7744caacaaae2
X-Gerrit-Comment-Date: Sun, 30 Aug 2026 17:28:50 +0000
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a9b9531479924f7a11dfe3329ab86f19474ed23c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0jL0-0004Q4-IN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6893902018368333840=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6893902018368333840==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dSwIOwTnDRA="; charset=UTF-8

--dSwIOwTnDRA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1882?usp=3Demail )

Change subject: t_client=2Esh=2Ein:=
 Check whether addresses are in "tentative" state
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File test=
s/t_client=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882/comme=
nt/3d8d15b5_b422f033?usp=3Demail :
PS1, Line 277:     done
> Probably unlik=
ely to happen, but since this is unbounded it could theoretically hang=2E
g=
ood catch=2E  Indeed, we should error out if this happens for longer than s=
omething - maybe 30 seconds?  I've seen IPv6 get stuck in tentative state o=
n FreeBSD, and we should not hang=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1882?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Gerrit-Change-N=
umber: 1882
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 30 Aug 2026 17:28=
:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: razvanc <razvanc@mailbox=2Eorg>

--dSwIOwTnDRA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1882/comment/3d8d15b5_b422f033?usp=3Demail">Patch Set #1, Line 277:=
</a> <code style=3D"font-family:monospace,monospace">    done</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Probably unlikely to happen, but since this is unbounded it could =
theoretically hang=2E</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">good catch=2E  Indeed, we should err=
or out if this happens for longer than something - maybe 30 seconds?  I&#39=
;ve seen IPv6 get stuck in tentative state on FreeBSD, and we should not ha=
ng=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1882?usp=3Demail">change 1882</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I07b373851175d865abdb1=
513f90655b3fa31d5fa </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1882 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Sun, 30 Aug 2026 17:28:50 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--dSwIOwTnDRA=--


--===============6893902018368333840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6893902018368333840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6893902018368333840==--

