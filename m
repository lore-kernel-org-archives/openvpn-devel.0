Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1304606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lcwlA+k9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EQ44vVbC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bBN9v7Hr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O50ROBhn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3M0KX/9Gj/OeuObjBhctJaKTSRY48UjGYhEMLsLGb94=; b=lcwlA+k9QDeNU9HUahgRTBi8qn
	rSsgUUMYCgOpE3YC6rtOnGsVw5zNaxhO8GrZE9d7C4tmMUcZvBR42YMxQYRvMAuWOXAJlEr8JfVVg
	MmJ92Ri+EeN7M1xWYkcj3uImC+chMPrhjtMkctwl4YYlA4pOqhXNejMTQK4QEtgiZyJY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ5TP-000000005QB-2laz;
	Sun, 08 Nov 2026 16:10:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ5TN-000000005Q3-448p
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 16:10:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y4h3tpnmBVz/twHMv0TRl0JIFvSg7DftkRkD11Kfmos=; b=EQ44vVbCF0TRQENivY+ktZhGn9
 mw6SBlwuvsDagiZSTimHSX8371p2lvRrKCa+PT68TNw6ILYS6eNkjbzHKqXaouXlQA7/DvbudgD5T
 pufZFwetv5GhGLzpa0UWzNPLapXl4+IBeyitRZTpc5X1UWcWW8LxaCmn8LuATIHy9+Z4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y4h3tpnmBVz/twHMv0TRl0JIFvSg7DftkRkD11Kfmos=; b=bBN9v7HrFnAyvmgbRCbR4NjD1m
 wfFPLQnLnwB3iRU/fCCNgwGjVxoV60ZOH2xFGh6YFbdDfZ2Y4lyshFdYm+V0yDiV6KKQ0/EqhuG9t
 IKEQ8/IyYUkH847vyS7NCVZ11LypB6Jg60SG0/v1lVPWiVJkpuCh/sV7UaMjyASur3CI=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ5TM-000000004ri-0YxS for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 16:10:25 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so114993f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794154217; x=1794759017; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y4h3tpnmBVz/twHMv0TRl0JIFvSg7DftkRkD11Kfmos=;
 b=O50ROBhneM39KiNDdsTGAztkEJc5jlGHlolSYhp3L8CsPJJMk9T42QjpPITRj/t2rY
 ILDcQvD+/8EgGi++4yMF8FoJJGg7IqFJffUgnvOFuoESfnsMQ9Ke6ETbZ+dfR1IPyThD
 ATU2Th6jhtf9Gd0Dsb3KVHuLcQ4inYOiDnw+Qhdl2k9NcgON8oiklHFf8mN3LJPmdRrE
 YV1u79tYdeDq/zjGYFyIq25cPpOhdmhcHBgtvSP5+p3ujqG3HyZb0k6H1ja19iMCMPAC
 1hMFIFlbUXQX1bvlano/YEYHHhyFgY0b2uwwjTC49NcEB06QssTlstF9OdIUSGanihQl
 x1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794154217; x=1794759017;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y4h3tpnmBVz/twHMv0TRl0JIFvSg7DftkRkD11Kfmos=;
 b=a15IHTF+as3ZNNZuPD3A+R9PCctBDik92ZJiccKVzMbL2Qyd16S0upU9lDGpSzBVMI
 Awscqlkxa5Rq+4so6aG4ILt+7VyRAZTM50PR6kbtvA8/id8+dtxE/n+FoPRVHU4/DIci
 MNr6NuX57KdJbOCHMrDMMDZJkNOnQ74ssMpuvHcmuePnNZWPjMBEfl7n8HHUKFtBt86j
 FSiavec6XcPcUTOMDX9lK6Gp+gI600CavrGhbPTQdAVTzfzXu6+lObNGgZ5Bc0siMPiK
 wicm56/0h04JtNIoBKIUowl84e1uBKqTrE20bUFyiusVKWRgoUpkqSAytz4IxwqdDj0f
 B/cA==
X-Forwarded-Encrypted: i=1;
 AL+hErGt5KmvrPsEgZ0HcWPiLPxntY7Cybjg6jGwTSqHVmjLQo/ycYCD1xjjO28QQTzPpEE9srtvVtne4LXvWpZC@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/+kdjRAn8GOBDNlUAJy03o1aJyrknakadm/X4MgZNOAlaHk9ns
 zlqWFHNnUFKGhvNodNpC/ssCose3jr7LINpg7hdtD/z+xW0ODRLpDGy7FlcifjWE5+Qg6klPbAU
 x6jYcfsN+lmSplT8SM2nAPSbkjY7QJXkdeMJ819hz3jskHVRFnAfKtwvi4UsUsMSc7D3W
X-Gm-Gg: AYBFou28qXLRBiYi+4dobncOz8MyEi1xq6Z2Irrw+1FB5ED+DPr6fZJUd7Y1wi0ejcq
 Kh1yau0x3ECY1GPsvCJG5zllvwLDVxQMpdaUCJmIq2dGPGC92LoRMCiOrhGX86bfkQVsexrYYIc
 DBjA57xuhVDQOiplympP1z1WMfPfHxTpIs0B6juoRN1EBd3dVG9XRVbR7H5nKH7Fle5rScqTOik
 G0erIX2zWA9LC4aD7ES02nzS1CoXe2Zc+vVHmUGA9Tkv1p2fkkUTx2qEfBzrzfY+sGx3+LSrZpj
 X1IRcyuY8RHT6oFtURrA7qkrvqaOFe2iOKMUHJ1PoId1KySgBM7jcIoyJbm4R97y6N2OroJ5Opg
 Ul4x6VdpOSBLVpoRYnOt+/7YETl67skoZIRdewNFItkmNN34MpaJQGXUOX1gkvpwECNVuW+15Gg
 sGULsR+a35tv4IutlzOlqhgddhNeMiWpRO7Z/VGc8yWpViiZSyRkeOYKO7Hv80uPyy7I3EOhAHN
 SLYOdViAjDdyYodY7eUuPvhGJx5+UFxRfwUsogyg0lYDHbIKpFHQ95PFxyCglIvTwFX8yYQb4xG
 l7Jog9/4Ii/yWg0HNLlNP31Oa1CMvK7mPPwMqDz5DVp/ab4Ere4VYbyEAw+c2N74WIyoQ5XxqkK
 kGqJw8h6LT+GzvXOlgFQa1pwJs1miY2GwIzrL8QbL3M2f1F+D2xVQLNMCcVPhOzOkl5TIZzrOeD
 zBMj4YzmF7YQPbEQ==
X-Received: by 2002:a05:6000:386:b0:490:9fe2:6a2f with SMTP id
 ffacd0b85a97d-494233d72f5mr7386150f8f.14.1794154216979; 
 Sun, 08 Nov 2026 08:10:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-496150c6e90sm2866109f8f.2.2026.11.08.08.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 08:10:16 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 16:10:15 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 2f0d22492f7753b0d6295f015471313e7f03e959
X-Gerrit-Comment-Date: Sun, 8 Nov 2026 16:10:15 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e65542312137ce672c8acb0c4942cb86830daeb4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ5TM-000000004ri-0YxS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, opidopiopi@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0359212497423417237=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0359212497423417237==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hIYHIzUWgkk="; charset=UTF-8

--hIYHIzUWgkk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, opidopiopi@gmail=2Ecom=
=2E

Selva Nair has posted comments on this change by opidopiopi@gmail=2Eco=
m=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail )

Chang=
e subject: Implement multiline responses for pkcs11-id commands
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(5 comm=
ents)

Patchset:

PS1: 
> Apart from comments below, in management-notes=2E=
txt, under OUTPUT_FORMAT no=2E [=E2=80=A6]
Done


Patchset:

PS2: 
I tried =
re-pushing this to trigger the Buildbot runs, but got:

error: remote unpac=
k failed: error Missing tree f6bb98471e275a4c88b6e8d969015945b6cebff5

Does=
 anyone know how to resolve this?
 
The patch looks good now=2E The commit =
message mentions the new management version, but could you make the compati=
bility behavior explicit: the new command forms and response format apply o=
nly to clients announcing version >=3D 7; older clients retain the existing=
 behavior=2E Sorry I missed this in the earlier review=2E


File doc/manage=
ment-notes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/=
5fdea454_4e3a2211?usp=3Demail :
PS1, Line 631:      END
> Describe the prot=
ocol in the both cases separately from examples? Like: [=E2=80=A6]
Done


h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/8366e0e0_e327e8ff?us=
p=3Demail :
PS1, Line 641: Example for client version < 7:
> This section i=
s confusing=2E [=E2=80=A6]
Done


File src/openvpn/manage=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/1392ebf8_0d4fbd3f?usp=3Demail =
:
PS1, Line 918: 
> Two helpers split a small parsing operation, interpret =
the start argument twice, and mix parsing wit [=E2=80=A6]
Done



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a4212=
8527d59832b8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 2
Gerrit-Owner: op=
idopiopi@gmail=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: opido=
piopi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Comment-Date: Sun, 08 Nov 2026 16:10:15 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Selva Nair <selva=2Enair@gm=
ail=2Ecom>

--hIYHIzUWgkk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, opidopiopi@gmail=2Ecom=2E </p>
<p>Selva=
 Nair has posted comments on this change by opidopiopi@gmail=2Ecom=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2148?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Apart from comments below, in management-notes=2Etxt, under OUTPUT_FOR=
MAT no=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I tried re-pushing this=
 to trigger the Buildbot runs, but got:</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">error: remote unpack failed: er=
ror Missing tree f6bb98471e275a4c88b6e8d969015945b6cebff5</p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
Does anyone know how to resolve this?<br> <br>The patch looks good now=2E T=
he commit message mentions the new management version, but could you make t=
he compatibility behavior explicit: the new command forms and response form=
at apply only to clients announcing version &gt;=3D 7; older clients retain=
 the existing behavior=2E Sorry I missed this in the earlier review=2E</pre=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/management=
-notes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/5fdea454_4e3a2211?=
usp=3Demail">Patch Set #1, Line 631:</a> <code style=3D"font-family:monospa=
ce,monospace">     END</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Describe the protocol in the b=
oth cases separately from examples? Like: [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/com=
ment/8366e0e0_e327e8ff?usp=3Demail">Patch Set #1, Line 641:</a> <code style=
=3D"font-family:monospace,monospace">Example for client version &lt; 7:</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">This section is confusing=2E [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/1392ebf8_0d4f=
bd3f?usp=3Demail">Patch Set #1, Line 918:</a> <code style=3D"font-family:mo=
nospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Two helpers split a small parsing=
 operation, interpret the start argument twice, and mix parsing wit [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 214=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
9e55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2148 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=
=2Ecom </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: opidopi=
opi@gmail=2Ecom </div>
<div style=3D"display:none"> Gerrit-Attention: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Sun, 08 Nov 2026 16:10:15 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>

</body></html>
--hIYHIzUWgkk=--


--===============0359212497423417237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0359212497423417237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0359212497423417237==--

