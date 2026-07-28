Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB31C54F51
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsewWHO5VCCN0Pcehmo0nhox2Vka88/Z0L286yeUzQM=; b=XoHncRpKQsnkAJxkdtXN7bhzJm
	3D8rFi2VAIg2J+kp3+hHhHkDLKYfo4L7tzjDYJ5UFOHMMj44Whvk4Umy2sFYLYMQApNRdyKcDkPyh
	DhvW2A3zayKkDwdnMCqNkteUu7aVItaJYAeYtyzpMI6by0VzFHh1ggENAOkv5EfkV2TQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woqmW-00083s-Uo;
	Tue, 28 Jul 2026 23:00:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woqmW-00083m-2O
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 23:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cIx8FFk5N95Tudn+lNRvqgeevKcURzg2yP0An0EHEMo=; b=kRjFHo32DUyWfna4cUozXfxd2T
 5hjDtI9ZaLPae4Suic0lCdObdJs+En8KP79xbdP+D1/HJYMdMHp+k58VbVhpJy/CaQfVWYel+EXpW
 RnfxelUA/WOOY9G+K9X+8nn+UM9c/aLOjZtivsYJpQ3BGHLq4ru6Ma89xFPR3BZsAGiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cIx8FFk5N95Tudn+lNRvqgeevKcURzg2yP0An0EHEMo=; b=X
 u2NIz1+9Qgx0sV2r3RUk0cXwJJb7OUF+S6aSzWrWTKtq9znMNdFwmOP5Z2IMHeVjAr6n8gXvoqTb0
 jsAw4I0P8yxYN2qDLDmSXqNqC6xBsLjQz5XQyk9S3frOUC/Fp2jWgyvmt/Qw5pV/FcaEkM88Nf/zC
 LmW7yqGxf5j1XExY=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woqmR-00080c-GM for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 23:00:13 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso2402455e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785279605; x=1785884405; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cIx8FFk5N95Tudn+lNRvqgeevKcURzg2yP0An0EHEMo=;
 b=dbWL5VpZmdQLKo/mwX7FtF4OwRKoBKxvY37f+26aufvH4iISbLYCzsp777vGxNMThJ
 aU3u2wsAfL5ECN+5Edwb5RsC7ohoXw7pUIgAx1HCGB7cLiJ+12ctal5ZEu5lVQDhVyeO
 vVKVBfYbEK0BHyl8cFVdrgUYEwQHlQ0fDTjPknnUVebh9ofAkyP8MjRDDvK8x4m64N3k
 ljJ3x6GX2ibszZr3nDNaEYK1ZjpsJqt6znh6stupH0rYKEoOvhwaevY6ndqaOy+WIOBO
 ZBNHv624vMqcrYk8Ddnr676Gw4dfjHgQouibwxvthRrll3LtRd5eFgaYp+vjX5g6tBld
 QPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785279605; x=1785884405;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cIx8FFk5N95Tudn+lNRvqgeevKcURzg2yP0An0EHEMo=;
 b=BSZ6Oz5tSNPVAZNF5YVD6emUgUSKnwrtBG9od7JojFhbF96LYC27WfIDEf9X7e2bNh
 JPjUH9eIz9Z83J6uoh2/qRlnZ+ngswPzhcZVrzsgRpk1DQoMymjbkYCZ52njLK0ogViL
 fTpmHVkdyax4B9K94OEXa+GdJSqrIXg7al3t0df9d+bqwf8bshVzLHrnukwQobZiuhEi
 f35g6W4cCfCPNMomdSrJcw9F2n4uA4QXHpfk+2Sw0FzPtohQXrJNpqaKyrTnEyYehlJ+
 rRrvhgN+X394iOEwK2Wmpa78yZWbPeiYFuWTs4VAle1HrSe8WMjc6poTVZl+/Ofbgd7h
 feLg==
X-Gm-Message-State: AOJu0Ywt8l7q/MjHtZw7utn4PE8tZ43TTryfl7LU6WA+ObwncHt84C0I
 lq/yJQ21xXvFwMkUnmD1XC3uzay53PeP+Oq6XbV3ETqB0Vh9n+GB9Lm/V+71P/iwjTHO5gQzU7B
 BAQnP0S+iopu0sD7f1KjM/L+XTkEl+NHYiKXNUpCS5AG/ukEeRDnn5gt6rc/CeJI+/P9XX2oJsr
 PHYLRW9A==
X-Gm-Gg: AR+sD10My0nEje5o2yVakPkHo+G/eS5szDbzuHUgwB5MslnKNyI6EN2a3D+KIpYAgjK
 CUPSXBLQWMfnniI7K5v/t+UsVc5mJEIaeEoi2oGtIsFVGM12+EX119oCUk4lgPmcvfXuZxZsGE0
 3/a4Mhfn3vpkQhbxdfpQXP9SpmsQpO1+Qr2gpNuy4JpOmPum1BNVeI4e8vQdWKvubmlelGZrRan
 w3jUCSC0XpD3KSYhM/7iXjwvhao/mvqujxYV087chg/2xyG0QfD2njAfIstrxAk0tNglwM2w/5b
 J1DnHCWu5OTsLb3GvajM8YExwC+iM1WoIeQiFr/z0L18GgOrFEG9AQ59lY71fVlN3arzWtin6AL
 lBw1lmaCAesdC6zu3lt8pi78//fovpTOnhk/yoMiIKs6ljL277ztD1MZnOTF9/1rcrDq2sIludU
 7SKjSFShWLuRHMEkrsufZjgPynh+HspccPz78bFWUw6nwQIMP6nMhlr7ofoKmGdKPcRQzl0vPY5
 FwRCtzR6ZNlvfjy2ZxDU/1PxT8mZAotGeBhr6gWr7JfrRFBKKNL8PySlvnUj5jKiHU66UWCV/6U
 P19EJyY4KuyGHHlejX6YiJAoHdUT9xbNkfL1Ch+L4fbwoRo3P1s=
X-Received: by 2002:a05:600c:4584:b0:495:501a:fcf8 with SMTP id
 5b1f17b1804b1-496c6575c60mr40446785e9.9.1785279604819; 
 Tue, 28 Jul 2026 16:00:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfc2ff2sm297900965e9.4.2026.07.28.16.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 16:00:04 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 23:00:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: c4c3172a707875fbb49f214adb2c12526d545488
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 23:00:03 +0000
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4b707de27f6fccba72aeeb832f97ac350423282-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woqmR-00080c-GM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Correctly calculate
 packet id size when epoch packet format is in use
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
Content-Type: multipart/mixed; boundary="===============5605730521959655611=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5605730521959655611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2/elE7puBRE="; charset=UTF-8

--2/elE7puBRE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail )

Change subject: Correctly=
 calculate packet id size when epoch packet format is in use
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment=
)

File src/openvpn/mtu=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/182=
9/comment/ca860431_f7fc1356?usp=3Demail :
PS1, Line 59:         return size=
of(uint64_t);
> since we don't have explicit members to call sizeof() on, h=
ow about a little comment explaining the  [=E2=80=A6]
Done



-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af740=
6f6f4e
Gerrit-Change-Number: 1829
Gerrit-PatchSet: 2
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ordex <antonio@mandelbit=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Comment-Date: Tue, 28 Jul 2026 23:00:03 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom>

--2/elE7puBRE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/mtu=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1829/comment/ca860431_f7fc1356?usp=3Demail">Patch Set #1, Line 59:</a> =
<code style=3D"font-family:monospace,monospace">        return sizeof(uint6=
4_t);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">since we don&#39;t have explicit members to cal=
l sizeof() on, how about a little comment explaining the  [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail">change 1829</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b862eabe032eb=
4d2229ff5b2f4f6af7406f6f4e </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1829 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 23:00:03 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

=
</body></html>
--2/elE7puBRE=--


--===============5605730521959655611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5605730521959655611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5605730521959655611==--

