Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9B606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eDn5htZS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cY8EDgzD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H4jnCH7Z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KLos0Z/C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y3OrCoycJkPz4eTG3z+EAg8xIl2EiIeX4YJvhbsib9s=; b=eDn5htZS3zFaEKdqO7lcmcbEAr
	RwL1pSzT4Q1I/S9uZacxGnrTuULP0Ksr6QbbDLnQbeoXDyfOEoqyR7a8Xo+C7WskhmBEgrmWSN2Ft
	VnE5vnf4Mdla3zuabKOGpvabYbL8fmdNxFwXf3z3ZYEHTMFhDwiibStrsJ2R0RviU6OM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcOE-000000005gT-2hes;
	Wed, 04 Nov 2026 14:55:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcOB-000000005fb-12EQ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=no6f7s9edsuA1zRqHxdFe1z6JqOcwxldvKXkrO4REng=; b=cY8EDgzDBDuM/kEYIkZdRvi4W2
 h+KKvGR4Vjo+RfDOOMTAIMP66PpqVL3Nsjx5fvCswvhQ13mOpMyH2hgAOubbTLDJjC1CpF60N02se
 3KhnwCHUMwp/vrg0JA7JHhZDu95k82/1PzvnDklxrblUjVmds2OFxqTRdSoMsOWYP3YI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=no6f7s9edsuA1zRqHxdFe1z6JqOcwxldvKXkrO4REng=; b=H4jnCH7ZlJkKqfGCkWz3WLh+8J
 5krIyZYrj+NHkeYV3rzyDUsypEPiijiqkSakWJdUwj6E9YiI4v+TzlFe5suhYx3XrPUVZgZmMdSqe
 Ri9wBFbh5wloiVdq7QRK6StbMahbNVIUgRQMoye9CCQUYmcMB78eakItSwGUScOj5JgE=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcO7-000000003kI-2dp5 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:54:57 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso376394f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793804089; x=1794408889; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=no6f7s9edsuA1zRqHxdFe1z6JqOcwxldvKXkrO4REng=;
 b=KLos0Z/CX54yYx40jlueQUSFz4ga4WU192cyTTgPjT+fMau//X+kDadWBzG8eCOA1f
 ljLexWNoVaM9PliLaMsfqGux3q46Xl5Pb/vtgJ6xsJyZMN+PNptkBOx/c3PjWWyUOFqU
 vMQy4eaQ4aaV9Ol+VsKW1m0Rjtld2Pd1+07ck0gKPy0YzgunKuAF98qVt08H26qlidGw
 0Z6bYhi8rGoc5juZBRbHU+i88jFBWNkWwKFkCj+tTAdF2mOmg/RJcPTTFiXSXzubG1Ov
 22Z8T7OcCqYDlym0XDoqQdM5DxCb3cful2UX9Zm4NoiA9SvlLf/wWxCMmBW6JtFlWMVb
 iokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804089; x=1794408889;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=no6f7s9edsuA1zRqHxdFe1z6JqOcwxldvKXkrO4REng=;
 b=o2M0NukEyzNxGQ42yQjZuyCC7fud66d27dXyZmRjFCjZAnkfXay5nOj1Bt/kZzGzQd
 yst3PrB4eN25mx6wkpiGBGLtPsYnHIdBz++RwvBXibEzavKvKHJzKWGE5GcOgX1qXqAZ
 viD8swD5iQrk/a1bWb7TLjsgJhWgeKsrPhsGPegkHNWLvvGXF8yHQcdNTLzco0J+SLjT
 QBP2Q6G+VyqY4EXOF5TTItjwTnCLt4hCDSg+70ucbadGs+yGXr3g8w3XGIZIjtZz/pd5
 pUCEZJ/k7l5djoYucMwtEJIvbJ9ySj1Dq7MaYB5xYsmJOrAvY5HZy+/5iDVe9oaK9SCC
 BTDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5LlPMDBdnwowAeNHo9PP1XOhIviE5/vwaQaM24w4qMCD41K8LhXeURYXGchna1AgwFtoKUR8M3WJ3SeAK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8tf019YPYJSCFTpjy1k9Wb9viRtsk1FTTexadcY8BdzZj8QHD6
 rOFfC50o2hIfb60afrL4WIIBfwGBZIOY39baXb23dYUE+fl1zeEQLTQ723j3xLfYl6snqTJJx8R
 lmtz13K4nOpPjrNRiDMpfF/e/3W42tnFgogE32B07P/RVK+OVJ/+sNuF5Aud/6ArlgnYsKZ/i7T
 cpIEBwcA==
X-Gm-Gg: AYBFou34YDOlkaJb4vWZzBzYVh/s9rTt+BSLXxUbEv4FXDnabaoof19VaSXlhuO4mGg
 QRm457QobZtYv/6ID9HE2T9hhRtIu+q3T/pr8d36xIfxNcZIY1M7g+vVJm8trl2Z5INinb3fztI
 LvbuLPAEP2YAQ/G1jWQPbt1pAHsaFpipFWVnhCtK7XX+L/y0ivY/zSsQaa1eRZc8sgGJL/z4G7/
 Z1pPLkgtvodWu2c2R8EV3BzFHZHI57lfaOHvx3ZLMWd6+fEu3ltcPvfjTU0vbdIe6vLJELUcbX6
 JgAA/lGg13/b9MqfIDVg4IycG0fPGr0QmKSp7Q081kETWB4oJqURTYs0VMl9YjxEwBeKfQeLpUT
 XV6lK8/Xoe/JqwfrU49Aj/HVIgugw+1QY874+xq1s323TRzLFIiaIRboZ61I3/Rm7zjb3VvAj1w
 x012ldOws8fX9zFtuFOp/vgZM5LfTa7k6zXxBLUG2pkV7RsV75LEpY9GBTlucP9Bv/ZAW8qgAaF
 d1bU80v9EtGnain9rjPdtakpxGrRyekG1M2jNadBD/QG2M58RfqKvPMSmQXwK9Y6Gl9zoQAhoS+
 1embYeEegmavyntcjyibIad9Zt+KBJwVCorZxK2L40D74168e/+5ilT6ugZJYzW0nfjFhb1iOPu
 RilhklyXxkG3K9GfVK8Zc58ztumqcs1cnmWR88MdZ48rlgMxWEfJ3glAKisnahAT0tZE2L/ZXwA
 JUXlxTUiyzrmryeQ==
X-Received: by 2002:a05:6000:2213:b0:48c:7f18:c85e with SMTP id
 ffacd0b85a97d-48e6e3042d5mr36094600f8f.45.1793804088813; 
 Wed, 04 Nov 2026 06:54:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed0844e2sm3382075f8f.28.2026.11.04.06.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:54:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:54:47 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 0200c99493db3dbf9e8a7c15c90fbaf7b6e956e5
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 14:54:47 +0000
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <135dcb84de74bc6a6e25e3be2e7d4cb257ef2a43-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcO7-000000003kI-2dp5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0823980787541150611=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0823980787541150611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eNyiPrhDd0c="; charset=UTF-8

--eNyiPrhDd0c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipako=
v=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail )

Chang=
e subject: init: Extract init_tls_wrap_ctx() control-channel wrap helper
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32=
: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1749?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
d8546da9ef06c2226ea77e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit-P=
atchSet: 32
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <=
ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev S=
tipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 14:54:47 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--eNyiPrhDd0c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>R=C4=
=83zvan Cojocaru has posted comments on this change by Lev Stipakov=2E</p><=
p>Patch set 32:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Dema=
il">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?u=
sp=3Demail">change 1749</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1749?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1749 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 14:=
54:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--eNyiPrhDd0c=--


--===============0823980787541150611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0823980787541150611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0823980787541150611==--

