Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE9C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxpUph+r3XOea24Bg6j0/kxSri7ItQ3esgv8OZo9NgM=; b=Rn+t7OazVENiXmlWbofZNzDqNW
	1E+YfUzbQSxd97SqiFVaotgDTa1Jc+k92aTbiYZ/OZvB5ykp/BKG9X4y5BeOMPVNtEU3uxnLHuXwN
	9WW+nXwO3WDqNCdb/jinnlKTq56KUIpku+tMm+Zth5JpP/2lssreJp9n5Xwqk0S90kvc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclI-000130-NL;
	Tue, 14 Jul 2026 13:01:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclH-00012t-68
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lTdNXAP5sXTURSprl91YT0YtEBSIGyF4lBFkW6AljVw=; b=JqWU1QI62ylbgWdrOGn11clKPw
 HfixwhZ9PYYTEfL5Dh1zIbdL7394bwR56H2Z3o3U8MleUKC+d4S1/vvEXbb5WSdj/gKcUiJTPPsFN
 BhYGzGtZj2+3WLFliB7z1QpBrDYpD6QM0hHrtLW8nHYrtnUzYhUXOKRd4l805s771bmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lTdNXAP5sXTURSprl91YT0YtEBSIGyF4lBFkW6AljVw=; b=S
 +o4FBlNl7YACLqFH+lCTV5dFiUFJ1OcyztOAxcPz0XvEZM05XzJZGtw+OAbEQT/hQR6IuGMv3HNmX
 asfndrzPiv9dcHuCfYVLlL0nlRHfw9O4fhdNuzfZg8k/DaSRjxseen1Glic3HS8wJMWLFfOXaTs/o
 btMI/fQx+V/08l5o=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclF-00027A-1Q for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:23 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493f431e317so7919425e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034064; x=1784638864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lTdNXAP5sXTURSprl91YT0YtEBSIGyF4lBFkW6AljVw=;
 b=dZROEwachuYeM9JUm8MyJmzgujlfu2DIVEkHyFlFAWKMVlEcu+hnVP5hDjFEuaZyKn
 /L6WjTQ5fvu5DSDAfW0JhMzPDWkmhnyXUbuZ2kaQ3rsWK0wPe6l/HK7yrumtVYynEzIY
 Q4x84R4cRA/xbIJYh+x32gIWDoD0DtiW5cJiU+TZg0m16WgpSwz8QY/x8I11DzwA8P0w
 8RzsCRjSBURQ4IFEZ8ABBnralBBNXiSa9Y0p3L0yM2H2Stf7mFUU7eE66MwizLmbr7xR
 vT095agxEyVpNZRf/LKmhspKlX7nAjW2061LveCvdJPckwGmibNQi/91Iy6Gt6SFNWZ9
 uR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034064; x=1784638864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lTdNXAP5sXTURSprl91YT0YtEBSIGyF4lBFkW6AljVw=;
 b=XfVt0fnzbDicxeF7TFF0A9WWKTgDFr7sZdmLheJwsDPTXj852TUnHTBE6JFDWyo1Zt
 xEUkb9Dhky6/EnguArEoUr9mP3OHRwJxPf8LiU+MEuwWrzDg56hQYDahGwgkaBe6MoGY
 hYuOkzmf9KFXTuRnOfOsk2lhenpN0nElP7xc7ldG5MRdywTV7eNKp8ch4IMuxtW4Kbz4
 xcTt79zqbV8rxYb0EHToF3bzZakp4IjZr4+LO/0OoM9KTHj+ErUvprAwz8zY2fhHMq1r
 kL1FXD/6apV7Jvvbx89yZZM6sfADer3KnJH0bUK7uEMYFNlcxwFlzpQRGMHZiGLiXhLH
 WHsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5QnH2vrm4LVb1KjWaCqr9OfC0KXlQH/9IWLgjr/3mN2yr0z+7I50aQmbAQfV9+JxLMzztIIBDBbvN3tJh@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5QwcaNdg6cAH695f5mtO+/ubjNx7R02m933NlMJAdiSUh04W4
 JcN4abZIvm/7H2BU9c/3xXYTnwVjEDgtvPCQGBfoZagypDfgZPrzecb8kScSslEEkgBiPK7Flwu
 jrOHsKt2atWk02JTdMAK5RXnc6EVTWXighWdwZAItMCxuN52cpkE5IEIlzFMXGyLViFEXx3EFr0
 SYEfeXNA==
X-Gm-Gg: AfdE7cmORJRAnPg4eOSu9BpPDvuFY1OUyHp9Aal8wqgRML5038tqiObtDBBC3nSvfXy
 cblPtDp4mHL/l0e8NApMz6MrfyRKtT0FvVIx2w0v8R0iYqFaUE2vh139f8XLSt2CsrfhS7rqPL6
 O25N/xHLvPdyA3Z2v6tTJkf/BbvAtQ1MYtwPZuhdDqwbjro+Kw/gPjFUAzVkOnSj3IJddoV/ji1
 2gFUfsy/KHS/jYdaB0+US+KsGC75DcxAtugOHH3sC0VDpH/CzF3WzNurVSV7ZvUovvG3OCwAERI
 D6aWFPGPGOIP/TzmaeLiGOz1enjvB3EHGY4w+6gSQ6VRMb/wGdA90HskipEF9NsqXo+iEELsK5k
 XfhPij3CY+02DTOVOqD1XlWEu1x9zqugnuj410Nu9wa+/7k5AbH8LXijmFWRGh6qMPtil9/JAHl
 bkUrFKRllE20J/oG8DNJZ9lN+ayR6lQ+GlaWwILBIqAh94CBjcoFf1iUo0pf9Aqz8PzPMCrQteL
 Cz9Bzo26d9p1PK5YFI3V+OhTnOHYd8CBILIJITP9hYOrtJFhY+2isAotAK43Taj6kvvBHbypijU
 nFI=
X-Received: by 2002:a05:600d:8649:10b0:493:a7bc:5bcf with SMTP id
 5b1f17b1804b1-493f8818107mr107074055e9.24.1784034063564; 
 Tue, 14 Jul 2026 06:01:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm392908505e9.2.2026.07.14.06.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:02 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 3d148280b63a069b8d6879a7d9be7e5175292aa9
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 13:01:00 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3441e3d3513906e4366fa4905ac47f060ad15deb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclF-00027A-1Q
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
Content-Type: multipart/mixed; boundary="===============5077031053069328332=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5077031053069328332==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NRv8+eBe6/8="; charset=UTF-8

--NRv8+eBe6/8=
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



Patch Set 3:

(10 comments)

File doc/man-sections/advanced-options=2Ers=
t:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/d82a4f50_1f10f5a=
e?usp=3Demail :
PS3, Line 32:   address table to ``v``=2E And if specified =
the session id hash table to
> "If specified set the size of the session id=
 hash table to"
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comme=
nt/2336da00_72054d17?usp=3Demail :
PS3, Line 33:   ``s``=2E Otherwise ``s``=
 be set to the same value as ``r``=2E
> "will be"
Done


File src/openvpn/m=
udp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/fa7d8345_5=
eed2d6d?usp=3Demail :
PS3, Line 383:         if (m->top=2Ec2=2Ebuf=2Elen < =
9)
> Why hardcode 9 instead of "sizeof(struct session_id) + 1" ?
Replaced w=
ith (int)SID_SIZE + 1=2E


File src/openvpn/multi=2Eh:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727/comment/10ae17ac_5a2d983b?usp=3Demail :
PS3, Li=
ne 138:      * id here is non-null and the hash map's key pointer uses is p=
ointing
> Not sure what "uses" is supposed to mean here?
Done


http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/0e7fda90_da142616?usp=3Demail :=

PS3, Line 139:      * here */
> What is "here"? Sounds like it points to t=
his part of the struct, but it actually points to the begi [=E2=80=A6]
Our =
hash map is a bit weird in the way that it does not store the keys but actu=
ally only pointers to the keys and this field is the key while the whole st=
ruct is the value=2E I adjusted the comment to reflect this pbacker


http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/cddba2a0_341624a4?usp=3De=
mail :
PS3, Line 178:                                             session i=
d=2E We do not care collisions here
> "care about"
Done


File src/openvpn/=
multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/03567279=
_523e52ce?usp=3Demail :
PS3, Line 441:         if (mi->context=2Ec2=2Etls_m=
ulti && true)
> "&& true" ?
sorry=2E Debug leftover=2E Removed


File src/o=
penvpn/sid_hash=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/commen=
t/7f6f7a89_099de1be?usp=3Demail :
PS3, Line 35:     /* This only be called =
if the multi instance is not already present
> "This should" or "This must"=
?
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/ba72e6af_e5=
b31bda?usp=3Demail :
PS3, Line 52:     struct hash_element *he =3D hash_loo=
kup_fast(m->sid_hash, bucket, sid, hv);
> Could reduce code duplication sli=
ghtly by using multi_hash_sid_lookup here=2E
Good catch=2E Thanks=2E


File=
 tests/unit_tests/openvpn/test_misc=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1727/comment/b66473fc_30efedcc?usp=3Demail :
PS3, Line 143: get_ra=
ndom(void)
> ``` [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Numb=
er: 1727
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 14 Jul 2026=
 13:01:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: flichtenheld <frank@lichtenheld=2Ecom>

--NRv8+eBe6/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>10 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File doc/man-sections/advanced-options=2Erst:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1727/comment/d82a4f50_1f10f5ae?usp=3Demail">Patch Set #3, Lin=
e 32:</a> <code style=3D"font-family:monospace,monospace">  address table t=
o ``v``=2E And if specified the session id hash table to</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">&quot;If specified set the size of the session id hash table to&quot;</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1727/comment/2336da00_72054d17?usp=3Demail">Patch Set #3, Line 3=
3:</a> <code style=3D"font-family:monospace,monospace">  ``s``=2E Otherwise=
 ``s`` be set to the same value as ``r``=2E</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;wi=
ll be&quot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
27/comment/fa7d8345_5eed2d6d?usp=3Demail">Patch Set #3, Line 383:</a> <code=
 style=3D"font-family:monospace,monospace">        if (m-&gt;top=2Ec2=2Ebuf=
=2Elen &lt; 9)</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Why hardcode 9 instead of &quot;sizeof=
(struct session_id) + 1&quot; ?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Replaced with (int)SID_S=
IZE + 1=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/multi=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/10ae17ac_5a=
2d983b?usp=3Demail">Patch Set #3, Line 138:</a> <code style=3D"font-family:=
monospace,monospace">     * id here is non-null and the hash map&#39;s key =
pointer uses is pointing</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Not sure what &quot;uses&quo=
t; is supposed to mean here?</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/0e7fda90_da142616?usp=
=3Demail">Patch Set #3, Line 139:</a> <code style=3D"font-family:monospace,=
monospace">     * here */</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">What is &quot;here&quot;? S=
ounds like it points to this part of the struct, but it actually points to =
the begi [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Our hash map is a bit weird in the wa=
y that it does not store the keys but actually only pointers to the keys an=
d this field is the key while the whole struct is the value=2E I adjusted t=
he comment to reflect this pbacker</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727/comment/cddba2a0_341624a4?usp=3Demail">Patch =
Set #3, Line 178:</a> <code style=3D"font-family:monospace,monospace">     =
                                       session id=2E We do not care collisi=
ons here</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">&quot;care about&quot;</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/03567279_523e52ce?usp=
=3Demail">Patch Set #3, Line 441:</a> <code style=3D"font-family:monospace,=
monospace">        if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; true)</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">&quot;&amp;&amp; true&quot; ?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">sorry=
=2E Debug leftover=2E Removed</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
27/comment/7f6f7a89_099de1be?usp=3Demail">Patch Set #3, Line 35:</a> <code =
style=3D"font-family:monospace,monospace">    /* This only be called if the=
 multi instance is not already present</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;This sho=
uld&quot; or &quot;This must&quot;?</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/ba72e6af_e5b31=
bda?usp=3Demail">Patch Set #3, Line 52:</a> <code style=3D"font-family:mono=
space,monospace">    struct hash_element *he =3D hash_lookup_fast(m-&gt;sid=
_hash, bucket, sid, hv);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Could reduce code duplicatio=
n slightly by using multi_hash_sid_lookup here=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Good ca=
tch=2E Thanks=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727/comment/b66473fc_30efedcc?usp=3Demail">Patch Set #3, Line 143:</a> <cod=
e style=3D"font-family:monospace,monospace">get_random(void)</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">``` [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=
=3Demail">change 1727</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Tue, 14 Jul 2026 13:01:00 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body=
></html>
--NRv8+eBe6/8=--


--===============5077031053069328332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5077031053069328332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5077031053069328332==--

