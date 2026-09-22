Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343CAC982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DY61HtLG8y3z9kwgNXSeP0P+CkacwlvFIzGGWglGWpg=; b=Xa8BTKOytupmuSjOPyxLYHmBFs
	m1TXqAPFoqozwFbgryQtiCQGV2ewFjAWe+DnH1JH4oE6ahvWQFWpn42gtGp/0b6V8okmUjH7u2Udu
	w9MFqCkwST4YLCNZoSQ6zkyaV3dHAY1GHAN0b5xydI5xB8wjnmuQ+s6sndQFCh0KK/xE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91tK-0003bK-Oi;
	Tue, 22 Sep 2026 14:54:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x91tE-0003bB-0P
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/18kNfT+pFnQhyx2Ew7y93Im/WnNsp5VT/In6tiI+aM=; b=TeIX0B3I9gOYapKcyLJSFUU9y8
 OifNVlgzEHl93EUPTfAcYTrPa4qzxDZAnvTGBI4Ycbjl16WNJjcw5Keu9dE7SUrCWDtH53Ot7YYtg
 m8VeHuTF4Tzz9HQD5yXWoSSQdUwh6oJBhYB4SFU3FX56VtXRTXmBT5HVW6qlUkpkdjZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/18kNfT+pFnQhyx2Ew7y93Im/WnNsp5VT/In6tiI+aM=; b=M
 pYTc8NTOFRycjAjN2kytY1dEvb0vIY4tBeCzESTat9ilSwH3ZTZ73BoBFrDhiygww43kaZVbzFiXh
 10nsDsj1X+eYaMJNVcqeMrlw4OYkRHwXcADZEqMxQItc8MaNZUfF5sSwkGTkGMw5ItZB4si4fdKaY
 HGw/HS/VX2DMvUjY=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91tD-0003BV-AK for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:54:36 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so580960f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790088869; x=1790693669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/18kNfT+pFnQhyx2Ew7y93Im/WnNsp5VT/In6tiI+aM=;
 b=M4nOQnRXrUaAAO83vf1wSq/p8KJlRIOMW1SaDWKxDkFEaFGfvnVChxeOcAmOhUboyv
 fHv7WV0/pRRDJ0SCbMWNFKuti7nfceuF367/mkmuKw6IamYB+4Nc2LUcvNKBUs7vkJyi
 315jEgHJT+vpKbyC9pcJmYVtQ2NlT8MD96aiS+g+68FsXvlNcpqtO61PANp473P+3Z/y
 kBISDsMXyudry4YgozsCNJuPszykZuDRZVmEx5J9zW4DyL52ZbMxxGluWARCqEdcko8X
 IsoCCGOs55VxZ/WsR5NnhLgXDeCpDPyPRo/4bbLJB5pkjiLxZaFRMqDpnQOWQodRfcuC
 LzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790088869; x=1790693669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/18kNfT+pFnQhyx2Ew7y93Im/WnNsp5VT/In6tiI+aM=;
 b=OyNundYwA39GE9VTGR1elqKSRVWd2zdOUnZC298xK+w6AoBOMSQ+wzu9+8ft35S6bP
 OGIdjoP8zk34ifRb+7ua7ZnHo75kB4SWv32+l6D9TM2hQ+KEtQ1w8jzALb+703uW0Y82
 Tr8H2V2BqkUOIclIrLbib1rhQkeoeK4QUFQsIBa5WSkYBI6Vr2VbxgwAnFWdjRNjPOOL
 9kIJrUFonb8xvC95Zog1MU75zg5fIa2fgUUNBBd1GzW62pdmeTLY3UY69L/nkSeYAPnD
 FFCDNqhEKA8fFpR3jVlQS918d8OZjskuWEIEQ9B/SsRwBBGSPkRZyWe81icE6CL3RIoO
 OGiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4Pj4akYU5YgJgeinigaqNN2HrKxYT9xCZfpJqBJnEI7tYV1F+uZ64B1Z3ZZlza5txnwARN7X6eH1p367z@lists.sourceforge.net
X-Gm-Message-State: AFuF++n3OXoW6shZsejUjGx7KeNtx8vOkkBWX/Bip4OA3sXPqwBsFUNK
 AT2vK4GJGdWV6Pn0L7w59M43Yp8Vv15qzxF4qgrBox/+T4KG9tTmSfZHb1JDiyoTaUnUbKL3c3I
 4xPx7pi9Oo51N2NngGfRDzuacsznx4YWrnONtoVqS4xkED4/uuFtaF3tt2BXNiH/13J4U
X-Gm-Gg: AYBFou1pqQzZ0OrA+SfI8mumaj4avIR8iWrhflYcw12GB63SmVrxJ80O6GyshdLjtVB
 ItzX2gEFuqVuB+6Ee8qO3ELaQsGtYCmMG1h+g71ba3pSjIi0CphPojubJoM40daefVx/xwnGwlw
 AONg3QOHS0+FkYw1MKQaioZ1Q7zRSeil7/AkiLqcezF7bSAyOJ5ZU4+SnlX9TA9yBiHzs59J3Ei
 buODnw6BwyPsKqiqS9peAbUN20+pXIpsxsWpsru+B5qHoD4XhupT+uSSw0kWc3w96y001piDc46
 N3w7bNAONWYsQWWU8GyA5u+pz4mXFYARgOJp8NTKYF9dy/Y9S+C6suKCIQVY4D0iGobzYQeFOpS
 fcbF3JMqBmhcMn6qbMqrLioSIL/65EWXf3iHhXP758wfIUzXTRFwVjD7v+ACStFuZsJ7wjkywV4
 a2s3ADtl/3RVl8a7tOXZNKJe/SNhGK4gIWVBEJx0mCE+Ys5qd0+wBDenJyCXliPqSDrfYbGr+0+
 E2ftRbYrx6wZpjF3d6fyL050pZUksm9AaPMdluHiDXa9gLkTltJ2lE0i1y8yC7IxGWpOl75VgQF
 yoimkz3At/HeCSY8NHvpjvHazdOikRHiUyxhQwZOUW6qAznsHEsI30+AKtck
X-Received: by 2002:a05:6000:1ac9:b0:485:8226:c696 with SMTP id
 ffacd0b85a97d-48860fe5296mr5275743f8f.21.1790088868667; 
 Tue, 22 Sep 2026 07:54:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862731bf9sm5674080f8f.1.2026.09.22.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:54:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 14:54:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: dbde2bc6021437e1cc5b3dd8d793fa8b87c6043a
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 14:54:26 +0000
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f74345f814b955d270ad63ea075c3b37bc32dbf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x91tD-0003BV-AK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3607229659334462942=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3607229659334462942==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uF7aDPSwMf4="; charset=UTF-8

--uF7aDPSwMf4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919?usp=3Demail )

Change subject: Document notify as auth pending me=
thod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(3 comments)

File doc/management-notes=2Etxt:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1919/comment/9bbf5102_47585e08?usp=3Demail :
PS2, Li=
ne 799: This is notification that there be might some activity that potenti=
ally takes
> "there be might" -> "there might be"?
Acknowledged


http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/9690f36b_3d58342d?usp=3Demail=
 :
PS2, Line 801: a server side check or an out-of-band authentication like=
 requiring to have
> "might a server side check" -> "might be a server-side=
 check"?
Acknowledged


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comm=
ent/f92d40ef_87fab677?usp=3Demail :
PS2, Line 804: This message still might=
 prompt the user to look their phone for example=2E
> "look their phone" ->=
 "look at their phone"?
Done



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Gerrit-Change-Number: =
1919
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Comment-Date: Tue, 22 Sep 2026 14:54:26 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <raz=
vanc@mailbox=2Eorg>

--uF7aDPSwMf4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>plaisthos has posted comments on t=
his change by plaisthos=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1919?usp=3Demail">View Change</a></p><p>3 comments:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>=
File doc/management-notes=2Etxt:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/=
9bbf5102_47585e08?usp=3Demail">Patch Set #2, Line 799:</a> <code style=3D"f=
ont-family:monospace,monospace">This is notification that there be might so=
me activity that potentially takes</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;there be mig=
ht&quot; -&gt; &quot;there might be&quot;?</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment=
/9690f36b_3d58342d?usp=3Demail">Patch Set #2, Line 801:</a> <code style=3D"=
font-family:monospace,monospace">a server side check or an out-of-band auth=
entication like requiring to have</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;might a serve=
r side check&quot; -&gt; &quot;might be a server-side check&quot;?</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919/comment/f92d40ef_87fab677?usp=3Demail">Patch Set #2, Line =
804:</a> <code style=3D"font-family:monospace,monospace">This message still=
 might prompt the user to look their phone for example=2E</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">&quot;look their phone&quot; -&gt; &quot;look at their phone&quot;?</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail">change 1919</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6217c0541=
bff81eefa63a987db8904b2feda2546 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 2=
2 Sep 2026 14:54:26 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>

</body></html>
--uF7aDPSwMf4=--


--===============3607229659334462942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3607229659334462942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3607229659334462942==--

