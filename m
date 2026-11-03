Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD2606A82E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jArC5Mv8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NyFak591;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aZ66U9Ay;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LGR+4+R7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yU5nVVKT+dXQlLDBczL6tVMat8ihinIQkqNlqZPMaYU=; b=jArC5Mv8bDHiG9QRlc9SJVFALD
	2mFvVDCbu5LB1Uf/mzuNUlWwgFfyG6nnXc3oDcWTo1Lufy/CPW3ndvj7xk1fbM5Iq9Y2syjNjmB5D
	RHO7Oj9LZsfFJp3wEIQ2+4coU2CsaoN2gBZsbpJaFoJ0Ndz7aB22sgE+SO0PUxeWhTFw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBhb-000000001LN-0nXw;
	Tue, 03 Nov 2026 10:25:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBhN-000000001KF-1vBh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:25:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rTKtZizOPcOoRZcXkM76V2z0SCDaipBKa4K4vHqc6kE=; b=NyFak591JQDv1YdMiuzbZTxt6q
 FSD1ajd6ABCodqEnocej5h/nE5ixZJ33NENLN8sJIkLM7ahnmeo6G+mn63Vd7CTLaUD6cxHSLW+Qi
 FTYSha8DYnSYfpGmaBWj9ouFC1GDtu2x/dAy6oKki7LhJ3flW0BbyGXig2pYk7CZCato=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rTKtZizOPcOoRZcXkM76V2z0SCDaipBKa4K4vHqc6kE=; b=aZ66U9AyK7eDhfcRcyYddqbESQ
 aKMlYgy+2GYf1DoySt5+4t9CeTNOQw1a9CucAcZ7k7GEqVWbWIljpu7gfDtebnFTUdI4CHuOYRWPq
 iXfz7VcIsPk5I2UW5xnEDw58Yw8+ikZsg0A5cIq8XTDQugfvkodY5qa7gj5+X7aW9wsA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBhL-000000000lo-2xCI for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:25:01 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so31997215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793701493; x=1794306293; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rTKtZizOPcOoRZcXkM76V2z0SCDaipBKa4K4vHqc6kE=;
 b=LGR+4+R76ajrnGMMHcun6TDzexaK1DN2UDHsuM3Ow8NDhKvslHAxpVucpQ8e3CbTt9
 4i4vuZs9aF3GBDhhGc5AvScLkAJ/e4HouENKjFbtPg86CR0Bva+Tilx51nkHOXdOSy0q
 OkKunCPIxYNj8Im1vHvrrlwSRtPl8AWKwC4lLu1xRi2rWboy6ZM9VXDPE06TlXtaS+eP
 BZHC37jXWY/GK1hXqp3dILNMBvsbrjTIDEzVcwG3KOAKqF8YmAsrV59OQkdzT/mzEle+
 hIXlDdBITQqdFsnYrjkDBWjWAqvd/jwP4xGi8gRAqLpOBIbcTNEdJdouLQA7QFzFQIMa
 Zr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793701493; x=1794306293;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rTKtZizOPcOoRZcXkM76V2z0SCDaipBKa4K4vHqc6kE=;
 b=c8EDTMdwIUZZlagyomGfMv7JcOEl6Vwu45F8UUouTo07PlW6w/v3xwVfptaY6IJGAA
 KqwbnGcT8blxNmArb53G+d8CfQhK/F1kY0qFs2w9MwT/3uUlA0Y4L0id0O6qnrAbQ6Fz
 TD+qsiOtF8MVzPFAsO8ZSlOoPk6vT6dz6VaUgC7LU4rYvCDs1ROxv3/bUHlX4ziwb6P0
 I4jDmyRF6zuCfqVz23n1xtYio06VAQhl9KgR2mexkZHS7M+SlSw/f/S/tz9bPNYYCC3b
 ebpKDEnsVI9hS+szmJD6uXDSXMYPjB17Ht1iollQSLXYaSlcQJFaqL4NrnL7xoF0Amlo
 f7Sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/jvJC24s9Q1ZRcz6wZE7+XG4WuHKHPk/GUKwJqCHnOHzHOqxdm0jPNbpCHVJth8RZXnul9bdlEMsdUaK5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/OWP2RPBQd4JhXR7Qv8RyExMc2Msf8pCQCmdYd1uvqWE2PUfxs
 xLy1zZiu4kGwQ30dO8IrodCA7XCReKgJpIgs/iRNvcCIJxo5IpDWz6TJG2hX/LHqnlKygY6pt1z
 nawI9snctFmNIidJsvmIdMmEBoa+nXXetORbwUXTBb35urdjC76aJgngVRexW6j8CCKa5
X-Gm-Gg: AYBFou3BzYAKmQ5ZqS+MfsjZKOMDlbHK3d1h70DNxEe2dOzN9aWB8TN/aEkgryt9bqs
 q/bV14UHamdVVU0Gj7oV+oostTgweJ/8KQsZkVUZXkgqvQN9pNY7d+UzKbPfq311e3QASZvcbpy
 vKZ3Opiem6mt2QHWWxU9EkAB/WXhR1akpMA/orjdAbOUjTOiIBywMynGgQTksiwgsh4kx+CxVsp
 MIJRnLrU9txoymGJhpysVr7IYHGKkYELMe1ZGmshromHbq5sHa/sxyqxAFTKaInUaVgCWsJQIqO
 tRfaojujnJwcqbZfC7yFkZUCQtfhj1+qNqTubTFb3CRbg0cySEJEzU/TanhOPrO0aWb2Hmesyql
 At+lq97ave7v8pUwpfnumxoBAAsHe3i8I9S9/ZjMG7UHXsS6aoM+S8bmB5Zg1JiHHaQnWrYlfCf
 eNkhaEnBmXi744vt/wLw1zDxsXUR3iVQ/X1NxF0Zj7N0IQGD3LTtkaKFb4Wv1GOc2wVZqeeO1KE
 R/07K5sHtCprbFPwrvF9GqHkt/Cu505DaaPIzyN+emDLCsra6SSLcNPvB5+/HbzvTQ4sC06LLgg
 Sk/6KMl4+ulaya9fQpH5GRJh9ram1wHDerQ5h9cofrK9sxd8jporupKHaZi9jMnKux1GpjyzfSl
 bFhddu6oxblZIEw8c3/ckdXLTtDnWnjLsEWoZ+4dVJH6RmP4iS7hRGJy39mfE0zM8XRZcWU3pg5
 3GGODscP6Trw2WMw==
X-Received: by 2002:a05:600c:4ece:b0:4a3:5a42:b2a4 with SMTP id
 5b1f17b1804b1-4ac185bca52mr282083215e9.12.1793701492958; 
 Tue, 03 Nov 2026 02:24:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm46069395e9.9.2026.11.03.02.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:24:52 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:24:51 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: be5e142bdaa1060f0fe42dc8f882a913d8a4e378
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:24:51 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <11037f3b60a4218db79806592e3d46359eee962b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBhL-000000000lo-2xCI
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3505240618765041954=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3505240618765041954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jfn1kPdVLGw="; charset=UTF-8

--Jfn1kPdVLGw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review+2

(1 comment)

File src/openvpn/multi_io=2Ec:

ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/9842c1f3_cb498120?usp=
=3Demail :
PS2, Line 689:         while (!IS_SIG(&m->top) && (mi =3D multi_=
get_queue(m->mbuf)) !=3D NULL)
> Well in the final series it can't: m->pend=
ing is gone, so the [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Gerrit-Chan=
ge-Number: 2046
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gian=
marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco =
De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 202=
6 10:24:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-=
Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To:=
 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--Jfn1kPdVLGw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=
=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mul=
ti_io=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/9842c1f3_cb498120?usp=
=3Demail">Patch Set #2, Line 689:</a> <code style=3D"font-family:monospace,=
monospace">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D multi_=
get_queue(m-&gt;mbuf)) !=3D NULL)</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Well in the final s=
eries it can&#39;t: m-&gt;pending is gone, so the [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail">change 2046</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101=
cb2e828be3b7fd8f44156 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Tue, 03 Nov 2026 10:24:51 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Com=
ment-In-Reply-To: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </=
div>

</body></html>
--Jfn1kPdVLGw=--


--===============3505240618765041954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3505240618765041954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3505240618765041954==--

