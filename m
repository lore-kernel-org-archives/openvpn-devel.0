Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300F1CA6018
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W17G+L1Hbd0PuVJ7o7fH20J0H1DrQ5Pziil5XuaA9Qc=; b=GtrQD+la2DWUu/cQEjbaqiYh2x
	uoWuOVLgJKtcnVxIkUVOKsukaAcX5gOepTlHTLHtpk4aLasBmL5HLjYwouumRY9umwTWVZazpIlfq
	HQUwYbx3j8j3Hcyt8Hub3XtK1snTALWXvDNyfOjFmsH5qV+triJZRZTHbIcV8idjG2vg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEyiO-0001Uw-0z;
	Fri, 09 Oct 2026 00:43:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEyiM-0001Up-Ij
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 00:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rj4Je6iPbWtTcn8t5EiZQT/qdA//ngfUIyTwLHO4rM8=; b=fo9QduMw6rnnysY2TO30as49Jp
 NT/XicudB01XTytVUDJrjMQTH5rQo9Vv9HbJ+/ThR6gXO5+vMM2OI1E9AaiLqTIVxRozlHa83C28t
 LjWL2bPALDDA/HWAxenCMHV99/pCKe7TnYIr5aVgMFlxhfslETK8ZgsIBdzVsx2GCoPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rj4Je6iPbWtTcn8t5EiZQT/qdA//ngfUIyTwLHO4rM8=; b=c
 aL13s9GA0ORDBZ5TJ+VJFQ/okVQLPHYlG8vcpOY2uoAK1/rfK58r5g4Rhoa4AT88ehVgdUb+PpkM0
 /odiD0F93mRGknEZpAoPa2gkX8rR79r5ped3n2mQGTIQ7AzoM11h70aL4C1fZLCzFvBoLfU170E5b
 LzfiQl1ubUz7eSD8=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEyiI-0000qs-Ll for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 00:43:56 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3214708f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791506628; x=1792111428; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rj4Je6iPbWtTcn8t5EiZQT/qdA//ngfUIyTwLHO4rM8=;
 b=fG93+pFuq6JIdQoT4gMxJII9fDPcXC5koT/89Wk584T1/LNfg5jCl2rcUFoKYuHtUx
 npIF8ewSgJAJRTwjjtpH9XEYSmwNrst9Sm2STfimBgYGHB99waZXBuqKp26SYLuwKKQS
 zG16xNP/z6Bz2OTv15vN5XvdZz/V8mU+/av7Fd6eYBIU/V5Gd+X+yqkHHWk2idtCdW8K
 cAP8RngzUoMQPKeoY73ngIk9Po4f8J+PnOQT1T8GiVM4oYAJWWmvdOWqkTm4BnIN2VPq
 2z2I9RHtZPr4gQhsxlf0NcHcX+7X4QqEnHCM1OoMPG8RpDrB/Vg6Q6YMEUFU5JrX5ilT
 mbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791506628; x=1792111428;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rj4Je6iPbWtTcn8t5EiZQT/qdA//ngfUIyTwLHO4rM8=;
 b=bqZoN/05NiCLhts3pTxijYzr6vPXIqvWFJkhKDou1Ebz7eKZ2ydJxFAv+vEVHptwju
 VYUmQ5QaOH4OyFnQcN0T8U/oCPNxZ38Rk3r6agKYlcP/pNKrchb4JHQLaYl2dQQpHa3B
 StM2iVfv3Rn2QKYCq5bopJ4W/hsvMAtbkEjVcEG0gA9pztk5/ZQCtgFuuXVsIy6ygXLp
 HOUXKRIGl0nqeBU6l1IWyZWx4VcnOdAKek9FPFDNtG00P7mcs3H2+ITkPiPh+YoV73yp
 XDXoJhLnNzInpqbsCDNgMP/b/yq5Q7Z4r0pCEM1DLdqfIXZABcdAug8d8rPXDZk4Rd3X
 r1LA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGPyYTcCFLQE662Q9vE04fttM1Y/RmH+lRwIxH1yNWJbhSjv933o6tuqQtn0Lnp0SvRm7ld4zjmVP3Itcj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKwb71Dc5mprOFjcaq9zkn2wMMTwdi5wZ43QtaGyyTDw0JN8Xuj
 8jJAP163WfC17xDuaNreT19JhsABjI2/KXX1c4QhZYqTPo0NezjogoEBF0hM3MUtlIPMWF8fPic
 Xq+SxJaI4HI/bc3warqNlyuORmIomLFiFn4/z+9sA89fFkcllmAX0QuQ0Fpwm7KOYZbIM
X-Gm-Gg: AYBFou20mhHeasJ8fphFFaKU+bViFZoELJKcPQ6r6Ee0p308Vw5p5d1+vYddbSb6Rr+
 DreXz5xcv+jkNVytXSqlq3S8gLJkSrkA6hzBaEhCd1Mb8c+oV6TD7xTW2959Cw0wunXiFnutXZX
 +fko5OdatbbzlYa1tyKyybDLz94Sn3uKmJSlL/6XdQ/H82VyJscWnT6CMLAGGPskoyQmO1/QDXW
 bHNWYmxstTKZgIeVPJJjyB66UIJJZBWRDZ2i47CNtaL2M8s8jZ9O1DndttNKdKJ5gZ2DJFGIupu
 6hxlASckB/QNV9SWhjGFzEeOnI5FU4R9iTpSVEL3irnYGUQfbHYES89F2C/e40oAANoWxkgN0eO
 rlWpH6qgDLduVN/derFl2aJVjpSoiY4MuLeMZPE6H1+qJx60P2eZo28TdAPfNXMSxHKHIZhcpIy
 QLm9jGbfF6B3qHPX18OpY9fEsICt4bZX3mQh64LQFS1VdbPQZkactDiBNEBeWjNX9sbBl9StNKA
 Lyive4TtHDcI5Yt0QhlEHTzZavNHJLb2VKyRC70OV0g7RWIe3JG/VhvcQtTIC+3OGrKXo2OFdJQ
 RAgW4c3d+71DjKSXtAdddKMIjnp5VwaOpzfhnCM+aYtPvsdtrKfvagCAGllq
X-Received: by 2002:a5d:6992:0:b0:48c:49bd:62df with SMTP id
 ffacd0b85a97d-48dba77d1ddmr453067f8f.1.1791506627954; 
 Thu, 08 Oct 2026 17:43:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf12bsm934891f8f.46.2026.10.08.17.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 17:43:46 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 00:43:44 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 34
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: cf6581d400b26e61f741e38666bf8ade15d0788c
X-Gerrit-Comment-Date: Fri, 9 Oct 2026 00:43:44 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <771380caa051fde61522a1fe578dfe382a69aff7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEyiI-0000qs-Ll
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1278806933970567378=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1278806933970567378==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4JW0giZ0Frc="; charset=UTF-8

--4JW0giZ0Frc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Arne Schwabe=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subject=
: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 34:

(3 comments)

Commit Messag=
e:

PS31: 
> I pointed out that you no longer need different source ports t=
o create sessions but also that this i [=E2=80=A6]
Done


File src/openvpn/=
mudp=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/73786389=
_fcfd77d3?usp=3Demail :
PS34, Line 334:     (void)op;
I unerstood this is j=
ust old code, but it's so ugly that while at it, it really makes sense to m=
ake it better =F0=9F=98=80
I'd just call buf_advance(&tmp, 1); (and keep th=
e commend) and be done with it=2E


File src/openvpn/multi=2Ec:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/1410f40e_e9aa07c2?usp=3Demail=
 :
PS34, Line 276:         t->options=2Ereal_hash_size, t->options=2Evirtua=
l_hash_size, t->options=2Esid_hash_size);
you removed a space: "v=3D%" shou=
ld be " v=3D%"



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id=
b59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-P=
atchSet: 34
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: Antonio Qu=
artulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Fri, 09 Oct 2026 00:43:44 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <antonio@mande=
lbit=2Ecom>
Comment-In-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--4JW0giZ0Frc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Arne Schwabe=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727/comment/d0f02fbd_5cb1b6db?usp=3Demail">Patch Set #31:</a> </p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">I pointed out that you no longer need different source ports to =
create sessions but also that this i [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mu=
dp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/73786389_fcfd77d3?usp=3D=
email">Patch Set #34, Line 334:</a> <code style=3D"font-family:monospace,mo=
nospace">    (void)op;</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I unerstood this is just old code, but it=
&#39;s so ugly that while at it, it really makes sense to make it better =
=F0=9F=98=80<br>I&#39;d just call buf_advance(&amp;tmp, 1); (and keep the c=
ommend) and be done with it=2E</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/1410f40e_e9aa07c2?usp=3Demail">Patch Set #34, Line 276:</a> <code=
 style=3D"font-family:monospace,monospace">        t-&gt;options=2Ereal_has=
h_size, t-&gt;options=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size);<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">you removed a space: &quot;v=3D%&quot; should be &quot; v=3D%&qu=
ot;</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792a=
d1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 34 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 09 Oct 2026=
 00:43:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4JW0giZ0Frc=--


--===============1278806933970567378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1278806933970567378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1278806933970567378==--

