Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A408606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nEBPHK9x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fGDaDNvm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jzzjhewS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dR4Zd7IL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T26EniTe5mho1CqI+tXwl1TdExFDphaZgq0cFOhhs+A=; b=nEBPHK9xIG9uLcjOfG8vgHoTME
	v5lPQ8zE47fUeiJMoVThMbMkHDphQUnVKmtWdO67T15j3sZbh5kKPO0IM0ZuuY/eHLq5/PiadV0YT
	aYIqQja4H/BLaP8yFz03SfaxUlfg+enhA5l37PcEKvT8DNEUWSWJcZJpJh5fn2dt3LNo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFxb-000000002tr-302D;
	Sat, 14 Nov 2026 15:46:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSFxa-000000002tl-17e4
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8T9YIc0ohSNTy49Ns+cY8zzokKYuzsRnf7J9mnuSi+Y=; b=fGDaDNvmNzOt9vHCY2sa86wrLk
 qqpwXnmp71ySidDBKRQqgDiZktszvl6BUJMTb1DoNyQtR/4pSzJyoEMr14YfOy2ge+i1Ofl9IrXle
 Did4Gu5Z0z4hDcZpQWFH0BYSjONoiesVXHom2oJpxQDXVLy0Nxed/sXj4eDY4va8PkVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8T9YIc0ohSNTy49Ns+cY8zzokKYuzsRnf7J9mnuSi+Y=; b=jzzjhewSD4M6NvzBwzaDUdJSS2
 6AQ6vK8gmQ8L8KS/1YCN4A1MilTyCyxdg3cJuYF05feJxKS90nJ8QwpmWJIIqK8jAyBbb7Tqww/tw
 1k6hgbDPwibcoSUQ4DG4c/+aikt8JqYgZ1eexctl3hk8Y15gOOIxRVWaBktmWs4VtQqk=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSFxY-000000000V2-2nge for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:46:34 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso10981445e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 07:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794671186; x=1795275986; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8T9YIc0ohSNTy49Ns+cY8zzokKYuzsRnf7J9mnuSi+Y=;
 b=dR4Zd7ILr/WJqH+NT2n+TKjL5e7e0+wXgUKBEB42jrPn5JiputW88G4gVAuhRoo+XU
 187+w8X0hlc+oCaRRRv8aZ/HquUTCwPC7wKwbw6hidYfKxD94xwWdrTBEekB/G1zBZ2w
 r4RPz/aLXpqG06+i+5erbeU7bObi5FGH8bJd66+LVdRTglTylnuDnq/XMqgX5RUnZt5t
 Y4tF0aN2uLUG8pAB4lNjtvPqcJGiYdElrNaiKJR96pfATMQQCgquQH8JdZCkpnS11M3J
 e6W1O+pYLZcxxKyH2xjmdQSiaAuwgPjHUcNBpSNnADyTtCX7fU16K/QZnYshPj+IxSTO
 HANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794671186; x=1795275986;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8T9YIc0ohSNTy49Ns+cY8zzokKYuzsRnf7J9mnuSi+Y=;
 b=Td1207sRfl+Z9ZZ5b+9qS+09jMSWp1xA/98jAKjIJEemCGX94TULr6aeQB1ik7dVBc
 eeVRywA0AeyibD3L46hP6eU4bYzm5MgKxwoigfaQ0Y7lXZ5snthYnbGWxgciwmRXI9Wb
 SQZmVJPyhoB8gyo+7lqtjMFDVF+D5OXSh00D6p+bSiQzRmKnOCYJSEsJ5S/BRzvm6TNa
 taVGQ53dl9OizWzDYRVsfa2MiCG5nvlSYdH7J+YGz7B5sBBtTByX6eYn5vjuZ+MepWAA
 w/8ROHhbt9KJzwZ5QcGS4UnODryOD1Ih2yr3aMJst/IshtbFpfY1u/PUpHnn7G8Qsfg5
 BKoA==
X-Forwarded-Encrypted: i=1;
 AL+hErEfYFahovW5duUr7A57RCMZvXWzaeZIxpZVc/KCf702/PO9+PO/AadRPtlax3qeawY1Oe/SuGJNJHqtkAGW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vzZ/1ZaNg8c4qaoaVYi4t3CtQhRCOhDNV1QQSupBmT7uHtwPs
 NDWkKtc1GeJh71Zs33K0Wwhd6UnCtv9Ou6TwpQdbnBQc+ZC70Ct6hS8DLTcpxo9EyLNz7z6Jhue
 AF+nPlZ+OzVFi+Qms4YqA7E/4+jS3EPld4073KMeIvHi4FskoGkhiS/A3UMID3tBPuR269kNOxS
 xI3dO/nQ==
X-Gm-Gg: AYBFou0yvRZXuq6gIVjfLcviesl1LuXUNtyo5lye3qNkF9KkkS7bSb8sFnDdHZG8g8n
 82mlLbQ7iDBM05Fb1z8rfODy8Y8yh56c1+bU6uKAF6WZLOIQC5kqglHd6daMjMlBSMiowTMfvPn
 l85ojGLfSW1UQqqjNftXQM2p6sZDWW9kOJrVozRtr16rwopG0rfKf8boUh5xjBXa5t/+dorm1D8
 KXrFurM6oRhxuIcc9RL7CD4fuHLBu8J+FZTRuOou6ztIyl8f54eiLkFkqru1J6dUB66PrdNGc2t
 7z5nd4Qi+Ci/yueSJJH1JUZvEA9WNhRyOWniaI+lSXAdnZ691N7dwhU0FhI+wvGb/U6xJW8isHk
 40eFCDdqp7lGA56OfIaHh4TERKN5fUivv8D5GWAruHl4uQcr5EnJTkWSZM5y7WpU5SH3Olfx3Yw
 Mx4VhPC2L7X8ateKzYZqXF1CNRdi6RxikB6ZH8Jn/nrufUO9eSCzYB/OM9OVvlRUFp4Fv8RLqiD
 1avQrFGuhCC6z0uVvYrDtvN4/n46YRbP4COtebOrN/iK6ddzCx9W245QkqTCpa4bBbWfTuNl32J
 uOM2jtWRx3/FQ2EsVXIrlesxZmBSrt1vnEl5OuDIC6smOMiyeryJLxdKS+aZ/x1FWvIXDI6I4wP
 ZmZhlSY7JSIcUhn9dJ5HyOn8R+K3rTNqAy9XPdGRwoUrWiYhBpvKEM8U8GCJC6hmzVaPlt/KZkj
 BqlyfMEzuFawfKri0=
X-Received: by 2002:a05:600c:4e12:b0:4bb:69b2:d3b3 with SMTP id
 5b1f17b1804b1-4bb69b2da58mr255885e9.27.1794671185871; 
 Sat, 14 Nov 2026 07:46:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56719391sm59974755e9.1.2026.11.14.07.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:46:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 15:46:24 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 94d1c3ad8e783a6f7831b2d676f80a276bfc45b3
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 15:46:24 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <908c887b893f5b34850c92ae451306ca95f79c41-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSFxY-000000000V2-2nge
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0151784895663609190=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0151784895663609190==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ASGoRg+460="; charset=UTF-8

--1ASGoRg+460=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail )

Change subject=
: networking_sitnl: Reduce boilerplate code for parameter checks
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew-1

(2 comments)

Patchset:

PS2: 
cppcheck fails


File src/openvpn/net=
working_sitnl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/comment=
/04729c65_fa7cad33?usp=3Demail :
PS2, Line 893:         if (ret < 0)
cppche=
ck complains that this shadows the outer `int ret` and it looks like it's r=
ight=2E=2E=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f=
5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 14=
 Nov 2026 15:46:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--1ASGoRg+460=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2177?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">cppcheck f=
ails</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/networking_sitnl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/comment/04729=
c65_fa7cad33?usp=3Demail">Patch Set #2, Line 893:</a> <code style=3D"font-f=
amily:monospace,monospace">        if (ret &lt; 0)</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">cppcheck comp=
lains that this shadows the outer `int ret` and it looks like it&#39;s righ=
t=2E=2E=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">change 2177</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f5ca53d4288b092=
1610f7a3f84ad55d2ab49118 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Sat, 14 Nov 2026 15:46:24 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1ASGoRg+460=--


--===============0151784895663609190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0151784895663609190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0151784895663609190==--

