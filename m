Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE55C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVscqgzyi7doV4EeJWPJ9PT8WOVimAbMGnFyZpu5+pI=; b=YmIzZxj+5e6KEZGE0KtyVKSW7+
	0FEdI3qNYLBMXXZm1EPsEi/CWallOmIaaTI3h9ZQRSlgwAcwQJNxsMifKG5RhN0azK6h9VvbBwVZc
	3qBMAhQczCeXp+kRG9fpnNXTjoQ+y43H3uYXLFYC1vccfsR9m2Wxpca5xCstPgeSl+NU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgDM-0000nu-EG;
	Wed, 19 Aug 2026 13:20:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgDL-0000nm-RA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xQrkk8LmO8zp/9IX+0cNzUFjc7bEvpaD33Jyxo99Rbo=; b=FYi649vJZEmrMwVO4sE75wyhMy
 bgm4hWNrksRlDApJhARgLiVrPLjpe6zRTRq7CholZ4F++O6fa1zOrzjsaVdLHW1inVEOHbBHu8ZFg
 XUsY0yhLuu3erHnCYxBmMGGVK1B2GysqvLFqWjZMoiJ9zy2ctjVcQjFNMAt5PzDwHn5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xQrkk8LmO8zp/9IX+0cNzUFjc7bEvpaD33Jyxo99Rbo=; b=a
 I23Xxmc8Rem8Cdj52Xi4kJ82Jj0X54pFEfdcqRphoqtdg51q+6fgXLH0qsx+Yql+wKKV5eEQ89r96
 JUmDupvOzrObCxNqe4MOYegvRUU+O/iGv8hDFvTBJ0i29Ky2OnarPvEJm+1aErX2LEvAcatjZmAs9
 Cky0fhTIln/WCi9s=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgDK-0000BV-Di for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:20:19 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so578663f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787145612; x=1787750412; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xQrkk8LmO8zp/9IX+0cNzUFjc7bEvpaD33Jyxo99Rbo=;
 b=NVTY17FE8ZITHjU2BHQTkOH1GBHyJkBLNJaaWTnCwMztDp0hYtXU674eBJokx7qcHx
 gvNhzP7c4420bqCZKUfxMHoplcuq2x6k47mfBNIiq9cnrFc0StIU3iyPeDfsNJfV582J
 M1WV0W+/EVsE7axBMbTTJHq9WtgmfN8ANuYaFnrqUx3QEgb8Vl2YtanWU8jP2a6xvtTa
 m3zqKc8BLY3KzjgfpvBS3rby5Jldda10Nxu4NzFXdClpSGI+XwcMziu3CQo0jC/yz7SW
 vuL8cqDaMOovcU3i5cFcHVFXmABnl3im0ndBhuCXzpx8JavPJw1Lq3mNYcInwByqy1hm
 Jlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145612; x=1787750412;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xQrkk8LmO8zp/9IX+0cNzUFjc7bEvpaD33Jyxo99Rbo=;
 b=LMeVhavKTIHLYDt3Wy3UrU5QV0VkFEAfIQd1uRwsC58i0gjpO44VyCgmvs4iacjEix
 7EAp8Fs3FatXAGZQCVGW5pAZusR2jmpO6lV7kHZlqdfBNRX3l9O/5bNxIb3gFDG73dz7
 EZaFXO45k0hGFMzvlKCXsM1KHKRt3T66+gm9XOU2TBols8mbzS6PUQ/RNMa97uiQNMRf
 FGmS7uTXca9lUxOjPr8gGuLDI0eABi/8NNhxw7pOu0FI+yxAqffyZgWRea6NJtoUsH7T
 m4EzjH91T8ZsXrf8+e5Gd8kITSsd7eJl3Az9lXIPjjg6J4asiyK7weatfdYctpq9kbNS
 npRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRaek1uB3fwrxgS07mLRrxqQl3BeBXrEuhkpww2dnZFDE7NWAJm8YMHFk+KM2idsCwDWaQ5vw2pKxUD8le@lists.sourceforge.net
X-Gm-Message-State: AFuF++lRMGQI7QrLhLPOBn9nW0Mx4PYEEllfmhZzpr3+YhR/VDZuCcOG
 2l/HzCOa8zwNK8rv/L720AmRfxklxwdyM8pybS/+JabdFwPjrRPZUQKxp+B2WDh2HZ4DhsskxDQ
 q8aZBPxl8gOpi/PBBGkC+np7GRTj+TStAsmRUVXZVI5cNHnNvGFtSOJEB/UcBjPJ+bcYT
X-Gm-Gg: AR+sD11iU1pk1YI8uKgnS2TUqIcQ+LMh+olwIevTCXi1ILvMXQuIjyU1vbjLdTFV2z1
 2NmTIPqq31Cx/YjI8AGiXcfmZ9ScmRpnW718yGch5NPxy1OAzh/F90AmC4bWuBUL9ZbldsxfTOK
 u/NT0xHb69ePH7jO83ImH5VSsHi206iB4gHLoBtXWrJD1cWnBBkJUYEt6qzq6VwqcjwIPbo6XAq
 g3N3mnhCpmCuAxYMqx7hytZhjFa3DVlaqSZeZs/MYVywlPa8GzpPMZiCRaRswERKW5VfAQvWoNm
 USr0c4JX7gvbba8DlJUB2pLq1YTkl1HXEQFgW6prsxJXJ9fkUzaCzIeQvzzQHowUM/LPm3UkCcd
 BXIdz1pSCzP6itARN1ncT4sZJ8mFtum0e0JA6ucp+qzkNsoxu08xHNKBwsLZbrKY/Z1bnMFZ26g
 rh8vNFYLn6Zcftv4H+7fhFoFBZgYe+T53buDG/aztYZxLX443/3D+rzO9sYNKTa3V9wQnL2jTrX
 Ad+N7HXW2PocK7CnnCn3sfm2+1pYNHxjsGvoUao3aICSAp7WH9PZR9jocQKtMigWLYD5ek79enQ
 gfw1UIX5BiTjKUM2whgJKWUr952ZYTPjx+u10oLfBWcD1uq6zd4=
X-Received: by 2002:a5d:6f05:0:b0:47f:80ee:744f with SMTP id
 ffacd0b85a97d-482b1fec98dmr9014847f8f.16.1787145611628; 
 Wed, 19 Aug 2026 06:20:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d3asm5365187f8f.23.2026.08.19.06.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:20:11 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:20:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 3eedb5f7320dd04d6e03d3bd276844115724f1c5
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 13:20:09 +0000
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94f4e71607602478759ce4bacdfb7a6fa13d3fe2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgDK-0000BV-Di
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 gen-release-tarballs.sh: Remove
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5320320961179325807=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5320320961179325807==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g+6Uur0oeYw="; charset=UTF-8

--g+6Uur0oeYw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1847?usp=3Demail )

Change subject: gen-release-tarba=
lls=2Esh: Remove
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(1 comment)

File dev-tools/gen-release-tarballs=2Esh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847/comment/2940faa7_b4be9cdf?u=
sp=3Demail :
PS1, Line 1: #!/bin/bash
> On second thought, this will typica=
lly live in `/usr/local/bin/bash` on FreeBSD, so if we plan to ru [=E2=80=
=A6]
You win, it is gone =F0=9F=98=8A

"Look what you made me do"=2E=2E=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I10b912bad3bb0b97e2=
b47eae20d2dd7ffb0c6879
Gerrit-Change-Number: 1847
Gerrit-PatchSet: 2
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 19 Aug 2026 13:20:09 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razv=
anc <razvanc@mailbox=2Eorg>

--g+6Uur0oeYw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File dev-tools/gen-release-tarballs=2Esh:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1847/comment/2940faa7_b4be9cdf?usp=3Demail">Patch Set #1, Lin=
e 1:</a> <code style=3D"font-family:monospace,monospace">#!/bin/bash</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">On second thought, this will typically live in `/usr/local/=
bin/bash` on FreeBSD, so if we plan to ru [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">You =
win, it is gone =F0=9F=98=8A</p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">&quot;Look what you made me do&quot;=2E=2E=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1847?usp=3Demail">change 1847</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d=
2dd7ffb0c6879 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 184=
7 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Wed, 19 Aug 2026 13:20:09 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--g+6Uur0oeYw=--


--===============5320320961179325807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5320320961179325807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5320320961179325807==--

