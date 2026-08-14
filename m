Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B86C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HIYeqCNneR5H3q2LwGOzqUCIpBNcYq3aRNAEGH0Wzzw=; b=E5Sj0uTY+pqueLUSUGgSKJZnqj
	tDVyT3ZRnBCrccp/lI0+mzIX6uS+ZoG02nFXJ1mto/j+piRcYECrtTS3KnAivfUTKNZf5qLocLKWs
	wthNe8T3tzHuk3oZusX355GO1C8xGX9iHcj2yEFDCwwJwfgZlaSslNMfDiOJPpGtNO2k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupcB-0000Gv-Kg;
	Fri, 14 Aug 2026 10:58:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupc9-0000Gn-Pj
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=N8nI7hgZ7bddkMIO3GSwXElamRDJXr9CiKCTiyjvm/M=; b=MMx452eua82Am+x/fHaFbJ2qE9
 aXDa7WMluiBJA1lVsGilzK6rdlJRl2sgia98+GQKYHIhg7pmv6UKnULaO1LFByePA+hFbOpnGkHl8
 b/MXw7+f/VFTPnI8r9pm85zHVvlNI/d+JUDHFZGOrpKpdAY8iY9FbTEugTDrKzQurqMc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=N8nI7hgZ7bddkMIO3GSwXElamRDJXr9CiKCTiyjvm/M=; b=L
 F6uJHxmdq6h6sL38Dxhx86N9ZOXXEW+8/FQstiju+jxcq7zKbe5NmvxZEgV7IgzSGxtfKDlDoVja4
 UdOmqD5XpcO6Gcuzs6LAW8DccPFV/aMuclUZl9bgoD201sOJlxUmecXe1ku6pKiwpWTVsPIGkhZY1
 eRlGNN2bvm/rm+Hg=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupcC-0003p8-Ii for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:58:17 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-481412f1828so300333f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786705090; x=1787309890; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N8nI7hgZ7bddkMIO3GSwXElamRDJXr9CiKCTiyjvm/M=;
 b=G5NcodK8+Bt1lgsrSyw8b/lbzx4uoj6ADb71KzlEGbG6VVnCoV+YIFVzNxfAg/nUYr
 qcScQ8idEICxHjfdyrrbScfSrjpuwHbRXaMuBGVMfCbnJZEacy4bx8FES5wH1RzirCpN
 4qjXu4Sp712/66BipHBg5xXV6nlTzY6bVBc4fLxnM2d3KiC4WmVJLRc09gAzDFSVMjDC
 EsMaZnXKJXKhE15xrcIS2wQkMCfnoL3WdiWU5uHbGA3ASEw1+kkcWvAYnp4elGqqzWgF
 nzWMKwNiXBkXwGPGhshQKWcvlbFz1Gs/pozIYJsw76leW84chQTSUm4Hv2vdoLR+do/j
 H4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786705090; x=1787309890;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N8nI7hgZ7bddkMIO3GSwXElamRDJXr9CiKCTiyjvm/M=;
 b=ZfEGFIa0p+fsjojX5Cf1Blil3LaQz9fy67jdNk5bKz8v+Skc7BzOIv0tz42prL9SlE
 KK5rGYcvzVuSZPx+nzus70+Fb6za41gVs0rXpEL5ML2TGULi43T/Cj5wFYZwDWGQPfBI
 T+BLb7UC/8D5m9g7jQVY6QXAZnOgUsvLn5Id0jiBf0sROanTprqRripT+qy3fInVix8V
 /ohCv74c62hoHYGf+acJRZQChhc+ZCfezUtU3m1Envm/JNss3tvXxF3kXFBhxJFwZNIZ
 xZaNFa/U0kfNOPdh4R98CHEpLwJgR3Z/CvDqyLhq3OS9RhTM+D/MjuiIzSUpxTjmsFUm
 97Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiH9x+iczNe8ksrdxSU5/Z+4SM8Q/TqL5ei1uy0LZmISUEJe6BkUhVUUb3Z/OBp7fUghsunRrSsu/p/sXE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywm1b2hz6VtQg2zdfQODVg8lNuWK4/TzYPyjsaFgKMit/i8kIvH
 v+L6R/pAj11YKezQuVq5AiplsqD/IjyUqNMlUYZgEXStPdY2Wr3+zq0KV6teej1w7MbtUJcpekr
 gAvdMwByY2Qi8JHk/j5XDQJLN9wJ5VSHCrmDCx5gRYki5b0WKAVX0aDjajU6O4LVS7F36a9mcNr
 nFrk3bQg==
X-Gm-Gg: AR+sD12rZVWChh/rly0IqA4CHowRj7Vho1d+WLffQCENruLy4untdKtzyUwu4no7KXV
 ZmQii/x+y0AbBsFFHRcKCLLJhkBWeooUclOR0cu4sDhTV1eaasNLsHb3kztZ5M85SwC1BFXZGrj
 7CdP+MEsfW7jgIE6HhOZb1N9AEgctnMZ6hZNc6JOj7RINqPx9klqhaAgFSoBGLHpC8IGNtRwuHx
 sv+Rwnbxcds33ut7OwfbkSfCW/kjYh10ReQ2jb9lnQCgW0z6icpSPB9XbMRHjlay+Qbx+nROVOQ
 HVmWLGub0vWfDiZlwvb7873FAJDqTGWUsiRh8wtZONRck3qUtMJ4z/K8OVEG0m85iiYCxT2Xzqp
 3SJm93YKwgseMSoPfMpxvO14lXUyvWJEO0V5yo0Hb64w+LwhjpE1S1cHdefJEb9PgtTbo/iG0HN
 bVdY1KIi7eLSpGJp6FGEb+rMMnzduQ/p11Bw7LZQ7+qXRX4UXeVcqhxCLCYrwmQfVN0Icoilnpi
 djdSVnKIhPnSwyykIHIWctWnCreJIsPrZxIVENLLiYmjVBMyF21JKaMItZqpRNmw5tJuEh/RN02
 VCya/qSd+cP9oGMwd25/JiEXy0Oxa40cgIRG8IaWCVdYgybEpqg=
X-Received: by 2002:a05:6000:3103:b0:481:45ed:cb50 with SMTP id
 ffacd0b85a97d-48160748a82mr6866542f8f.16.1786705090289; 
 Fri, 14 Aug 2026 03:58:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1d90sm7602446f8f.22.2026.08.14.03.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:58:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:58:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8f3545f703126dbe96f809e69ad351749b14b1e1
X-Gerrit-Change-Number: 1719
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1719?usp=email>
X-Gerrit-Commit: 05458f819cd4616f46e2d080d6017fcf19dfc501
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:58:07 +0000
In-Reply-To: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8f3545f703126dbe96f809e69ad351749b14b1e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZjM1NDVmNzAzMTI2ZGJlOTZmODA5ZTY5YWQzNTE3NDliMTRiMWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <625763efb1607fd38f3c2ddc66717802828922c5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupcC-0003p8-Ii
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support p2p NCP
 negotiation in p2mp mode
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7376397455763265580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7376397455763265580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Od8/TpBzkhs="; charset=UTF-8

--Od8/TpBzkhs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1719?usp=3Demail )

Change subject: Support p2p NCP nego=
tiation in p2mp mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5:

(1 comment)

File src/openvpn/ssl=2Ec:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1719/comment/a7bac6e4_6df00243?usp=3Demail :
=
PS5, Line 1896:     if (session->opt->mode !=3D MODE_SERVER || multi->use_a=
symmetric_peer_id
Is this new condition needed?

If opt->mode =3D=3D MODE_S=
ERVER, this requires --tls_server, and THE new condition will always be fal=
se -> contributes nothing=2E

If opt->server is false - we cannot be in the=
 server mode, so first condition is true -> again, new condition contribute=
s nothing=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1719?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f354=
5f703126dbe96f809e69ad351749b14b1e1
Gerrit-Change-Number: 1719
Gerrit-Patch=
Set: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
G=
errit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026=
 10:58:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Od8/TpBzkhs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1719/comment/a7bac6e4_6df00243?usp=3Demail">Patch Set #5, Line 1896:</a>=
 <code style=3D"font-family:monospace,monospace">    if (session-&gt;opt-&g=
t;mode !=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Is t=
his new condition needed?</p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">If opt-&gt;mode =3D=3D MODE_SERVER, this requ=
ires --tls_server, and THE new condition will always be false -&gt; contrib=
utes nothing=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">If opt-&gt;server is false - we cannot be in the server=
 mode, so first condition is true -&gt; again, new condition contributes no=
thing=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail">change 1719</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1719?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f3545f703126dbe96f80=
9e69ad351749b14b1e1 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1719 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 10:58:07 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>

</body></html>
--Od8/TpBzkhs=--


--===============7376397455763265580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7376397455763265580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7376397455763265580==--

