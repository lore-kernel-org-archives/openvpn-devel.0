Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814F1C88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1LvG+Mnec+fga3gj7PWTUzTFnnNseeWPVZp9DgbPyQ=; b=bsXXE4bAPJFdSJmZfEvXRfnCg7
	drNHOcK6GnENvFslCL5l4ZdLNGFJw4g3AIncN+ZCxjanqe9alHZaN6WfiSH0AAIneb2gxQx7mbTq1
	aOqPNDz55qkhsLs0DLpWX2HIXqYNiu2Vnf+HB0Cbp0VrsOtNjiG1sYc+8WWwtTUwyVpE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x51E4-0007br-Jf;
	Fri, 11 Sep 2026 13:23:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x51E3-0007bj-Dp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XRwpdRXMFFtNqp+6uG0aIlcwi/ouWwbV18di6pim/wk=; b=glJub3Re9Cz8L2paGeJi20hr1y
 jPwPRg/+r8pfk7f0WAmZ2JpCVWIlh3a16kSplh20/5w7prWyXafSSV3y7nSfpZJlkxG39VBF+Bahm
 FH4R4jNcwiidUCdedzYNwEHa22iCwIkMnc3Fh7Xx2cZP6LvnlQbCtA6vy4kUpVm2AfIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XRwpdRXMFFtNqp+6uG0aIlcwi/ouWwbV18di6pim/wk=; b=P
 A96khRrNfpV2q8vdn3GolUmsCaZ+mSEooSv6XqyiWMcQRzgbE972qS/Wcp8lPhxMv+bpufWAwkw+H
 +ztSQZtjKBzO6l/EB8xkFVDuyH6mjX1mon7Wx0zy1gCBhhlsJfTKydGPAQBNTe45SbHe0GPzTfkYi
 ZYaI7QxrdkC9Lldg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x51Dz-0003co-AD for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:23:28 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso7956615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789133001; x=1789737801; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XRwpdRXMFFtNqp+6uG0aIlcwi/ouWwbV18di6pim/wk=;
 b=Do050930eAi+a9t+1XBNTaC7hsJyVQwK2mJgm/jJbQwnBtAM8Wad3SfKuX+spIeBbB
 WHnAwnY4ajqsvKvvW5uyulkiKxwIOAANsFBTW8ZjHp0oaJF5NmvdGLqPxa7/n8gtdhu3
 Zie9TLqkzZDLuWu3R8mm8bXs4y7BBYbqgXaWyuHmSuvM3cbvEOz+D2FaDdXr0MtMfMPm
 g04Z4u1VjXN1HbcVEhnz7z8Yl2JwLJtjBgnvJpQaV1tFVc91yYEDF0wKy5BLW3xCGyLd
 /SLwwac8pZPdK++k3UEjs5VqxpgGeo9GAdJBiEfjB/uCJ4E7vN0GFcry6kFPFsfT1pMc
 yyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789133001; x=1789737801;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XRwpdRXMFFtNqp+6uG0aIlcwi/ouWwbV18di6pim/wk=;
 b=eYSGfGidKThdnO4DMcZn2a7TBOwddyda4FyxbGQUXtXosVdrtpQpMYbtOPe+D7Iqfv
 jT4DvBsS+gfPVLRele/ila5D8c/Juo2iR9H+Hb3m/dQ3zRZHuWE3wGj4EX1qflu2Ljri
 NssAfQNz6hKEay2vhkoxW8t8VD8OEHl/xLRqOD3jpKPKZFRSvo55stVoFWby30KGWn1z
 ZTpWCpvhPbmO4zn/enzwTehqz5i048flKyL7MzIvy3MBFD68d/k+LZg7NKJO3C3AVKFO
 DcglP30Wwn7TAZR0Dd1peuXrm+9SunM+ds5P1BIAIhvyhub9hanAUpmoeFvaHGwmE3R3
 Um1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5cJIKtRMrmREeeZe7FoXDXqX3lrnrgh4DLqJQqC06EMpp5wxJRJLGeM6kLS9yPba6UIrcrjkh1iV0R3s8@lists.sourceforge.net
X-Gm-Message-State: AFuF++kaOwmsgGodxwUsv0/R0cNNt8B8gHs/unu+LaKGQ1wa0blPjMnE
 P5Cnnqb0KYthQPJPApk2UQBz35GErjOxd1qRTLgB1tqbPsNKS1WIpMtVjWVPUZKeoXb9aoEGfsq
 n/6wwlDQ6G76tYQC2VBt2gEXULOX1p6GabKYAl2bHOPSn7hvxDOkFhsv7tgOgJtakiTcUcBaWYW
 psGB2kow==
X-Gm-Gg: AYBFou3RJIbjyddAhN9eeSsDRbRhlbab3x5gj2br6cIo4Lk+nGlEN/+a/t+amecOoW6
 8aSlTXJc/xp3fTbnuUODNugxdV16EiuDpUsQLs73q+Lvrg+zc8KG6S2AeotRbT5gwbAVAFbLVFe
 IrhDKX/L1Rh/dRhmbkiFO5IcVzQ8eiee7pAt7RFjTl/PiLmlQnB8HnzZHhq6MTUC+di0H803B48
 jS3msoZezAI1ujvluoy6CcjMp02ftnaCwaVb4URPehdJATd6DeSFbx3sYJIcowSElKMya9ZXNRD
 44D59m3njCJJvcpdqfNcldEChjSSJmKEd1yc7XsCFDpumfPCARrqOo9dzPuZlArG3Yw+zEnctyc
 FfIEemtdxCFzQkxDJjtCXGKjBPXMcRxLmlCw2ZbuV6A3IXIC8yjy15iw+eTXFbjE2uOy4l8z2lM
 NA0ihSjrw2gWRlfNHKlV4ZWlHBxhwQ9DwUT1z3xXtHDqH1Fh1Ge5nIP4ML4eQJLciHZeP0PfpKi
 Suz8bgSBVJjp3ACU76gfO+huYWZ5G2k4fWZnlX1WnJfSFgKkBlpVmjJ8Lp8jHCjy+2NgMPKEBiF
 Y7uf3cCapIx43w6ioORiJO7JCaS76c2i7gbY7shUU1YaMZOXPfBN9/GjfU0UGQ==
X-Received: by 2002:a05:600c:3b27:b0:49c:fc6e:a3d8 with SMTP id
 5b1f17b1804b1-49e619cc2aemr51770905e9.23.1789133000472; 
 Fri, 11 Sep 2026 06:23:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62cffaa0sm23519705e9.0.2026.09.11.06.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:23:19 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:23:17 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: 8126032d14b9fbf864424f8c4982da147220beec
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:23:17 +0000
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <814a7b361a3e1c6c0bab2cbb1fa8c5de5a50f647-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x51Dz-0003co-AD
Subject: [Openvpn-devel] [L] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8276836861931254327=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8276836861931254327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GFLIXXwQsbQ="; charset=UTF-8

--GFLIXXwQsbQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1904?usp=3Demail )

Change subject: buffer: When extr=
acting pointers from buffer, retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0=
f9e
Gerrit-Change-Number: 1904
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep 2026 13:23:17 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--GFLIXXwQsbQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 4:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">change 1904=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib4af=
7639cdebe81eba05ab04efe6e85e63de0f9e </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1904 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 13:=
23:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--GFLIXXwQsbQ=--


--===============8276836861931254327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8276836861931254327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8276836861931254327==--

