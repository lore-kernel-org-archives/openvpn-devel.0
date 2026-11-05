Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78203606D82C
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gk8hfSAt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e2UVBWWI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NsTYCPu4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CSWzOTIO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h4P+eJ5PQFAIzRKC9o9CUsOl+9cqvD4MS05kg3sQEKI=; b=gk8hfSAt+yhBmpiI//CjZjt7nU
	1rPEEX8msdsLeO8ZaFb0TSlj/asQzxb68TensLQzcN4zv+cc/nU1A+lcMhOLBnIv4/VejQPPy2tWS
	Gxgs9uCoVxW1djz+/RUwrdNmJ4/DbKnAR5+/Us1jOHdwsmnVam2tVoHy0ODDATQlvS6c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOzJO-000000004or-2BGL;
	Thu, 05 Nov 2026 15:23:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOzJO-000000004ok-0WXt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 15:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gTIlnrRAvrQLkup2qY8hOmMwWIMKBEdpJCDmGTPHXgs=; b=e2UVBWWID8DTSbH9MlFLYurmpY
 DlkUHu0hFNSfhhHRFZupjanX+rL7cpf86Mv+sDLmiVNNlwemHf79vnGJJPFrUOpOxCAwRsr8nhGos
 1m8uUvIsI2ZiOtx2LXmpjRwOCycZc7DILQLKvS3LoNxaOLHldqDYfXIqnFZm+bI8bHTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gTIlnrRAvrQLkup2qY8hOmMwWIMKBEdpJCDmGTPHXgs=; b=NsTYCPu4QoG+wifJ3AKjB9qBlh
 ENDrXdcVvQqLyyQS1raT+HW2xWUsQUjMF6VoOHrY702fan2RbP1EH0BZNKNm/XvS39xC7nvgo1WGt
 oheflKYNgCIu3sVOGd9LTKx2pNchqPqEXlXhxTGnfkz2Zz/VZ8G5fIlZeIdkwa2Pzpvw=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOzJM-000000007nJ-0O1t for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 15:23:34 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-49231763f81so192746f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793892205; x=1794497005; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gTIlnrRAvrQLkup2qY8hOmMwWIMKBEdpJCDmGTPHXgs=;
 b=CSWzOTIOSxgtCwUVOLHO+X3D976lMAOmnNB/3aAK2JjOE+Z3cDW38WbD/susGvgGlv
 2YyPzB6ZwEKimqoU/tiKgoyoJgESSeS8vupZnRQ7S33eMykftiCXcIbZZjPHLTgECR7Z
 pSwztNKv/84ruQfF4t2z97gjbxg52IC5/atG7K7bmoXnG0UF1Eikgd5NsB/HYRIeE7Jn
 D5GDFRkQC5i317mfhl3hWqcC83fTG7HbyjbrSRFDetCqKdrtQXo4WndwZkhrnxbzLXyY
 VHvMHNUjDgPlpDiIgsGz1EZPkfQMnPmQQlkQnsEdA7l4YdrSV6HjVAGnoQy66ScnaBXn
 CkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793892205; x=1794497005;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gTIlnrRAvrQLkup2qY8hOmMwWIMKBEdpJCDmGTPHXgs=;
 b=R1xZIsDfzgW/aVCcOutsIyHvgeLY2QnwFTPB9s+EE6Rr9jDrZK64+rWFmrEeU49Xny
 GrDGzgK6k5iIbzHDj2uCPLc1XlYwNjE//lJBt0rkY/Du/MLB7SocjCfihj3VqprCclYZ
 +dYnFh5x299GwKgnT+NSu4XTsEMLX8hVkuyORboN3VuTwjzgnTm6lubfH9EXx2ocHJXK
 2MK3rWdo/pdSOGeAAmuNBM8RJiNuQhw9t+Ff7DkBuLe4Hb5OikApW0PfHO+97HB7VLqk
 nkbSF/LsIuTgIzch7p59VMNnClInAU6OSfhIemilzbmGQDBviwjhKtDF1f3u9AXewuxv
 i5yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy87sDwTUCQ6XJzl8fpEPrC096/1rdiYocAB+qcnwhHI/dgo9KS/mps+jZE3LhfnErt/EWSR2CvN8UWB+PN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9DhAAmO5SIKwvhEtqQ1jMuz8p/QIiBSa4W7dVptvTz9Lhlxp/j
 szNDgvaEBOr6WapqhVQupOPj9Q2rc+uQ5ua2m/Lzo+jzjLX+xwiTC/UqVHHFIIBflU9ZurSEevf
 cg1GroDf0C4NaEhqW01G0mL4CjZn2aUQ0AC2Xww9aMBUMoI0uaVhI56hvN9iOdg5nnqCIU00IvN
 hq7uUaAA==
X-Gm-Gg: AYBFou1uf1DVltPvxD5SojHgWVh9fZgELCx+HzKNyrPEQBw3QFoLbLN/1A+60J3pBzc
 UrGefz/ll7+v0VuIDBAvmOcRmmd3SdwyuQcvWEXRiEesM5Ug60aiJOq4J0TYtrCbIBAeyFoTNMx
 33YGQWr4hxCEAnGT5g/0r2KzacDJpguxk+TBn+9ycqFL7AYvHgnipYf4yLG78gE/hecYqJnku4m
 E/P+MDIIZ0EcQZSutcGGvKdIY9rhTsiKIcRgdiI1EfDg0GvumXDLimKFANhf8nEF3mU87FEA1G/
 z0wP7exrnRPZQGtY09dbub8DbSbnKDpMxtxJUwFrnkD6SqdqZyBJ8RIsR0vBDbZ1xTYIVJuJxF4
 PJNtFEUOf89rUE4k8ZH7tqSzqSoVkMH5BQBoyiN+mX8ctSZqQAVNY0HS5lGs8vOalQZaetv6z8/
 eiIpgU4vvJqZTwlwsvZEBjQrX34G4XtgOVGWsljoi8ENYyprQKQnxouILkH+iCaKtKQoXWrPgr6
 ILINaO4CWRKiCr2ZjWGCefyC9szAxvir0b7/WuOQD0LfHLWwYba3teRdGR8Kp8Ez/g/Mht8yJVM
 eN5B+dCW9NoXvPloItuzS9ARlzGkh76jMvpRn07z/GEC7AUnn1of5FCp+9oANVMVYpqQnX7WSLE
 8cNvjFy/UKKTU+SdefhYu26yM1+3W56RXNq7wEw+b+fIpcZcHEcJrbrQUKuTxXGIU/GVnj27Rbw
 uSBFoU2keJyBDvEg==
X-Received: by 2002:a05:6000:200b:b0:48f:fcac:a5e2 with SMTP id
 ffacd0b85a97d-48ffcaca675mr10008002f8f.38.1793892205305; 
 Thu, 05 Nov 2026 07:23:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm10615500f8f.49.2026.11.05.07.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:23:23 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 15:23:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
X-Gerrit-Change-Number: 2141
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2141?usp=email>
X-Gerrit-Commit: ac887c352dcf82277edf8772139e0056467426c2
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 15:23:07 +0000
In-Reply-To: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
References: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODcyNzg0MDAwLkkxM2Y5ZjdkZDYxZDdhNGNjOTg2MTU1NjI5ZjZhM2M3OTJhYWFjNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <997d501a26a0427cd944a26e3a1f136a23e20874-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOzJM-000000007nJ-0O1t
Subject: [Openvpn-devel] [L] Change in openvpn[release/2.7]: backport
 t_client.sh changes from master
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4599005833781544357=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4599005833781544357==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LeX6QM+rUHg="; charset=UTF-8

--LeX6QM+rUHg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Frank =
Lichtenheld has posted comments on this change by Gert Doering=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail )

Change subject: bac=
kport t_client=2Esh changes from master
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

Patc=
hset:

PS1: 
> This is missing the update to update_t_client_ips=2E [=E2=80=
=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2141?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: =
I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
Gerrit-Change-Number: 2141
Gerrit=
-PatchSet: 2
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerri=
t-Comment-Date: Thu, 05 Nov 2026 15:23:07 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>

--LeX6QM+rUHg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Frank Lichtenhe=
ld has posted comments on this change by Gert Doering=2E</p><p>Patch set 2:=
<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pa=
dding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2141?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This=
 is missing the update to update_t_client_ips=2E [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">change 2141</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: releas=
e/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13f9f7dd61d7=
a4cc986155629f6a3c792aaac6d2 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2141 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov=
 2026 15:23:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--LeX6QM+rUHg=--


--===============4599005833781544357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4599005833781544357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4599005833781544357==--

