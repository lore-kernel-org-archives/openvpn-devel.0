Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB17606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gc1mPB+S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZrTOHL+E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L+KktBRG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B/uqlqvA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MtkF4Qiagww3Y5BoCuGwy+aKDq7AKD9mgX21BxxJKI8=; b=gc1mPB+SVDEcHcMvstxMfO120u
	ZDh0WD36Lx+YzCmDq7Wb7H2IyJFds8ONYBkQU8bqDVAVxruMYEHqT+OEhw/18nTwnU9lPLA6tLAEE
	YtFOmp4H0UXnwbKeTd10ofmZJuw/cww1icb75dr38KvWzEyco9NOpbG7NO9/GJpak9CQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNdNE-000000003ER-18jK;
	Sun, 01 Nov 2026 21:45:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNdND-000000003EL-1oUw
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 21:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Psex4iDcFTX13+Wf5XI/T2BTuxK1xgkZGkrA3dpAazQ=; b=ZrTOHL+EUgck+ClUcpq32OOAhI
 Xtc3BQITz/kaLHpQ/wBoPH0vPFozNTi5G/EpRXFAPFNzCOdw37vs2I/bur3AsqluDp3L7ercCrkAw
 eHg+ZOuxeUyVQKuaPYat1oMaNN5J1RWy5A2xkqj27p+cMRmFfwRs51xZcqwNaR9imqO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Psex4iDcFTX13+Wf5XI/T2BTuxK1xgkZGkrA3dpAazQ=; b=L+KktBRGVYOEH0Wmen1TPgTBP6
 INfs3gSrzmB4GBWaBRg7aYgjcxWV9hOPpQGIRlaWQynT4B0pAaiVXrdUUJZ7ou2GrK6vZDfT6QjhD
 LrOXm3ctuMwxWwg7nzkZsS/U49tK+/r/kSvhcMRdS3mZqnlcKrcxTIAsgA8qujfMvIWg=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNdNB-000000002z9-3JhS for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 21:45:54 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2266149f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 13:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793569547; x=1794174347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Psex4iDcFTX13+Wf5XI/T2BTuxK1xgkZGkrA3dpAazQ=;
 b=B/uqlqvAPRfvOHgGlpqs3ETNDChLRevUpLmY9VE7bFFoBSRNujVZRN8HAtEpVXFryZ
 B92wClkIpJzGBJ8pUCI2oWZi88zkjZKElqBfFSza8jgFB7dFwGNDzQ+HtJyxu2gCXTwx
 a4pIuYjYnuTMMJqPygzeD0e8ZpXzWSHc/VSCR541hmCNO9yQGSds/32ke0sCcKSuGoEK
 ES8MJ5JloGjuGclHYcQu0hvTj0vk+jJBPELGVu0JjJufgD7zJrUrlWNmlYUM0req/Brm
 1XxNfKrzPgsdW8B/aQhiXEMf/dwmB3pSpfcekhKLsiaY3V4g/Iav7d6ZGUlz0QVVN0Zn
 YkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793569547; x=1794174347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Psex4iDcFTX13+Wf5XI/T2BTuxK1xgkZGkrA3dpAazQ=;
 b=J3DPc8xhx+gzSfbAWuYCmAb7i7PhBuNZjFXxRiouS8Qzmv6BrNXSAoW2OlEwL3Rioe
 la0lWOj1MPUDZQbNYd7Am00TM8RZDZ9m5bpQ9ak3vjnzpF7Z6pBxiIgN/yRYMvY1V03R
 2w+RHsxBDb3gtB/+UOBt9r51G/K+YzJ1OGNmo+85zTDjYrm7J8G9jOGTDyOJtXCSwuKx
 tCPIFLfv5ff3IktgmIjpWG9F6jiKxxqclxchZZl/5UsAShpXVYkjRAzZ6J++9dHE2flB
 XRS4JGNijqgZs/o2psNgjfHkZxYywTcxHyBd6zyx/shg2vjcqsJnG4OiJ80W5KfreJVm
 SdDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNzxSVRbexEoxInQhMqiLTgsjKjzyZVW40f5Hxu3NvhMCQ6uOYdfcyXP1AocNKA96QHmUsg9g+waOlvroR@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/3D9bZ02nR3vBUxia0+SPVu0ury0rjUu8tt6Uh39V16bLXUwrB
 sVvaHKYwVccqDMVOmZkYgolahtMbTGHXfHTv5WaouuKTVuNMOUjVaA/JmTmVXWntz/2HByUAw2k
 F0D4w3cqo1ymCPlt+RcUHJOMjBYGFhlMAkYzALg/v3F3IsSCbAAW+xhEtpbAnGLb+u8DS
X-Gm-Gg: AYBFou3qzxSVFpDWUYNwsx2SMSOKfyEFvj9aLr6NtSELmuSms+8giZt67GltOo4yFg+
 N7naCTnZCnnFH569T+Z08Pgpf5Tq0uCLNXQuJ5c8GeSyyods947StR3gm5IqW0I369EXUMs6vX5
 T+m/3rJg0TuulMqTL9iR29lvhpmkhamUV6uVcgdQC+Ps1qE2Oy6ptFV1HIrN2Fz4ZDhEXcgD2ab
 f198MSyU+TkOkF+Pp2aPMK0iZzLSXpMRPH+z9tBwzftbLBb+oYbtcF0H5aQvXf4yt/OsdMGlzTG
 Y7DKzffQRXcAJEBoaiLq5XY5nsldt4gwzDa7JbRUH8wHWeIEjS/0i9bQ0gGfO0W1SWdHw6bHQqU
 dV0vvF6PsochXNS1Xa58W379WQ6JcOfIbe+8UQd26RStEPyFXGrFqQRDFo1ddkHJO9gNYYLGGgl
 4sAmoFGydVCRJYeRbzfcX98OCADk5PZvaBL6TYdz1THkuN1iRLFUnjmGPkt7PHLXVMEkBhIhEid
 QCveVZ3X5lQ0wf6+nK9WH2H9mbbgfKqdkl4z9YqDAbCV/OqmbFWfkvvz++6Dzt1ejTcfyCpYz7w
 5s04gUZmW8BMZ2wDAfU30Q3Mh6Nc3rp/T2wSJ4njEpNocFaIsAzXGBJxcHieAFo9ZYmhbg6jllj
 8sfyLK0hfWvVeKYVPHeP790ZqzcCZPtdVOHKuidXZxY4DJqNQTRbP2NX0qL83T7oJGMJyz9GHkT
 xWLNJLo/qAZrgwkA==
X-Received: by 2002:a05:6000:4a19:b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48e6e4f4405mr17960395f8f.30.1793569546444; 
 Sun, 01 Nov 2026 13:45:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm16560677f8f.35.2026.11.01.13.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:45:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 21:45:44 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: b9f4c1f5236329ee63284a2b85ebba5baf2095e1
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 21:45:44 +0000
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93e80b6d325845e0fb1348ab27690872d0a8c26c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNdNB-000000002z9-3JhS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4916397871881409627=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4916397871881409627==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3p/NoNiECno="; charset=UTF-8

--3p/NoNiECno=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Gert Doe=
ring has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail )

Change subject: auth_token=
: Wipe the server secret key after loading it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: -Code-Review

(1 comment)
=

File src/openvpn/auth_token=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2076/comment/e6f1e189_2cbb9eb6?usp=3Demail :
PS1, Line 176:     buf_clea=
r(&server_secret_key);
> Clearing key data we no longer use is a good pract=
ice we should do more consistently=2E [=E2=80=A6]
@hansaemw@gmail=2Ecom oh =
indeed, sorry for not looking more closely=2E  I withdraw my -1 on that asp=
ect, and leave the rest of the review to @steffan@karger=2Eme



-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1b=
d64fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet: 1
Gerrit-Owner: Ha=
nsaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Hansaem Wi <ha=
nsaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Comment-Date: Sun, 01 Nov 2026 21:45:44 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: Hansaem Wi <hansaemw@gma=
il=2Ecom>
Comment-In-Reply-To: Steffan Karger <steffan@karger=2Eme>
Comment=
-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--3p/NoNiECno=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Gert Doering has =
posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/auth_token=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2076/comment/e6f1e189_2cbb9eb6?usp=3Demail">Patch Set #1, Line 176:=
</a> <code style=3D"font-family:monospace,monospace">    buf_clear(&amp;ser=
ver_secret_key);</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">Clearing key data we no longer use i=
s a good practice we should do more consistently=2E [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">@hansaemw@gmail=2Ecom oh indeed, sorry for not looking more closely=
=2E  I withdraw my -1 on that aspect, and leave the rest of the review to @=
steffan@karger=2Eme</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">change 2076</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5eb2=
4b156acb5a99c614050fb1bd64fe46d8b52 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2076 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansae=
mw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@ka=
rger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Sun, 01 Nov 2026 21:45:44 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>
<div style=3D"display:none"> Comment-In-Reply-To: Hansaem Wi &lt;h=
ansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Repl=
y-To: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>

</body></html>
--3p/NoNiECno=--


--===============4916397871881409627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4916397871881409627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4916397871881409627==--

