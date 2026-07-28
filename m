Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18DAC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AX63YEQTX4EIXtptxZ7tyrUvDcmnpxLDpEzKts/PIx8=; b=SjokPNk+9PUVv20qzUb6slPInh
	IK3ulsLjSacdWlp33BGHFtRAvHPBHjoxeBnbtGjs1bzslxE1IEtPZosUYU+SDdRTjUpSZnbQQCLIL
	b86Th5zXdNBTSw+go4BSn0hS6QvIKEtjvbC8va8QZ1R1WaWl6qcT6n9UZH33P1BrlFSQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1won8a-0000qh-K8;
	Tue, 28 Jul 2026 19:06:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1won8Z-0000qa-M4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 19:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iD9S0y6xme7NcYdX05DO5xdOPy1BQO7vzVCzGAhv03o=; b=I8mVN/qVw8YjwYHkr0Jff4h42T
 cY4qi4Vkpi+MNqRmAJqguP+5J9J6EGQg6nHM5/P7y7khT3qJU7Og5WzQ62Swd4jjYwKjpDdVGyM0a
 OxO/VmWDJGe4lWZBI3LPJDBofwWnCpjAASL4r7CAs0Jyp3LuOclUbHX9RlmaEeRQGEn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iD9S0y6xme7NcYdX05DO5xdOPy1BQO7vzVCzGAhv03o=; b=V
 Dc0geqV+MFqhXj5DJiUesUVObF7/lHWwol/JNvE+veFL2dCmqYQLloGFq6Eyee3b7CKVsSxLfDa6O
 7/GC7krQPdvmedwI+rgVszshuHMtHAJvYjlN6zKhXe2LBe+YT/ugzsgnnCa/sCBNRWXhdST+E8eUA
 vd22iUWuWuc8kh20=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1won8W-0001Bq-Cj for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 19:06:45 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-476a130c138so252745f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785265598; x=1785870398; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iD9S0y6xme7NcYdX05DO5xdOPy1BQO7vzVCzGAhv03o=;
 b=EFki4ibVFJ/Pdgw4GTkapg0yB2c0g6IKjRd/tfmv4H3GggcBplv19/SGgQTLHdl9zc
 1nyVDZnt5xa0ELUmZoJKmlQdXwISP0IW6BkWslC3VVmu3sqi7uCnOFRHEDRc79riEVne
 NFzQ+gFjZU0NkPkKkN+5mlZu3k0xx91vfNlBxPR2rgPXbhDiK+kGEKj7WYG79uRe8GAP
 pROCEPkujcAhRuE2/1H5FT7Mh/HDmxAb7A3Ra1U20rsbbZ1J4SK+p3ffhnMozhtVedCf
 3ZaB2FS2iKjtAP7KoBOyMaNPwXx9imfM0BQUE/dg0nfC2aDqGdxCdsR3IkKyNHKc9gO9
 ib3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785265598; x=1785870398;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iD9S0y6xme7NcYdX05DO5xdOPy1BQO7vzVCzGAhv03o=;
 b=B6QBy7z3eT2JIReDgJgJZqUU+fVX+OwbvSCCfirW3zzf3mcwRpGOQbz5YKmByInjy3
 0nJUxZFCJg3qIqIgeUkAT17QuNBK3qGKG5Z2VgB8EMxfC1o+rEDuw1POm7Cx5lpUTC25
 lnsrGLspE99yw71VRgdT96xDZCIZTBF1vF0aCEUp5Go3XPhWjemVs+/jQX+bOFDlZC6+
 v7dMdEbXtRaSNPRnZDi+VSIZbvpEUjXC2JDWq5lbAmXAYsknq9igUAuMr59fbHT+ltti
 5K7sE+3noFPEJVp7cPmrDJnv7Jzb+//qp4WKvW5e1/0qXsXC+xBxPoRlRt6UnvNZJYDz
 djvA==
X-Gm-Message-State: AOJu0YzAQcRrgBGsot3n2ezI+kqOUjKSAaRbcOAjePVC2MHXX4OYTpBX
 GpTkBFK582dIAnyk6MTDY4glIzxi+cS8wSXTdyBc6SnmJrAUF8wesheFwtoEWWxMxdNrXJD0QjW
 xKOJAuIpPQANg6uvVGOLZgzx/uZOo7XNf/2vw97CKQZVjMOvtfoN85gnVKNnRU8J+7G8JpNnBzO
 eN8lZUKQ==
X-Gm-Gg: AR+sD13GINTpARuHumxZCy7j61inH5gMZ1aD+lTYuOSaXK6ZkUkBfAjsjpIw+1ifw88
 7YqgDXIvxz3qkBSC8/hZMGu6J2DQrEP7Qb0ZA5rG64xsx8BvYF5I/b+rT6hs/YiUrQ+CWvK3UEU
 M2TfRNxHFOKq1zRNkNzYV+yxg9Np7HplgAW9Sc1L2dX9pxXmbBXfq94WTzqJVoVGSd2Ge3rZoNr
 hK7YEHgPSwqsOuHlhy/IbxcG0FuIicMxG4qCH2bjuBtbo6ZBwJoECjIrCjLaQdrszN+uozBMAld
 FqkfXUKbXGOHSmrnrU+VaKTuWXgyBN3N561yFSiJe28ol86Tk+tD/LXJqVHE+fhOxogmC9wWbsl
 P3zyhIU4e7/RekMu91Ic5Knp5ggX6gXM8F32eINSiXfWttuVayqC4bQ1VI8B3jyxbtuuqx6D2Bk
 WGPSyijFJbLaqlvWxL2y3/0mEoVO0cmVJHi5wZv+o34Fi1L9TXW6nU2I3ddiNyDRCkPp+ygpcFo
 AOXiN/pMd6vQ8UFnv/4oIKHpcSBNjpLqhOGku6fjoPJ5MSjTke+H9OhvKmp32TGNIKW
X-Received: by 2002:a05:6000:2dc6:b0:474:64bf:8fb6 with SMTP id
 ffacd0b85a97d-47fb1ed61c3mr4193006f8f.39.1785265597607; 
 Tue, 28 Jul 2026 12:06:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3a32sm1398248f8f.2.2026.07.28.12.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:06:37 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 19:06:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: 8633bd5a871a62e457eeb592467f2af21678e7b6
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 19:06:34 +0000
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c1aeb6f8bc15354297f60db3b51fc19bb0d6fe8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1won8W-0001Bq-Cj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Correctly calculate
 packet id size when epoch is in use
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5250872849613154935=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5250872849613154935==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U5LYFdRr4is="; charset=UTF-8

--U5LYFdRr4is=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ordex has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1829?usp=3Demail )

Change subject: Correctly calculate packet id size w=
hen epoch is in use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1: 
I think=
 the commit message is quite misleading=2E From it I understand you are fix=
ing some notation to make the computation more clear=2E
But from the GH rep=
ort I understand this is really fixing the computation (the commit title ag=
rees)=2E

Maybe the commit message is justifying why you are doing things t=
his way, rather than setting packet_id_long_form to true?

Still, I think y=
ou should add a line explaining what we are fixing: i=2Ee=2E the packet ID =
size computation was not considering the epoch case and was falling back to=
 XX bytes, which is smaller than expected, resulting in MTU screw up


File=
 src/openvpn/mtu=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829/comme=
nt/3ac069bb_6ba4a15b?usp=3Demail :
PS1, Line 59:         return sizeof(uint=
64_t);
since we don't have explicit members to call sizeof() on, how about =
a little comment explaining the meaning behind the magic uint64_t?

i=2Ee=
=2E /* 16 bit epoch + 48 bit IV */



-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1829?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Gerrit-Change-Num=
ber: 1829
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 28 Jul 2026 19:06:=
34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--U5LYFdRr4is=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1829?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">I think the commit message is quite m=
isleading=2E From it I understand you are fixing some notation to make the =
computation more clear=2E<br>But from the GH report I understand this is re=
ally fixing the computation (the commit title agrees)=2E</p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe the comm=
it message is justifying why you are doing things this way, rather than set=
ting packet_id_long_form to true?</p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Still, I think you should add a line =
explaining what we are fixing: i=2Ee=2E the packet ID size computation was =
not considering the epoch case and was falling back to XX bytes, which is s=
maller than expected, resulting in MTU screw up</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/mtu=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1829/comment/3ac069bb_6ba4a15b?usp=3Demail">Patch Set #1, Line 5=
9:</a> <code style=3D"font-family:monospace,monospace">        return sizeo=
f(uint64_t);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">since we don&#39;t have explicit members to call si=
zeof() on, how about a little comment explaining the meaning behind the mag=
ic uint64_t?</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">i=2Ee=2E /* 16 bit epoch + 48 bit IV */</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1829?usp=3Demail">change 1829</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1829?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1829 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 19:06:34 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--U5LYFdRr4is=--


--===============5250872849613154935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5250872849613154935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5250872849613154935==--

