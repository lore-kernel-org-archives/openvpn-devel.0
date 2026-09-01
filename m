Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A129C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hF8rGTwh7oNd3rV37wr10a0vVZlWA5ySnTzkjs4SJGE=; b=dEG8ej0kYcns/7z8Uar1hcllm3
	23qgBXoiYykz1d4Jx25nKIO5c47yJSyj6Kl6LzE8jLFI36MTTRA/pFPnuq1KUeMHSLVziyHrRfuT8
	H57YCweI29MG9yuOgLsDozQBTchbkWLLCyH5xHdl5rzREylVwEvKlg7J1zNw/9SRf8Hc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1J7h-000841-28;
	Tue, 01 Sep 2026 07:41:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1J7f-00083t-NY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:41:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8F5CDW9oQYz0AEYbnjZQjhmEp9hjhZEqZ6deMqo9Gh8=; b=icfeNzXiW2E/BYqESeozvF6c4V
 R2dJyjucL/q0Hq9U6v4UmE9PWnoHHEoG0MVfYMYlWuRG45BSOo6nj1+kEzHxTKH+7BQ4PiJx0JOrA
 4qOvsgeyo2vb1k4AKa9TCxV7LD1qxSLX2oC9yhc3vgiEK0yKXpx8ZLaAcfrx7KzE5nM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8F5CDW9oQYz0AEYbnjZQjhmEp9hjhZEqZ6deMqo9Gh8=; b=P
 zHfyu9eFiyQmKDe3v7V11shH/JRk+hkrG5Q9TRR5/b/9VXXoUsehJ0H9OTUetQGgM47Q+hDSmy3bb
 v8th8KoI1VH+eZuK9mxLa6ve7x4AwxWMihkR0AfruvbUNbf8rbFmG8cih8UejDwtsyyfopCC2MBrT
 zA8KRtsa85xaIdBg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1J7f-0006wQ-Ud for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:41:36 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso50769195e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788248489; x=1788853289; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8F5CDW9oQYz0AEYbnjZQjhmEp9hjhZEqZ6deMqo9Gh8=;
 b=IdNkKErMbk4Cr5N0l16VzcL7K0DJoZ9AgN/ylqiRD84evKLFdXOuMpyEqaKP6J+6uB
 E31F5E1qQB9WVALyI7DOxouUufbeFThmtbhQQN0sX7S0iauDONpYGIFFBuSUvup2gMF2
 tzQG02RTZYwgXcg/XK/U9TL0zAyGU4dx8/lUC1pUvZHd/VB9ZqSSOni3ahJJ0cT1O9Qt
 NcOyzCqjRIGoJU1YosxQmgZ0im/xJcJhBnJsw6wIFTp7jq8Zp+2jZHKRDzzvPAtilppk
 J+vw3rXz2rNq3ZbBf/wsALzf2PjppTGoK4PWIsiduLcabfW0K9ptw4CDqxOVhZsygcr6
 S6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788248489; x=1788853289;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8F5CDW9oQYz0AEYbnjZQjhmEp9hjhZEqZ6deMqo9Gh8=;
 b=Jt1/61Acys1Jkof4VerB6McUsJ+2gG/UOgHn2L7I1PA71Zj6xanBSCYPXGcPX02fEB
 YK5e3uLLdmtmAjBzAwo80Q+BhtiAJrWtjBrnOFMvNAyYMnfpum0khcmQqe9rl7f+a84B
 m3+KXCvnSTpWA0WfdcXDmNkFA/qTS5/5Xwp/2CoQievEbdmqOpJQaO6ECatLt66x8NS6
 HTnRwW0kUIsaiT9zRJWPj+yDDgjjLFl2kuFqNAYsJugRCNkV1/zVPkhPm/Dh0zW6FSAE
 9L3LeVv7e9E6/S6ryWUtXH9R3HLYVw23KeFVK15eoSWVDdmSFtV3StrNBbSM1KE4CWkl
 Us5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvJSY+6c13DQD+fenknJRUu3azwzzrQxMb510KaE9a4lxeXNXzp6lz6GWFpxAeVpFqy71FhRe6+pNDkY6s@lists.sourceforge.net
X-Gm-Message-State: AFuF++l37QN5/LfQWBqpyk3VWVpi+w5ieMHySkHtCxNHbnBKRMG0L8pN
 Zg273c0xOmNFvuPQD8Wodt9fFHD1x0AmyEOTndAI1tRroXIUd/pHP3Qgejw05hZ1zPkp7CIlq8t
 xdbJeQL93BvSAW7DamCKFz6Va94DggFkbX5kmxHKizQp34NHd4zASjbsj4iSTwKla6PW6PVnvVD
 BQaQ4LwA==
X-Gm-Gg: AR+sD13jmQvHjuR4BBe2NG3IGCULVuhPoqrou59g5Zaj7xjAPFBSnE4tQVawCCdNtrQ
 48u5qOdCPifiMfVrfelRwbDcBmy1dcsqbxuoZhNB30OuG8oTD5iQJuy3CYIcconLM8KP8naVDd7
 9us1EUh78Tr5oe/wnQ+D3evRCNESUKKF4gLZmidzpMXYlx8N8ENcRhg6HkaPZ7kiYh4NtfdWHht
 gosxNxq6ZKcK2cI/VxjpGQF9cAAHBGGg0a2PDkXq75/k9bHgRlhGNPEE3Cw8G5ZImuHuiTdW8bS
 tdXBEimtQooWnVV/mhil4j8DTO4hScfTW/rrKQig+GLzoBl8d02avievttqprHebLvwtABoMj8S
 EehTqdOZTZiUs3FiJanpZHzI0US3xO350WyJPCcuudSNclKlOkmnSAeil4fMqnPKFZYlN7ydwLi
 AZyUaAP18ZyJQYdWjZH0jlHBva3yFOHEFG6aXrrxegEYv75XNPmiOMAR6e4PMXASGw0lCvlt3s7
 UIQzHx/f49EmxvgpSst63SGDd+ghedRlT3r0sbUor+0Wb+sd82wFNpCvGywXl1+694oQGckXViY
 6hKl1/12T7gCjbtS7SSg1TOxtYR1tifHYDo0A924+NIiyWuq2APyw+ZMBU+Qxw==
X-Received: by 2002:a05:600c:1d11:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49b91c25414mr451277535e9.7.1788248489303; 
 Tue, 01 Sep 2026 00:41:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce164bcsm46137015e9.7.2026.09.01.00.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:41:28 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 07:41:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 40ad1633b9b336e8cb4bec0d533ee6065e22e6f2
X-Gerrit-Comment-Date: Tue, 1 Sep 2026 07:41:27 +0000
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <814f45d364552f44811ff37d5c6fb76134639c3d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1J7f-0006wQ-Ud
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 validate netlink replies against the request
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6756596837918534412=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6756596837918534412==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9XAZEVNi04w="; charset=UTF-8

--9XAZEVNi04w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1782?usp=3Demail )

Change subject: networking_sitnl: validate ne=
tlink replies against the request
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
Ge=
rrit-Change-Number: 1782
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerri=
t-Comment-Date: Tue, 01 Sep 2026 07:41:27 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--9XAZEVNi04w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">change 1782</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7352dd1=
36cccda2bd6b6e1a36db1a5f27afd8f7 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1782 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Tue, 01 Sep 2026 07:41:27 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9XAZEVNi04w=--


--===============6756596837918534412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6756596837918534412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6756596837918534412==--

