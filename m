Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D123606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WSPI+A9v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UBcd9beJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TgYqoB+N;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RHKDW/hK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tmHrACZYQFlw3345myAQMPIiUkWY8wMIe5IJYl65jmM=; b=WSPI+A9v+L8PPAB0pUFw4xv3CO
	bpV2n4kD6nICmKNfHC04dKHSFxnoSRQ78ruZ3NHTp4l9u3ULsMn0AlbMR7+LjJ73fqEdsXCWj351F
	K7V18H2kiCj0/r0DNFwzepU23QppOWvN30Hk/NawN4jyX0pd8uXOSiOZ+Droy4Upt8hk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYAH-000000003XI-2hhq;
	Wed, 04 Nov 2026 10:24:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYAB-000000003Wt-3tLk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PShH2aGhh1aBDRZiCZgzoXspFuuhvN0uPpia7tFPcmQ=; b=UBcd9beJFRGfEp6Jbaqn7b+m3b
 0T71JECMcbm5NpIpnAXx2x3hcdYBPj6DO/uq64t20jf2+TeCIqWX/uXLfVnYbvK6hESqXzWEIONcb
 TCWBAKAVylbaRNbS0snTmlP9k6jsc63JahabT2K8/UN2SFRfU3uGYBkx6bb6hh/J1GVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PShH2aGhh1aBDRZiCZgzoXspFuuhvN0uPpia7tFPcmQ=; b=TgYqoB+NuBPf8hEdPQq4cCdJkK
 EFYjT/XJV/5y3+i44IS/YxXfVQDXkBmq3ZoRC8uKFfPrBgiVmYTwVx0WFXHUxI/sKWlJLQIKUopdL
 7/20+bvq5htGkfPxwRWMAB9AmSHl+GfkEHBgQ4H1RG48ZkG63Ltbu6zYNJqOVJEuGVaI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYAB-000000005Tv-0YAh for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:24:15 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so2807115e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793787848; x=1794392648; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PShH2aGhh1aBDRZiCZgzoXspFuuhvN0uPpia7tFPcmQ=;
 b=RHKDW/hKBD29Doj+N0kBXF9djxgbEi2lNjOzHHkm/quN9anLW6Qy5aNf0yPcrBjxtN
 rah4JoSBHZar3l6aZ1C8+r0H1O2+7/ng0pZmINfbYNzMPCUVhzx5fPDGZVhxeTJRRERO
 cAzPwnsbf2ZWoHtBAviQ8M87lS2nH15z7It8lutRkuWTF9lvztryqLScWpW2lJ5oy0I3
 AN78AsoFUA7YLXIVDZ2o46agAU/7Z3sFwn+msSI/+4tPst9wThjxPZMYi9b7UmAj80W7
 YgWKc3Nfz6cANzssBrOzD5fvgPeR9mPncUJZvFOisBfIGPNg/t+oNRufUyx1rTr6NL+7
 i3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793787848; x=1794392648;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PShH2aGhh1aBDRZiCZgzoXspFuuhvN0uPpia7tFPcmQ=;
 b=IhLep+7gnypXcciNQo3NZ0QyHzN7KkS1hdbu+HuPeMcZcxYhzE82ZnCK5NTOx2Mb/W
 sOA8RAjBCcH+2MnzCedN5Lis6amUYutecwU6JBbdQgU7UXu1QQeHzCGn3Ytou2qUJiFy
 8junYM0NZFIRmU2hApYJ16voS+SVaEb2+Q6vZs2iQNQ0DgfEFszA/j1vIZmr75Y58tgn
 jGgDC2pKkzuyvSuHJDiY1PBJ1Lj5S+BXDUKSi6ya2b4xFtj44c/j4MLBR2VTzAQzJHcM
 c8PlpaTLqxY2RvlYY/TjeFnTs4E5LQDtaq1taR39Hx/gKA7GFWA5XgWX9bZmPl6eDNRO
 0fsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV4Bu/AB14A1PnwHuJmEQOh6IfQExfBF+2TA6FQgPC1Pvv9g+DxIvnp1FemmZ8i1KQ5nbLSilZg4FQaP3A@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8LVc0I1vBGB/nZLLJES51kmojDb4NNB5zj8MceeTlNMkBNZbUv
 dy9LDSM4z4VS10xLO+0YpGwxv1jrSFxp2kSQweRcnh3egfII6dmf8evSbwCgDtr7bM4pv7wGd6A
 iJwrNHHHz//mhEU4po3LPisyiT38c+/6RjqYzGKaI7mMscwJCCxXBKS+tjvyhZMY1NzxS
X-Gm-Gg: AYBFou17Rw7R4amotESl33bTaPyfu6ZOKOqQJnhEowtsTUj+eJZ6TqFPnO952f/qN+W
 W2XmqtV8m25moSY6o853hImvHUh15zsM7XnoiUVYml3dw/05Cc8Peg+VlpLlHmyA7uRXrVDu2O4
 bc4xB6U3T4Bg5ZOB3RfI53iTiPKOAThmzY3qmZlpMbBsWGUsU4/enjxbgVbVVtLgnZWjgBopZCw
 nfW3Ma8kPv39L3KtPoPURGnnvrLVmrxeNKta9dxMk+UcAr7qSPG5XMOKSW7SfHHJGrTmtLijqYE
 +aQA186wGTSrfO8Xgo/3tBLYmm894HHrBRpf1mSvf5rmMnaYQBl7etyMuXAFRBCPfi66v9P6Ape
 cfGxRQ5Jiq7R0FFN7uYrsTguB0XkraJRs7MbdCS3jB3pFvSX3icFsAsRkvEld7MUmcyAvMMHo+9
 KhoT9BC5uz406J/3H56tiPSHHkpgnVSLPmojvDWI/8c3nqB/fdJvS7dxNQf9Pq0KI3nY2TB4yRb
 jJpvXGNdRfRkBCI4Cx+uM7nn9MsqWot6fGT+aRAFSXghJj3+v5UuXauby1NXfCW0rSO3i+pwOim
 kEarwvsxbZh12ODp5lRD44sQHY7xc+E3w4XD1ye4J3jxxCYaTz0oUiLg6IsdOj+oFzbG4KBbXIK
 0RMwlNLkKtwHyegpMaR3RBah2GO46XWNNYHw/UdND/WHmOwfA/S0lufJxILxsXsw3ZCJVvDAYn7
 +CKR4BKuEMoAJsLQ==
X-Received: by 2002:a05:600c:37cc:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4ac1980143dmr320141935e9.35.1793787848387; 
 Wed, 04 Nov 2026 02:24:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm41897315e9.5.2026.11.04.02.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:24:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:24:06 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 1f49d662c74f4b3abe7fa74a5d9457ed78c061d7
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:24:06 +0000
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4555845e38b1a95c1284ef548426d40d553d24bf-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYAB-000000005Tv-0YAh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8835215675219306911=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8835215675219306911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fAuVB6sRpjs="; charset=UTF-8

--fAuVB6sRpjs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail )

Change subject: dc=
o: track installed iroutes separately for IPv4 and IPv6
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2=
 comments)

File src/openvpn/forward=2Ec:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2061/comment/2eabf41b_638f629f?usp=3Demail :
PS1, Line 557:     =
    dco_delete_iroutes(&c->net_ctx, c);
Doesn't this delete both v4 and v6 =
routes regardless of the per-family flags?


File src/openvpn/multi=2Ec:

h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061/comment/e187c1c1_92a7e298?us=
p=3Demail :
PS1, Line 484:     /* Skip DCO IPv4 iroutes that have already b=
een removed=2E */
"Only remove DCO IPv4 iroutes this instance installed=2E"=
?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b8b0a3249eb4=
1e1de10f381932c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed,=
 04 Nov 2026 10:24:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--fAuVB6sRpjs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2061/comment/2eabf41b_638f629f?usp=3Demail">Patch Set =
#1, Line 557:</a> <code style=3D"font-family:monospace,monospace">        d=
co_delete_iroutes(&amp;c-&gt;net_ctx, c);</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Doesn&#39;t this delet=
e both v4 and v6 routes regardless of the per-family flags?</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2061/comment/e187c1c1_92a7e298?usp=3Demail">Patch=
 Set #1, Line 484:</a> <code style=3D"font-family:monospace,monospace">    =
/* Skip DCO IPv4 iroutes that have already been removed=2E */</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&q=
uot;Only remove DCO IPv4 iroutes this instance installed=2E&quot;?</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2061?usp=3Demail">change 2061</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161c=
d75270 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2061 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Marco Baffo &lt=
;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 10:24:06 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--fAuVB6sRpjs=--


--===============8835215675219306911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8835215675219306911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8835215675219306911==--

