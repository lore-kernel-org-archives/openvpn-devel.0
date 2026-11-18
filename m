Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586F606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SgpXS+E7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YXcvNhTN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dRo7e1rj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U6eQ1HZK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JNPlh9XAER+rLb1dDawReU7d3FvjjfB2tMai1zLkfZg=; b=SgpXS+E7JGxgUgLKq+wZbYyaec
	Wh6lkIIslnY0UdYFG4FqcFwDk075k07PKDBUj2rDIRQAViprIuqFA0Gb1rYGCxl9IA8HYx3pJ87Vx
	NDZgq5ACX+sSU7GvionWqdWUWPfiUJEUn9i3+n/POtvXopizv9HTktj+UiTaFITyMOFs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTkKZ-000000001is-2uxY;
	Wed, 18 Nov 2026 18:24:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTkKY-000000001im-3dd8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:24:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dTd4M/JJDJS1c+6ODiz78adg5T96N3k7tWCAFMNmJfM=; b=YXcvNhTNpsF6xymqOyiROmxzCz
 EVfryHFr0BGVnYSZOy9+6rWbZgABYS9hzDk2WfZWv8Irw61mtKieu/YZMTS9pEbAKwpXukgs7C5jn
 BNM6B54EuSUwNGYKq6+NMIihoHTM+ZWDh8vlZa1IjUgGD5IoPvCFwV4psudfw/QRluoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dTd4M/JJDJS1c+6ODiz78adg5T96N3k7tWCAFMNmJfM=; b=dRo7e1rje3YEy59ZAy1GaGTYzD
 4lSVCqfrXm6ti57D/hL+QBIkw6b7hXpewklZEkdWHwqYxWtqouSrpFt3WZMeoDOLCBiNOKM0d8fCj
 zLEOiCiOdx581IAEYIKzlp/I0c/s/vRTydpOZTKQKIvwwujry8VCOvllTEzGdcVPphkc=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTkKX-000000000CP-3UYQ for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:24:26 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso1152767f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795026259; x=1795631059; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dTd4M/JJDJS1c+6ODiz78adg5T96N3k7tWCAFMNmJfM=;
 b=U6eQ1HZKauMnXuYmMtI4JL9TtquJeciWDki8Pke7dEEBeKvZKY4jIFKf9L9bHP52XE
 cSG6s438Q5tJryBx2777/6Ec0T6X/roLAjUNPUK9dN0rLa8wf/wmSsIiFy1ZI90ZbpZ3
 f3BCILimajQpe1gxOJscYfsCnDxqcFS2Nw7e5znYcSI7ndpQf7rxh5cR2T2yk9tXtQ9w
 D/L2IbQsTJR+t+EKIZj5/ggTE+t//93D71dLBjZ/mbFMsU0zHJFyftVQIhppwgKfr25O
 Iy2W+HAWo3F/lx70EcFDceVpoYWs8CMyJdCmWJZXjR1fjyP4J9V5jJpfOJ+1GxibGnnX
 z3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795026259; x=1795631059;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dTd4M/JJDJS1c+6ODiz78adg5T96N3k7tWCAFMNmJfM=;
 b=cl5JNVNffD+BkUcNIGy3lDeTu5lzceSYPsp2bMmMdXpGWbRCUuCQK2I/oWReSk5+F8
 RgzJ1dlz8joJynFEwpbW9gMbwBxYUyzr0OAXlsZ+e9j3jqi6vIG4L6DGodqwDpavKAdk
 RD0HTzWejgLAOtzJ534xRR8v7b8TTEqxRhUX9nqeJlrk59b02s96CxBDxALVxQYsj/gc
 XCmd3RCIk7jSQ2Yd/QJkffFIhXi/JneNYwpfI4Fj92KvImAs+SEYSBq9/MBhwwGIarbn
 Bq8D1pR5o9MVuJWpDz0j+4FOQ42e/HU9k+zgeAHhjymDgGJ8h/3cn9OAXbHY8r6G3E0y
 1CZg==
X-Forwarded-Encrypted: i=1;
 AL+hErGYtFdueH6Pww1213V5KC1cainJCCMgNKKyn3TSnPu3/7nXBNLwx9QXbQDGCqxQtdKETnjvd0ypeq48s4xG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MkGWmoVNc+naK1biUzbNDf543/PjQtamWHLlJS7OfE9PTj4cz
 n+oSjVbN72O4bf/yvLHyn1RygeWScNplsdlM5arn1Y8eWdnbhr6sXF0ZWl9GVHKIS7wT9yBqkWd
 NN8zfHiwtlXanevx0I3iA27N/skzU7dZ7A3KBau+dymW1CrmNH8LrgaTklloSrWcMElmWXxgqh+
 WgpG3lEg==
X-Gm-Gg: AYBFou36sAvNL/GCGtMNWs5+AXsPbF6APrenXJ4Nr2c3h5yBfUpqkj9KjOnwBVp8BpT
 kOsOWtHajhsfn41qrkQ5IrU79sscu+Tomym2eHst6nuRcXnsohJ9cnde4BbgxkPAsTPZ0Elc6PS
 zq//oUPoCBOf/vry7tMXGrWRlYWmxUrsmNPe020scyoF1O3ZT4Bo+84GXDG94vwnAN9ca1Xobis
 vFAwhk4LJFXLQ3VXXdqr8vFLyZI6hkSCnUOM/V+TNSMST90Op7Xp/850c+8fL2gSiOvto4GkIl3
 9PXJ1tNa/6eiGyXm7m2zmJRUCSfz+6yMeoKGvoOkk8p9xL2rBS55fm2giwyZBhrSkmd/rYt22A/
 xYRI1vwD2tLbWDjzOrCcgveZjkDPPVVRy2bW05oFA23KWM16UWvs0zYieNl5OXhvF813FDjCi24
 xN+eIL6dnzkej3htTKM7/kedi8qwD+JMtu3yz6FIG9AuijtIzBx5TstuQLMOdRxYwYYkmSN1IIS
 LYzclbJ6zDCYFxXZs9PxDsucNdsUPaCSIQkh8vzwvFL9ThtlpPLhktSa8BAcWo6ze90SClnHo5N
 N9PMYPc6JW2pWiFw+kjOGA/A/CHl/951+g1y+r/w8T02/t7OMlLrPCxnRz4nRdH+0eh/rFx39Zi
 GdrYvnGfusIHtmtJ0YywsQcYDzoWLoNxbnIejPRbRGgKXJILoCzVLVi9tROiCqpwghg3N4tqGqf
 OlNzkzKRU7BVAIwSq+
X-Received: by 2002:a05:600c:a54:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4bb7da3e3e0mr66285875e9.18.1795026259028; 
 Wed, 18 Nov 2026 10:24:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e57664esm39385865e9.1.2026.11.18.10.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 10:24:18 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 18:24:16 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 0200c99493db3dbf9e8a7c15c90fbaf7b6e956e5
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 18:24:16 +0000
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff7099a078e57b172e8c320fe674e22bc91053fd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTkKX-000000000CP-3UYQ
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8743298157618458024=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8743298157618458024==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QitHdn6zIVk="; charset=UTF-8

--QitHdn6zIVk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
=2E

Gert Doering has posted comments on this change by Lev Stipakov=2E ( h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail )

Change subjec=
t: init: Extract init_tls_wrap_ctx() control-channel wrap helper
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32: Code-Re=
view-1

(1 comment)

Patchset:

PS32: 
This needs to be rebased, alas, as `=
pid_persist` is gone=2E  I can fix the "it does not apply nicely" conflict,=
 but I can not change the new code=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Gerrit-Chan=
ge-Number: 1749
Gerrit-PatchSet: 32
Gerrit-Owner: Lev Stipakov <lstipakov@g=
mail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Ralf L=
ici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention=
: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 18 Nov 2026 18:24:16 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--QitHdn6zIVk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=2E </p>
<p>Gert=
 Doering has posted comments on this change by Lev Stipakov=2E</p><p>Patch =
set 32:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1749?tab=3Dcomments&amp;usp=3Demail">Patch Set #32:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This ne=
eds to be rebased, alas, as `pid_persist` is gone=2E  I can fix the &quot;i=
t does not apply nicely&quot; conflict, but I can not change the new code=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06c2226ea7=
7e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 18:24:16 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--QitHdn6zIVk=--


--===============8743298157618458024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8743298157618458024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8743298157618458024==--

