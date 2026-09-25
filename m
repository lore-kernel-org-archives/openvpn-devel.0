Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0686C98306
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N5BFDQk9BDf2bjsvcvmRGTNKzEMgM3YHChtYJwEcJys=; b=ez+DMpqMKhhsrEboUi6wparYHl
	rBLQW1TMbX7xpAD5rkRMsNiQf3QvSTA6j/RJkn+pAph7drzLEuDqT4A+U7MpjCamOnDGJM2c5Z9G1
	vs0EikZgPR9Saby5Jr4n87qObUIPqBbBuqziTgffiYNoGkXE65/cOdxeSbyWcHcPKECI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9xIH-0006KX-Bk;
	Fri, 25 Sep 2026 04:12:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9xI0-0006Ir-0E
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 04:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NvBPlXFtP+dSwbSLF7PdPiv1wcWv5k8uNTSKCRdF72o=; b=BVBp9YJgv3qDR96+JGNHKLj+Kt
 b/tZ4EkfhQ5+BogBuBNvHipkjgTynNG6o46SerF/5SpT7Tga4IlpcxG8gtSPqb5MjXha6hfR4uMQA
 miDXW0KBWOlM/xONkQ3AVTfMGRku8SyrhZMvEoN+z266eU008K+SM7ywFxBbP7nSTPN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NvBPlXFtP+dSwbSLF7PdPiv1wcWv5k8uNTSKCRdF72o=; b=O
 xky97DjNkSwJKzJK3ygMGcyT2lj2mdwxJzeJceD7ur1h3d5g9vZQD5DsNCk/Pxi71QZOw19iixRJH
 ZCy8mDzOQPbh+RB7NUg7MCiJflGew2Zm9K1fp2sOdXVnZs0Lo6VtKqoXyf3Q6FeS2yX7Uj3hM8YaD
 uFJDJg5WUUctuScc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9xHu-0002Uz-JC for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 04:11:55 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so3367475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790309508; x=1790914308; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NvBPlXFtP+dSwbSLF7PdPiv1wcWv5k8uNTSKCRdF72o=;
 b=f7pm1twwYB8GB4/lTAL62VLnKY4UvHWVu0ioFxNFGzrzFqtse4LyNRu7Q8Q9pJb2xc
 rQ6ZE90cC6xjizILYHBTVukVd3K/584rGU/HTYe85IIpsK8uAeiIcWVjSuOKg3Zrdnkm
 nxctbAs9GYYiN3iBEjgc7AXC3/hrBR6yo8RkV+96TWhKtxd/DIYkKK+yNgqoYiJLnTW3
 2laXno7lJVhswRCMznjt4R9Z4yPRodAP/qbewU2c8TqdD4SgJI1sEG2CS7w6fWEVOchB
 zlR0jTySNYPQ3pxtLZD8M1X7EUXvITrenqgE0Kwoch8f2TipiGJGwE8Hwo83nfVo6wuy
 Rh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790309508; x=1790914308;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NvBPlXFtP+dSwbSLF7PdPiv1wcWv5k8uNTSKCRdF72o=;
 b=g5f0W9gwC0VA+2r2Bl4MZ+P8UttnVJSiYM7FTDsEy5mREuU7Cqy/Nv+N+eqWEi3r1e
 PFqjSHal1ww5IjXMH8pwF+jSNkxRn+bKdSCYiRvi/rADI3NlO6X/5S7OKaFZLSPfGls9
 tqZ/LmSmKDY1o2tbxi4I2s/AEKDRPSyRjkjLJm4V35DJ2Kvl++HkT6CFxTAL3IaIw5LH
 1Es0UoTJN08cCqtdB69DooOX56fXoS7IUzG9byehrwEtsUbq0DFNY2i7uvFFYLAUFurf
 V4ApC0/jEhZGgamht34e64hMWRVtg//WY3fMzsja95ObH0H4yWucoyEzBa64yI+spqeW
 SiJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiZA7mU6WG2uPAsZGd5Zd7YUT01RkbnBPo4BeHdrwR8tcstNwliepilrCClb5Wzr0A1PcViKirXEEAPhFZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++mrM4vsfX34r0WHc0Ihxx7yYDKbKBGSW3UGqXwOvv0iN4KggROX
 6b3U39bPPqUwMRpeRq98O+qc1Dy89MH3YBOcygpDfHcT0vJxiTKr4ulc4wbqXA/VxYZ4RZxw/pm
 CJ9jWzViPw+f1iW2yUXmUfWrUEhCC330ancllruHbgeel6mQdM/BDxwzl9Wd8SMr0kgfR
X-Gm-Gg: AYBFou2+EhK3eULb5FGkWJvUxu7sGxtMipB7oFgi/WUQxaJlWJcNCuZ+g3GZYE88rSa
 ilvYOwJByEsdwfrp7feuNm0gi+FQDUn0LTbVOKWnyCxUhRNvSgUlMnqIJFccOd2XVsM5p0MJV8A
 Z2XpncoYUz5lb6V1jEBS09Zy+8eYWFaRTRzNtGiiKOnZTgshs4e/oZr9LUqBGMMYOLrZyU6lIyt
 SHDAwIqvDpzuKuViFOfhi0EbMKW1D+XMA5W3AJJSv9KY3RZBE6HPuMzcr6g54lWO7NUmPNDeFwX
 NfXHaE2wPPA/RNMDVmWpCVYMAaphCq8ZtI9ZUsWwaf+VskMigePF7DKaL/RFfpRS82DG0ZvVJKO
 YnlHoEkuyVyhowmPE8BZgCzo22hm4F6fCo6XCJ244UB5UMmPnLD56Qsq85n0HdrE6wHkuTcjBll
 6HcD7YW2aj9+kMBnelm/qD3DiJ88xUQK9iCtc3YsBcH3S90fYYl0LBSPPuiILAYrxJjpHn3TGFx
 p6t00o3RA5MSuN/Qu0uQojwXdJ+6ogjCbWI6f200vsWCVF2cm0HwmUb81DxSh2ty8m/w3kfdOx5
 N50qPIjcH6+R2kl4NUSGkJrbTMNWVQn5Rd+/ZHq1jkYRk8+gfmmU8zW7QCNX7z0DLTYXJac=
X-Received: by 2002:a05:600c:540e:b0:49f:cbf1:e77b with SMTP id
 5b1f17b1804b1-49fe66ca828mr75740295e9.10.1790309507851; 
 Thu, 24 Sep 2026 21:11:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06cbdfasm25588805e9.14.2026.09.24.21.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 21:11:47 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 04:11:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
X-Gerrit-Change-Number: 1737
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1737?usp=email>
X-Gerrit-Commit: faaea4c811c3bc93b2121a96b2a4aef893259467
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 04:11:45 +0000
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLklhNzg5NGZjMzYwYjEyYzVhMGY2M2ZhZDJhYmI5YmJiMWFkOWMyYmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b46d93e32f54939cb4ce2b7313c159dc0f9a4db-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9xHu-0002Uz-JC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: read
 multicast notifications on a dedicated netlink socket
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8609694899108796826=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8609694899108796826==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7t3/pd8lKaU="; charset=UTF-8

--7t3/pd8lKaU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

razvanc has post=
ed comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1737?usp=3Demail )

Change subject: dco_linux: read multicast notif=
ications on a dedicated netlink socket
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

File sr=
c/openvpn/dco_linux=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/co=
mment/d37135b9_fe6c8fd5?usp=3Demail :
PS1, Line 1228:         return 0;
> i=
f I understand the your point, you're saying that with this patch we don't =
bail out, but rather pro [=E2=80=A6]
Yes, thanks! It looked like a potentia=
l flood of state dumping on a mass disconnect=2E If that's intended (and sl=
ated for optimization) then no problem here=2E



-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
Gerri=
t-Change-Number: 1737
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <antonio@mandelbi=
t=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Co=
mment-Date: Fri, 25 Sep 2026 04:11:45 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: Yes
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom>
Commen=
t-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--7t3/pd8lKaU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>razvanc has posted commen=
ts on this change by ordex=2E</p><p>Patch set 1:<span style=3D"border-radiu=
s: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-color=
: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1737?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737/co=
mment/d37135b9_fe6c8fd5?usp=3Demail">Patch Set #1, Line 1228:</a> <code sty=
le=3D"font-family:monospace,monospace">        return 0;</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">if I understand the your point, you&#39;re saying that with this patch =
we don&#39;t bail out, but rather pro [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, th=
anks! It looked like a potential flood of state dumping on a mass disconnec=
t=2E If that&#39;s intended (and slated for optimization) then no problem h=
ere=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1737?usp=3Demail">change 1737</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1737?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7894fc360b12c5a0f63f=
ad2abb9bbb1ad9c2bd5 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1737 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Fri, 25 Sep 2026 04:11:45 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</bo=
dy></html>
--7t3/pd8lKaU=--


--===============8609694899108796826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8609694899108796826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8609694899108796826==--

