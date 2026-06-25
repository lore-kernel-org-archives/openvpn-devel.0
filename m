Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F9FCDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wRZJzJ59o6NxDUius6YXzlAZdO5W8SDQ7gRKLlZexto=; b=W8AMI6zUTOzK1xPAnXbZUq5SSv
	YkDjF2DWI6TSb5q6Rogkslu0/UJzlkNyGA6GQ460GOIkmz0hPhE1EFc7yCa0tL1aKQkIfkB/isob7
	Qu+Zi81zoNWToRWlJJIqW3qgEAPa3uRuNnYH6fJNVy9QSY2d/I/iNFLsMEfhJ0HDDXTE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wck74-0006NK-6s;
	Thu, 25 Jun 2026 13:27:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wck6q-0006N5-Eo
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:27:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=47bitcZY5o13aTbHaw+SEYcG9vjjUdxpSsCMiGYpZLU=; b=QBCBVHZZ9VJa1pn00be0JMnh57
 e1oJ4ZeRsgKHAG1y55UMyhEKtCRuX6LJBBfXbkllRTIahBugbr9snhp1ncdngZaiI0n9K4ckwVGhe
 6kh+4gMNdGVOk/PfqLABN3uvVBoh4j2scFExUsdkO8x8WWrsOBjBAznKAWwumag+AupY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=47bitcZY5o13aTbHaw+SEYcG9vjjUdxpSsCMiGYpZLU=; b=C
 YZ/rbj80o+QjJpzoN5GsEkw8aOz4juBZRkuPqUMWGXfin8WlQOvXJjfnffgrdV6jZWanO+2GetmnN
 QjAIT24qm3p/eFRcUzAwoWIFna43Ixk7EYPJZsMerHe4LSkS0GolVhQl+HFeK/5ljKLQpqaysq8sD
 BCY7RMu2uQWnf+gQ=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wck6p-0000nP-0H for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:27:13 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so2101787f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394020; x=1782998820; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=47bitcZY5o13aTbHaw+SEYcG9vjjUdxpSsCMiGYpZLU=;
 b=dnY29i4b5jSETbQdGWNoJcdSDOi7JiKcu+3YouL0ePrGnsKLnozVQSjkKs5gjGIYsD
 j3xF8pwmHWUeUQaUR2C9fJVSwfJ9A0XUZppjK8MRzC0bWwiiQlhd96lrZt43Rd9R+m+Q
 DiHhTcaI+4y0EnzJKRjeh674GSA117dNEsDAYaUPXSKtL8m1ivH01tkVbKl2MJp1Dl1X
 F5NcmY+NYWLk16/uEN4ZlfbsSQB1Gj4f+27VV7IiNFy47rSzchcnoNgrI1ZB+/BiOM0x
 S9l0xauJkSb/LvZsjTwQiQXUx7QJtEirNX17/OpiqhjKhFJyChabetAJeevSUqlYnVQ8
 OS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394020; x=1782998820;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47bitcZY5o13aTbHaw+SEYcG9vjjUdxpSsCMiGYpZLU=;
 b=NS6QA5pBK7rYvroKkJmvC7KaeI+bAeavohGneXIESstTDPmraQVK+FEO+GsGrsohhC
 4pIgr79geOseCiM3N3QJN5Abe3hMl2VNkdN8RR4LYVN403qQYK6vDySzGPqLITIghPhU
 6x1RVlnTgswjHCxfzRUcQLbprBOEsEjCK5WPf6Ni8r6m44e43hWKti0Bx06gbgVXys0b
 Ki9KlC81nwwgqCgP/jCtwx1jC5J1no8yN4L1TrOkc+TAoJsPa+CRI15wET/FXZQ40lSi
 Ll+nGCkadD8po5EX5+raY/L0WxjmyZzJ/ahM90IlRfONH60e5XYc9+RCtkvXeO8tTW78
 cXVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/syj5I53XQ2QL5gEL5mn4Nfs6jRVxvuvVdNL5Mk3xLDUJgFaGKdmVP9TEsU8vR512n0X9AIjryoE6hp9Sb@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzAa0N5XJ45R0w8fMUi9rQYus0sRSCDeG/v3AU//wzXfyzEaCDc
 q66SpL1nbY1O4GhTDuJZblOENVxHqqKwePTd3EUijABvuICTt5EFe/1IEIzCqO9bpfRUzANDjfH
 05z43TZFSMoMcapGa/RnCp1Jrgt/Dfrp0YIImAHOpsk6F222rsFk2HD6MDLiuaPgtFSlSPZEY2S
 qmEw4O1A==
X-Gm-Gg: AfdE7cmlalQitoW2nJvxA295c9k4lbWodnA5dUWES5NR/3YJUeuMZNHF2hH3TV3TbE8
 zFh/tv8j2IzkAmqntypWN1uAGmVzGkNo9ZfDjEC7bWimuzlat0nFjERYlQfcngfU/rtDfbCRGX4
 9+j7QIHISy+HPFACcOWCG8orR7jrIyqjXw+SOd996JozsgWWLzEvscJI7DBbItJlcjsbZkGrfo7
 8hl+JCx5Rbq0L194p0BRsh+wPbhCcjJP87Qo0KjV4wTS8X4Q3l1CvLl6q1Z0KtVhj3K7URJdmzW
 RYEwFkiVblbotjLto7y4M6E9yG5GsuE4PprJdyO875a1kPvLNzWXy2rdK9Zt4B1KznCiRFnp9zO
 /kmOLpCkwp2PhGqfBN6Wp5CYsALmV6XQAxEEmWG9E9zo255xczs4MElVM9q+vxVmIXei7KMytIn
 /0xwXbCX4e1n17xjfOFVy3KtThNojPPZT2fZ/XdcxKsZHJOei5Cp0BZL8F8GMi9mBEYz0VSalYm
 A0NVFqMV/bqDnG8eYh8/0iHNgSxdBi5RWuiUv9QN+lv7ozTZIkh+wlGlH3dGlWVnTo0vQgsFGSv
 I8I=
X-Received: by 2002:a05:600c:8b30:b0:490:e5c1:b8c6 with SMTP id
 5b1f17b1804b1-4926686b583mr33500165e9.8.1782394019520; 
 Thu, 25 Jun 2026 06:26:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660ea064sm56903175e9.11.2026.06.25.06.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:26:59 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:26:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: e2d45132404457d5aec9042793f893d4a28d721c
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 13:26:57 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6364ed3456fdab5b72a8a6ec1f37a77dcfb6e057-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wck6p-0000nP-0H
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
Content-Type: multipart/mixed; boundary="===============1228750045083116586=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1228750045083116586==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VAKMBpU/YCs="; charset=UTF-8

--VAKMBpU/YCs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/c3878726_8d46=
0658?usp=3Demail :
PS2, Line 3108: multi_check_dest_addr_allowed(struct mul=
ti_context *m, struct multi_instance *mi, struct mroute_addr *real)
> pleas=
e add documentation for new functions
Done


http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1723/comment/b6132ddf_970f1f5b?usp=3Demail :
PS2, Line 3160:   =
  return true;
> this return is wrong and leads to memory leak
Acknowledged=




-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d00850229=
3c3ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 2
Ger=
rit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Thu, 25 Jun 2026 13:26:57 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@licht=
enheld=2Ecom>

--VAKMBpU/YCs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/=
comment/c3878726_8d460658?usp=3Demail">Patch Set #2, Line 3108:</a> <code s=
tyle=3D"font-family:monospace,monospace">multi_check_dest_addr_allowed(stru=
ct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">please add documentation for new functions</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1723/comment/b6132ddf_970f1f5b?usp=3Demail">Patch Set #2, Line 3160:</a>=
 <code style=3D"font-family:monospace,monospace">    return true;</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">this return is wrong and leads to memory leak</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c=
3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 25 Jun 2026 13:26:57 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--VAKMBpU/YCs=--


--===============1228750045083116586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1228750045083116586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1228750045083116586==--

