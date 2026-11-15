Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27E606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GfxDlEmk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ba1QHnKG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dh4ZiMly;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dCKf8H6O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IBtJyNywhuD+yhkxxeUvwn4FUwE6jBhSb8jk/N+Kfuo=; b=GfxDlEmkAxYCdM05wwxSCgd8/2
	QuTanZvGjyF+yST7XWMMHTrN2EhQ+R9j84cTpmkh8+osoB1IDFFGyZ7uGOxKiPDLnInQKFaW2i9EN
	gv5nw2kB2yf8eyDf5fcqyHCly9luFNTCca+RQ5/8FdTq6V1eJ0wBFfx0xbG+ulI7BlMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSdIQ-000000002ab-34XU;
	Sun, 15 Nov 2026 16:41:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSdIP-000000002aT-1qOu
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z0iAG9PLino5s/4PuJ3OHVABfdGXqT4yTH55RuTbYRM=; b=ba1QHnKG61kYdqonvk3gTRTxm/
 33mehOvcqX5PAW2j1JApVhTAKDfpbaGPyWggq7uvy0Sh1pxUHe7hojMwjjUcnm9l085asRvdpmgkr
 Ei+7m6lDtkBJAoa1RR3OBSJT5Vk2Rq1p+3QXUrwfUVXZY9qF7qmGND/eOkx0EbSyrSRQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z0iAG9PLino5s/4PuJ3OHVABfdGXqT4yTH55RuTbYRM=; b=dh4ZiMlyXxL2aHVJs/1NvmyDpG
 LMRekA1bDL9XZwl+bpkPFgmTD8SygGqs0t3zCU4lqOx1HHfFJFjzoWUxBWEGb10kYJ2JyT0MtJDKk
 wMYdWgg997pnRNflivgGrKDYd+pQhg9EzofY7LWipcGfvHn901Oh+oy8rrx+pnGQUd6A=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSdIO-000000003UJ-3Q51 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:41:37 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so29346345e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794760890; x=1795365690; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z0iAG9PLino5s/4PuJ3OHVABfdGXqT4yTH55RuTbYRM=;
 b=dCKf8H6OkVxPVSdIt+2IOFuJYc0kbORAW9RTw+P5/OvRHLsY9/R76RZ1c/1NsDkFEg
 fkniJb2wFAGYGJnRwHDZwYVX4laMjLNSu8wxurgZ6YEFQNdmCuZs9PAc3ne45wMoBOcA
 4odgSF7GSTN4kP032nm7feeSuEJXvCNL5s7YY4BrRyHTNFPNy3V4CBLGzluTO1mi+yf1
 TJ2MwVoZ7AT1z3dytrD0iesZucOQ3TabNTy+Lq9bp/oLaVL6HQVQdjS0EG/mufvH9T+e
 yLtb/1sGVGjxv8ljlj3YMPwX9c1wHO1S0WgRzCnUJzjjdbMQQE/4Yb0IpEdlWmEfUL8v
 QFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794760890; x=1795365690;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z0iAG9PLino5s/4PuJ3OHVABfdGXqT4yTH55RuTbYRM=;
 b=WANNbAmR9BGzcqJGN+d8S6WQWwgtu85F+NttQfpI6d11lYXMZYS2uocofk/FyQ3XP1
 PTE+URBum45gQ4WQQQ1vDYCSecKqp813wMFLTqqW+JcfcHkwhGXvQvjd0aeFbuZBPH45
 PuYaZPu3z+/mNv33hJGwOptsfu2ZUSMXLMm2ZfK78ISbEmJyCi91t1CneI6d5JopmzyK
 /U34y3WZb4kI53NL3nzGklRg1t4NFRXtsDbhNK/UWVYii/C6K1MnBm/0SkRqT2fGWwl+
 YRCzraR0vk0aK0NfbLPN4HzqElh36XaX3LX7aqhCcYyOkdxLHIHjGeHD7fdt3eEbnV6H
 tdtg==
X-Forwarded-Encrypted: i=1;
 AL+hErEsMafiiafPSwMkOXeQgUgQb/4lr+33eOR/N+NDpFCydnHGNysOfbwzOZIrqb7gNIl0owoGaOLdEv1dtcRV@lists.sourceforge.net
X-Gm-Message-State: APuU4Z937pIj0NiwxfhjwIhNOcZ4ICIhJxXwXWaafWo9TaNSF0XcrUrP
 psgSxIvAYepQNvNu0PRB85xUcx+Wz3NhUlPnh6z9cgn7pgtVOj/ebJB4mWC8qFBw7uC8vmpWyvx
 tOxGuB46IBNYJjky7bw9t8d1hH9suYxyWZLRD2J/FFlz5T4J8wtbTIZCFi9y9u0+/8VbW
X-Gm-Gg: AYBFou3dDgkYbXQOgnzlpsHfLZW8KMCmAaIoUeTWgLW+/TJYybk7GRUQapPW/xM3ah9
 ZD7DU25BLs6U6QxT0D7FuhAfi7V6bi1VnrpQF+FDw8j7QOI5YbIYzC73CzCmnb52LB9uQcpYZJO
 EkIbvgV49g1mHUkm2aYjx1NwtL0VrlE6R7dVVAn8Lge1s8yWxbK5riYzmOdOgX7BP8T12Wf0Aoo
 JEVtrm8R1CsfQyU8StFHnJ9Mho1a3MdmVjxuYoFUrxcxOBy9p0E0NeMsoTNrMm7lqs6p9acBaMw
 x12FxnMolzXOa2XsJQ3wgHkMj/uWKyNVS1TbpTvClkTyu3awl9rMQ85TLePIo/5XeqHyo86bCO4
 pICa9pYygYLy59DA2QYQrRtZduEIf8k2MVCB7NErQKx3+9uDld2s3M7HFND6uhoyY1HneU8d3UF
 ygOHTgQfQpNeslzS/ljpdLJkZmbXgcE1XHU/vv5gzaULTdnA2LNcZaiXJh7E0TX1Wu4tPcXFlk0
 ohUWQOhIeqhn9P1+LS/6c0YrRwxYCFXFfr5LiXsrrXZLwAqy5sXs/m9SdRdL797qPymt91Ba5+B
 c4+9ePbNls1XLuFZOI1TIXJMx23P7IP28t2LFNvOq7aseoHgndi1he4QUQRIbdN8LtIHDXBJuaL
 f03kvYbkGuZDZAgjxRQpyZnyzOQjUzDTinm2a6rk55+STU9X9GmTCmASgIfyASecGH3Gwn1IZGC
 Ob245lIUNnKLFa+GQ=
X-Received: by 2002:a05:600c:4e8c:b0:4bb:60ba:49e0 with SMTP id
 5b1f17b1804b1-4bb60ba4a70mr103203675e9.26.1794760890013; 
 Sun, 15 Nov 2026 08:41:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm238338125e9.11.2026.11.15.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:41:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 16:41:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: a52f1c50b0e6ac0fc9d4b565389aada48da696b5
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 16:41:28 +0000
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d1fbdbd939bf533ad489a1567476951e22f4138-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSdIO-000000003UJ-3Q51
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2827342346916141465=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2827342346916141465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nd/hI4LTi/s="; charset=UTF-8

--nd/hI4LTi/s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Gert Doering=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail )

Change subject=
: DragonFly: bring things back into a working state
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ab959e7101cf801ac93e51=
85855e75db0fb6225
Gerrit-Change-Number: 2170
Gerrit-PatchSet: 3
Gerrit-Owne=
r: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sun, 15=
 Nov 2026 16:41:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--nd/hI4LTi/s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Gert Doering=2E</p><p>Patch set=
 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Cha=
nge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">=
change 2170</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2170 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Sun, 15 Nov 2026 16:41:28 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--nd/hI4LTi/s=--


--===============2827342346916141465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2827342346916141465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2827342346916141465==--

