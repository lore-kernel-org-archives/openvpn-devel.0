Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5B8C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SY78H+zsWBGpCZPewz+oyu61vRQZP2Br814Ce2etiLE=; b=ICkH78Iuub76bSllBan3fMIPyF
	11YxppiNA9ODaV4hww80F9QEa/zTc/tAkxLXEK8A8KaMEEUT37j2o60KkTGi8qEsQE1LBiD4b449t
	4QC7rlHcWKs6AJLjYNI2JGzeNu4ZqtIcxxg36Ca0qh1Ieul51J/mWK3Rdn5tDvT3sXbo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52sm-0007sa-OI;
	Fri, 11 Sep 2026 15:09:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52sl-0007sT-NA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3OfJyNVHmJ4t0zbK+Sp69BQiHHlTCloxEth8hUN8dA4=; b=UcBDkrlnKO7EXhu3quormuXVcQ
 NE0sSGffh7m4dbL+9UyBfvdmhFn2YryDbHy0/mHN/aLyUSaIsVzSpFw8oXDO1xcu4q8X7cUe3HB1z
 KgvVQoWpD+fuBxJhzRvjDJvLzyIgQJTkqyMoQcg5lVZcPiquqlUnW7p97N2eL7gKHuE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3OfJyNVHmJ4t0zbK+Sp69BQiHHlTCloxEth8hUN8dA4=; b=J
 oI6uXabYyJhjldzr3AqnjlORP1ssWwQPZhu+1+lxoMOmFfpVec7CY7SZ0aLJ+gZfnFN7K4cCByIgD
 /3Dr1DHvx6Vl1utaL3NxtEk2/JjvHd1+L2YubDYRwO6oiffUWJ3Vj95NuM+ycW3NBPxH3dE+L+kXf
 3CGvD0+mFpRRIzD4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52sk-0000hp-U0 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:09:39 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso8390125e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789139372; x=1789744172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3OfJyNVHmJ4t0zbK+Sp69BQiHHlTCloxEth8hUN8dA4=;
 b=QXQFmJyTgIBKqTwkjo3x8ywJ9O2IriipXHIHCD21n2K6bGEqBE8qBWJh7B3T04v2Gj
 jT8R2NLs5l62fUYdBen60cu9qvFOna3msOR98qwkXx3JuM/Hv+g9AeWOKNQ6CTNjOdQu
 MtXg429PNbwUmTQViPRxxc3x5pfXt5pvqtd0qUOyFv73uAMoC6FUqP+O3KhB6G1TG8db
 RXsDfI0Dqhzm7Ce4Fd/y0hOUTmhjKkCLktTV4Xe+k01I6dYGU++9bJCSV2Eoj9tSjhoV
 Lt6LMOGBcgQk+z+zaXgalW+G0j0mI+AHIbXVHFdxFNJ1oVytTj8cHdCir/BejCekiGeX
 uJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139372; x=1789744172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3OfJyNVHmJ4t0zbK+Sp69BQiHHlTCloxEth8hUN8dA4=;
 b=XRDjaRSs3uRMpyxU3vkJUk1psso9sDafC82BhJNIN2rOpMfv6tUfRIXYSAyRKNpxO0
 qKF4ydeBY6AbPs4VZEU2HIJWXXQhn6wpqkD2SBFGAhJIfdPGPagOfxvNDsxRfEu71oJQ
 Z5dk+3mCTisq8Fd91K0HlkJ+7tb03pb8I9dc1AlzFXGbuMMXZJxQ82kHRFSHKImaVh9k
 741ngYV97vXmVAL0kio0ZnRMsD84Uonvf5pFrZwdo9X8nvn+FmXHhl0JYQaC0HyEBXLW
 exr7g7aOhU5XBV2EYaJdwrTLs+e/hVuHN9IoYEFqALKsJ6g/l1lhQfhu2x8yL+r1AUqK
 DkgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZm1Y0cwYiaIfTwgXapv3sNtzs12QPCckgFhIT3hHZlWxIjSRfK2mukwZZzYyvvIDjaDI5Xfxt6hNBy3xg@lists.sourceforge.net
X-Gm-Message-State: AFuF++nhMrM2KJ7yh9qXzKoxvLyqpSR10F6cEKkRPSRcyFiIyzuwzSdB
 dA5VbSW0yYPirx0z/qvJPmH3Swvpgn3DGmHf7C+MsAErT0kMWr/7e13IPeRJZ73IDgJ9Diarzqn
 nkmV97pY7dCnJQ3xd1VJgifqACqRsINpuRDdGSzy2/1MjPRIR1cXvcWpB2jAZReFW8N40vskdqw
 opk1D8+A==
X-Gm-Gg: AYBFou06Uv5HGEh6cA87lLLLYq1yXbfUaMrf40qNKgvJ8Nrw14zIolJadAVTiS/xQy+
 8+nq4e+15+KYlen5ZTb45OohrOEhlvvbssKD+m8R0tcwqMWIso0WgRp7j0K0K82P6TE7+K6Fv0B
 99rY4m+86FVWwHikguiM0GLIgFPPXpgIb9iOORSeaH7ok8MAPhTsPIshe8uOV23EOMeEEQhtXr/
 vPdvI06jdb/C1TPl1x0YPJvhWUdS1IFlz+D+mxnURuXGuIuyFzM0QiI06mThLJUyb7XC/ku2e0T
 oc6BK4ROyrfGjpCN5q02GuZRPwIKBA7Cpy3lBgD1G1vNOIfwgHrL//p5GLpzcAbHjO401zQUMzF
 qY0BdQafTZVA8DRs4E9JjVUqvZBgv0VbHNjteCx2xFp2/F4ZEzVW1bJonvx+5UK0aciv/9WI+wP
 UtJ3q0JotY2V8RfTpINCvTglkBBQ2zm2JrTY8bdWNQIurYCqncX5UkTgdt1em7OpCJGxwb1poHA
 2jEViQxkSaxEwBJRhLCxUK1vRbZeZyB9SM1JYKwfyPMP/XLDVxr5rE4fie1FPzh36uI2/2PjBR0
 3DtMBae0l9TdYaD5VJaCzrX2ZBKzeTG7qZhYTcf4KMnhMt+rnpPegSiflshKBw==
X-Received: by 2002:a05:600c:3115:b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49e619f687dmr107719685e9.12.1789139372105; 
 Fri, 11 Sep 2026 08:09:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm90165865e9.13.2026.09.11.08.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:09:31 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:09:29 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 9a2e2752ccaa828668b00074c644c385fbc798fb
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 15:09:29 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <52094b923017d26ca16daab3450b3a4d10c7210e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52sk-0000hp-U0
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0918543453250183645=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0918543453250183645==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PSd4VfjX91w="; charset=UTF-8

--PSd4VfjX91w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 24:

(3 comments)

File dev-tool=
s/cppcheck-suppression:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/com=
ment/0be163f5_bbac1f68?usp=3Demail :
PS23, Line 74: # FP: const silently re=
moved due to pointer arithmentic
> Typo: "arithmetic"=2E
Done


File src/op=
envpn/tun=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/958a=
b3b1_1acbb739?usp=3Demail :
PS17, Line 3253: read_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)
> Shouldn't this (and the function above) have been co=
nstified as well? Do we no longer build for AIX? [=E2=80=A6]
Done


http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/5c457639_19297594?usp=3Dema=
il :
PS17, Line 6310: read_tun(struct tuntap *tt, uint8_t *buf, int len)
> =
Here too, this function and the one above have not been constified=2E
Done
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da77=
0774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 24
Gerri=
t-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <r=
azvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Fri, 11 Sep 2026 15:09:29 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc =
<razvanc@mailbox=2Eorg>

--PSd4VfjX91w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><p>3 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File dev-tools/cppcheck-suppression:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1663/comment/0be163f5_bbac1f68?usp=3Demail">Patch Set #23, Line 7=
4:</a> <code style=3D"font-family:monospace,monospace"># FP: const silently=
 removed due to pointer arithmentic</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;arith=
metic&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1663/comment/958ab3b1_1acbb739?usp=3Demail">Patch Set #17, Line 3253:</a> <=
code style=3D"font-family:monospace,monospace">read_tun(struct tuntap *tt, =
uint8_t *buf, int len)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t this (and the fu=
nction above) have been constified as well? Do we no longer build for AIX? =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1663/comment/5c457639_19297594?usp=3Demail">Patch S=
et #17, Line 6310:</a> <code style=3D"font-family:monospace,monospace">read=
_tun(struct tuntap *tt, uint8_t *buf, int len)</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Here t=
oo, this function and the one above have not been constified=2E</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da7707=
74b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Fri, 11 Sep 2026 15:09:29 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--PSd4VfjX91w=--


--===============0918543453250183645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0918543453250183645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0918543453250183645==--

