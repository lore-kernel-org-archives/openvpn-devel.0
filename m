Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2F606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B7YtWLxf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e2kDSdc8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E2RuJ3mJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QKi3ygns
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=88UnLNSXD7IcpGi4aQs8CgxuY+np0la2cXr+PJj+JX0=; b=B7YtWLxfSbgbqW2vz36njch3KL
	jVzYYB3ciaDYgzooZiIWLJCjq61q6GG44uDUqA2iGQ39GqDedCH4OZWAzgdAfr+mnRJIjVorgntmV
	qHRG5VThBmbdPiLtejVzp9SSUhrrPQ8xAXR4MuADQIdEPynZOJGigRTjiItwC/S6nvSU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNCAL-000000008NP-3byH;
	Sat, 31 Oct 2026 16:42:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNCAK-000000008NH-3Mra
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hiLMMCLQZaLq0a8EqDRyG6EbHIM9pfRMtftgDYgpGCs=; b=e2kDSdc8AlfRY7YXKtiILeVn7c
 8lvCyAxlR3GxoM42fpr4/9PnM0jW0vysM/Ppa2nt//9QQM/eObUnzvFz0ZH3hjYz/k2TetDniZtjh
 4w/KpuGS5J9ht7L5N4xPb8CWs+qEl4HfJFDipxOpxzx0vi+RaQhZjOSVFVaLThrwpW4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hiLMMCLQZaLq0a8EqDRyG6EbHIM9pfRMtftgDYgpGCs=; b=E2RuJ3mJzHPYCYXaQXIrYxa94x
 uf8iyAbfgufvtaOSD6NfNakaCZOw3QQ4VdMLpBDT3oWByO+3b34Cv26kxHmsQsEUfREwUtutrGUIf
 4Z6ARe9GKTWgLJPEQgPjJJsCaH2eh84a8DoHUGFRYtd5HNzuMyyrAO2iq/rNwAqVKEPY=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNCAJ-0000000044z-19Fc for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:42:48 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso836515f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793464961; x=1794069761; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hiLMMCLQZaLq0a8EqDRyG6EbHIM9pfRMtftgDYgpGCs=;
 b=QKi3ygnsSYfDtonMd3QQTu/7y31JZXaxDXSZ84BM9VT+tj1fX1n7UGkpIVAgQ4+QtX
 w0qNSoqzuhf8j+phwbSS1aplGcQZTB+kA1+4Vtp2MFZCh3nhgsbj3WQyYPAy4ydJFftS
 V3I3SJJ+J9B59oAwBMysUlKFnoIaNmKpqYE8Mr0WcLlFW7UNEY7TxhRoi2uZUiOGnZWY
 PZ+yHVjoJEY6vcx5GVlWcEV+fbjZbTUaaSvK04wu2baL9N/jm/Uterbdj29xTY6pSL94
 l/rWaFiGde9i8dRbwwr+x2IhFJLha3Jr2TfZHJMhO/J+cyT+f5S7nnfnHELTw4JRwglP
 1Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464961; x=1794069761;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hiLMMCLQZaLq0a8EqDRyG6EbHIM9pfRMtftgDYgpGCs=;
 b=HHChEih2Ndq78NgisDWFk1Po1m3iMlw9OSN6oPJNLYFmw45DY0Q3Usj6edGJXVDz8L
 ahZtHNlXsRv7MRrSbxEpa/aSJ+LLUrVD/QUaGKhsTRoG0nU0bYBHfk+jnTCpmuZFxYz0
 OuRf6v852205wC0hNCN5EDII5807VFClnIGU8KmYZe1ERwX6IdZkVfX9Eh6DTuZaNngG
 Zpct/xVoKq+ir+dTg/Rs7iHONtgknOv3u2JX2MFf5bUHubeTx8P77sk6is1Hed9wquKH
 rTVSRw5uOYX7P059Fyn2nxpvHcn0LNHdInHPTW8FTtHuHOFwGdPilBfiV/X9q9A4IKXV
 3hVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq7uFhMhAzM5JX9t5hmk+PWrKh3ZzTaFvt5P6eBQkKY5pI/2M5up//oQjyRUjbX0sahPmfIn8TabuwJXba@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLwx6g7/x8kxg6qBJeAmwsASz9otkqSJbGIdUp6kYFNYyQ/NJge
 o17Nt2AmV7+4tEreLnNIpdY27PHqWK6vydLZCRyN1QMbFC3RgP5eFeuBE2r86z0xzS28//YqrTZ
 dKGhl5gSAWmx5Wimmzo9G2txlg25E04pLC7AUAW4LOJFR1GaNhGpZ1sQTr7et5CKLSbwmPXD2vG
 mBeqzgaw==
X-Gm-Gg: AYBFou1atehm14Fd/Sxwo7hkUcnU5wZKtzACmwzaDVK7PiSw2KRHnt20LhZmFSVXJ85
 pN2zxxZAc5+pfswegBjadlAS80C8bQ+hf+FMUmASTM8x6+j604x74jmLqphWOocxvC7F5c7lcRq
 wuoKH4j2W0zvNKv8PabNIikuYXxA+HZJSFoZNlwDEEJBColUhyMj+fGXURlap9PryAA5dYSvdTT
 7H8CqRz9WUzZJS3M+eMY4EKcts2G8YSPogDLMO6u7EmjT/kXnTRfgW8VGmY4LCejv7/eedY1XBJ
 7WP8UCIO9PTp71TKexhoJp/PVeapZHfjV8uoy14A7rrI/qtQaBnO+uoN3dtN4TiVxO4fYlxQEgW
 XNI5+p2PuBKLNg7K+h2ib/ByvTygW9/jI2BqV7GqQ3s0mOiHPheDt6ifdPA8Nd9CTyTGPN6hpmk
 1IABpKUZgFUOQGMeZdhmauxqm6Q6wkFWMXc41LLTw0/08Z0OkhipBK9F4uGPDddASiDDOAZF+AT
 bV7GCQ7Hu4GZHmieUdzxFKI/41aKNhmka2wmSoVaAOlpZFSuRSWGEm0GwKyTEq4OfZnpSewu00X
 Jc+kozjF9MgxIxosQsh//belsR9kYgDJhA90169Set04Qlewzm3JCPwTHQioLIFyw+8Ohfpd131
 4Q5Z6k6Z8XXEZxKrvTQP8ylRlJcNBlYSjP665/ju+bjpM+yi8JQ7QETFNmJwcwL1x3djRrX4zy4
 IGINwtW2n6Y3yU0pQ=
X-Received: by 2002:a05:6000:612:b0:487:13f:f612 with SMTP id
 ffacd0b85a97d-48e6e4f4c90mr13442927f8f.37.1793464960591; 
 Sat, 31 Oct 2026 09:42:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789c6sm10343919f8f.26.2026.10.31.09.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:42:40 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 16:42:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee
X-Gerrit-Change-Number: 2032
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2032?usp=email>
X-Gerrit-Commit: 734db16a8afd2de4703886fcf966d22ce4741b24
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 16:42:38 +0000
In-Reply-To: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
References: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTY1Mzg4MDAwLkk2MmQ5NWRhZDIxODkxMzUxYTE2Y2Q2YmU0MzA2MzQwNmEwMjRhY2VlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2791cd41c91f93d44d36b950736d12da2bc63e5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xNCAJ-0000000044z-19Fc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: release the
 session-id hash reference on shutdown
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6013792388096144801=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6013792388096144801==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e/nyLDbtHQ8="; charset=UTF-8

--e/nyLDbtHQ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Gert Doering ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail )

Change subject: multi: rel=
ease the session-id hash reference on shutdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/ope=
nvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032/comment/ed=
22418e_7b59fb5c?usp=3Demail :
PS1, Line 588:      * too, otherwise the inst=
ance is never freed */
this sort of comment ("drop it on shutdown *too*") m=
akes sense in a commit message, but not so much in the code - a reader 3 ye=
ars from now will ask "too, compared to what?"=2E  So I'll reword this on c=
ommit to something like

```
/* The sid hash holds a reference on the insta=
nce, drop it so the instance
 * can be freed competely
 */
```



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I62d95dad21891351a16cd6be4306=
3406a024acee
Gerrit-Change-Number: 2032
Gerrit-PatchSet: 1
Gerrit-Owner: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date:=
 Sat, 31 Oct 2026 16:42:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No

--e/nyLDbtHQ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Gert Doering has posted =
comments on this change by Antonio Quartulli=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail">View Change</a></p><p>1 =
comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2032/comment/ed22418e_7b59fb5c?usp=3Demail">Patch Set #1, Line 588:</a>=
 <code style=3D"font-family:monospace,monospace">     * too, otherwise the =
instance is never freed */</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">this sort of comment (&quot;drop it o=
n shutdown *too*&quot;) makes sense in a commit message, but not so much in=
 the code - a reader 3 years from now will ask &quot;too, compared to what?=
&quot;=2E  So I&#39;ll reword this on commit to something like</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">```<br>/* The sid hash holds a reference on the instance, drop it so t=
he instance<br> * can be freed competely<br> */<br>```</pre></li></ul></li>=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2032?usp=3Demail">change 2032</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2032?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2032 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Sat, 31 Oct 2026 16:42:38 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>

</body></html>
--e/nyLDbtHQ8=--


--===============6013792388096144801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6013792388096144801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6013792388096144801==--

