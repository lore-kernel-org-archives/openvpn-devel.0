Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04799606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ie2gqfok;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TqnfsgvA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TMIUt521;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F2Bar1si
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bzXM/hJbOGs+K7sZGgClF9OTkLttjt/gxgROGOcT/OE=; b=ie2gqfokBxGfospevvmNBFES4L
	qbA1Qna5GqTE+GIy+BVSa0UjU3vvG5ExVg0P1GYxzASGZE9bjKb9sfwxj6wCVMTK49cqrLi7u5Igc
	eljqLxa9SRqaqaXHPya7hUhPoozeriuqldHYy8YYlHIP3hphkmok/+3/v67vRpb2SePM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWufD-000000006Nr-0tZa;
	Fri, 27 Nov 2026 12:02:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWufC-000000006Nk-16lX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:02:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n/CqPpED/qo709ICSB7rMRwJ731459cfcGkKhIiwq4o=; b=TqnfsgvAKB79gXFEzn657wQkeY
 1IZu3fazNmZmf+bC5SWL6FrZ8wP68DClGiU2wuHk6U7JFKPgZ2sN5DfLghMwd81dgEd+VOCZMOzMg
 EAdj3blEhJrtWz00Y8uVNL/liulRI8ddXmfFZZKT6m9/pJlQv5KrkmkgHihpIOEU5CM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n/CqPpED/qo709ICSB7rMRwJ731459cfcGkKhIiwq4o=; b=TMIUt521CyEaJ3I9pMCe/0IiUU
 6I0w4uTqmsYUnOYBOaFx+yNInao+qTsN4wMCX65vs/6c+FLe1HvHimHiemrzfKtS4+LHNvVq0qvXR
 AuxO3P03iVxhILTnYSqGCqi41l75EjPTVhC6L3qPwNn8QKfyeR3ENUVb9B2T4nGXM7j8=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWufA-000000007ot-2EXN for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:02:50 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so64884365e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795780962; x=1796385762; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n/CqPpED/qo709ICSB7rMRwJ731459cfcGkKhIiwq4o=;
 b=F2Bar1sizBguB/D6bTOzNu1/TKTAt00uMNPRMc/12oXDB+f6NaG1bLjmzPMgIjABMP
 Jy4/zSjOI+n/6c0EviBzkp8M3VUmdgwHKPY2nXBK1ScA2z9y5t1BjSe+WPvP6t6nc7cS
 Hx+KYpzmf10QmYuhGbvI/hM5zCYffLTjfXG26Or4CLtQ3Wo7zQaUoHJfEERaZaFm3Cce
 26POrZtApKgSR1LNZ5vqBajSO/+p3496X4fbQTyxH9cteWrOj+N0nDYR/ek7koNdxW4S
 +ATwZdMo0LXdNzJg9Qb2d9L0d2aI0/gji9o/hYbvBZscrdt3evU51zyLF1d0s9Z0HAAL
 j84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795780962; x=1796385762;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n/CqPpED/qo709ICSB7rMRwJ731459cfcGkKhIiwq4o=;
 b=rsIq1CqeUze+CrhZUFTNwhhw4QjS5piFYNQMqS7PgQBkc1aHeXAkhFCKTU6B726Jsb
 ETaVXJj15mc09svpasg80Mh7bHB6T/KHz9YovmSiE9ES2YojxWpGpUGVPjTI5WjVswdj
 bz3OQvjgrApfUBwwsOpbhISh7u6cxf4ePzehPkLmzYy75p+Mkl2jLtYnEDLClnYn1ceN
 NLAWaV/zGSOEvhq/442ojKDvCAdfjgdWFr6I/bdr+agfeRgSLlBgOhcCEPWP1ykmE2ET
 vNHcGcVXagNv0MdR7CSudf4WbNVpcSbN/SEKmlUaitC1pSOVhv9kgOnl0cvrOJLjlDQi
 zyJA==
X-Forwarded-Encrypted: i=1;
 AL+hErHfY7ggqOWLXSObtXXl4xioQ/KD7EcehXfPt/4JLR1CevHHAXfPGcnMla5UOSghnrdvhMXACpywMdM4miuE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8+hyaAhdWcIrKKuMWpyjwTsVxoZxJphE60t2apWlpcex+6dY7n
 69Eq98dZTx4kFTehZSoBjTdJRjUf9cqOTWfkfptdKmHk7ub3B+uSlta2H6MrngYJ0iJHg95V+Z8
 tLv6OCGNfluvCogs3dwF1SOjPr6GuaWL3eLnlOQfz/Td7f/OH5KA4zudd2yVrBwbApWhs
X-Gm-Gg: AZFdTZc1cGRRutVnuqEI1s0OMvBujzVY+5MQbVU+tBA+t29TF2uZp+fMMnCovoI7umd
 zUsyf6lQWEx9QP9Q1O7gJf05cD+qjw++Ntx0vYYec1U/svpGGwaiUH89HqhGZJkHSf3Ki1OdyA2
 HIiEsg5c5lfsKWcHo6COH0aXNoNvBm15+76UBG5GGS9g+KOFvGM71jqQ6MtfcPbI6vMUGA4z5Sj
 E8p4s6FRY8uV9vRbThE+0VM5sj623bcFZ753N8QJH90qTKIeLthdDrxJqn/ik/1eTYs1491YXM5
 i1GFs4TTJoHbXGDHdEshJGTXHZ8qGFpgo9E71HdQjqanYe2oK79cnGXXT3qBA213+ntKr/BUuJ3
 /kLDz3S61l3NeqJzoFe+KFEk1YA73MEUEjnF7Pxhe3oNlAD+Bx7TzD+F3FbQ2TovwngquPjPrSc
 vCFwffIoSeD2Aou/yVRdxPbfWOJo3eT1NVjdxXF9/oaXLxoHvga4JIkboZWNFd9yThGQpVcqNyX
 GHQpTLtABr6dUNWHdfD4fD35zhjPLDq3bKL/tfq0pp4HmG97sMf0igcB4Tq01M2bhuHYP+j5jr/
 ByHKYxsOnEfwj1USdyGF1q0j/LNKOBndFTDAg3yxA/BmE9ZPXiZOUziGvJakEcYfu9Le9R3i2hH
 oxiESQ1bpsjUu1yBX/jQKEi10NYGQ5Q8TMf9nxsMQuDBkw37xUbuXcC1upps+DWDJXoRmwunxDB
 P4cr41MEcV7vSipY4=
X-Received: by 2002:a05:600c:468b:b0:4bb:5fd1:92aa with SMTP id
 5b1f17b1804b1-4bb888160c2mr515614475e9.15.1795780959219; 
 Fri, 27 Nov 2026 04:02:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm713258575e9.3.2026.11.27.04.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:02:38 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 12:02:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: 8e2bca57b9c422b8c104ad665f8186cd65a93fe5
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:37 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <672e65e8b29010734a815bcdf6c15955a24770b0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWufA-000000007ot-2EXN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4940170785982523242=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4940170785982523242==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jmyq7ib6YM0="; charset=UTF-8

--jmyq7ib6YM0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Deri Hae=
rudi has posted comments on this change by Heiko Hund=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail )

Change subject: dns: restr=
ict dns var names and values in the updown runner
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+1

Looked t=
hrough the whole stack=2E The temp file is gone on both sides:
no dvf file,=
 no unlink in the runner, and the scripts no longer source
dns_vars_file=2E=
 The vars now go over the pipe with a size prefix and
full read/write loops=
, and an oversized or truncated payload means the
script is not run=2E With=
 #2349 the runner only takes dev, script_type
and dns_* names, and rejects =
the whole set if anything is off=2E Looks
good to me=2E

Two small things, =
neither of them blocking:

- dns_vars_file still passes dns_var_name_valid(=
)=2E Nothing sends it
  any more, but old copies of the scripts still sourc=
e it, so it might
  be worth rejecting that name explicitly=2E
- Maybe a li=
ne in Changes=2Emd: with --user, --dns-updown scripts now
  get the dns_* v=
ars in the environment as documented, and
  dns_vars_file is no longer set=
=2E

I'll abandon #2341 once this is merged=2E


-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
Gerr=
it-Change-Number: 2349
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@i=
st=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Heik=
o Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 12:02:37 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--jmyq7ib6YM0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Deri Haerudi has =
posted comments on this change by Heiko Hund=2E</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Looked through the whol=
e stack=2E The temp file is gone on both sides:<br>no dvf file, no unlink i=
n the runner, and the scripts no longer source<br>dns_vars_file=2E The vars=
 now go over the pipe with a size prefix and<br>full read/write loops, and =
an oversized or truncated payload means the<br>script is not run=2E With #2=
349 the runner only takes dev, script_type<br>and dns_* names, and rejects =
the whole set if anything is off=2E Looks<br>good to me=2E</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Two small th=
ings, neither of them blocking:</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">- dns_vars_file still pass=
es dns_var_name_valid()=2E Nothing sends it<br>  any more, but old copies o=
f the scripts still source it, so it might<br>  be worth rejecting that nam=
e explicitly=2E<br>- Maybe a line in Changes=2Emd: with --user, --dns-updow=
n scripts now<br>  get the dns_* vars in the environment as documented, and=
<br>  dns_vars_file is no longer set=2E</pre><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">I&#39;ll abandon #2341 once t=
his is merged=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; displ=
ay: inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">C=
ode-Review +1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2349?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; p=
adding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2349?usp=3Demail">change 2349</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d=
28a968 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2349 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Fri, 27 Nov 2026 12:02:37 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--jmyq7ib6YM0=--


--===============4940170785982523242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4940170785982523242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4940170785982523242==--

