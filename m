Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE70606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g4eUHk0v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F9fcTvpW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M32eraIb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LE5QxRnq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nHNXCVLj9SkZPCxKVUrb/jVugOXOlwj5vkqd0gSiMwY=; b=g4eUHk0veJ0uipZre9hdmv4LRw
	7TVPMXrmsf5vXgW5qSod17XJw1y3gl25dboDoxgxoxrIv+VbbET35+E6vqa2QbeVvOIZcYbfKVUbP
	VUw6D0uSOxOu91R+6SXVLPhFUul32BzaH3PD3WLhXoQ5YSOlMsQ7snDXwB9KmsPXE2mo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNUpm-00000000427-42Vm;
	Sun, 01 Nov 2026 12:38:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNUpm-0000000041w-0Mrj
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 12:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nwWRlFiwh6gaat/7Ej3J8v8TT8Dpx6HKq/lzwqO5ZYQ=; b=F9fcTvpWrGHnDoHYDfkSBxdaYL
 kGLiSKbc3Z1Trsx3tkFWui4bLowclgJEov327KLFDtl1FRY4EDeyHudfymBgMFv0wMGksuqE2V6zN
 A0hJE7prZsgZ8vHf+sz/9fVC76jiP9mYbKWUh/f0ukp+Y8FVd+9fvWYvF/YQHFlAr+Hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nwWRlFiwh6gaat/7Ej3J8v8TT8Dpx6HKq/lzwqO5ZYQ=; b=M32eraIbld2nw0dMp4izpH353g
 cqIEmnpg8J6t3ofi1kqKTG1O8HAsdCXjpA8qG9Fy2HxkDeERV0b0b2EPEQf1gzpls3zhir+5Gqoem
 +4i0BJSU8TgiG4lXe1CiUW1kqhcCrw6+qXHaBwcDeGcLH2WHPxfawvCzHta3Frgvl2B8=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNUpk-000000002pk-3YdX for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 12:38:50 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so16437185e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 04:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793536722; x=1794141522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nwWRlFiwh6gaat/7Ej3J8v8TT8Dpx6HKq/lzwqO5ZYQ=;
 b=LE5QxRnqe2/w/zDNeNdlAXuCX2dmH6HaxZjRAbEi155xhQathDhvnrDmrdgjKDqsSe
 L2j1Y6A3+SyUyosJQww+O/aL6wf/QZvvaLt48tgke90gtUYxUYZp94q1VL4pM1HLHqkg
 c/VsCKcOc0k2P7AJWSiR6OnsaGVoP8ZoGpcuSiHRbMedwD6JZnnM04k5Ufk08Qp82nXA
 1UhuRX7b99EnaCFbKPpiw7EgCyHLhOQIA58ce1wu2Xw3yL9FT4MRDwEYEiVVvmX1BdtX
 r/GN0GCCMmT30w/Mes+ugWZv2adcTh6rtalcoltLbQXdQWNG+VUgBWCFeSCBTivF4qwh
 9KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793536722; x=1794141522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nwWRlFiwh6gaat/7Ej3J8v8TT8Dpx6HKq/lzwqO5ZYQ=;
 b=NMsenmmd0gqFVuOL7oAZGDRUk9WXp/CxYy7LKgfU/4pWY8Aa7duBV2gBNt8jbiteKX
 IghUhg63cVLrGboBpiMfh/YvhP8fVcHV6oqFzPbe2MZioGJoQhv+rlSD/B9SpNKRTk4P
 ir1066eMU8FHLkrneTCaAjX4jnlEtWayE+/Zi7W3ifhySPwbs5YY9F7dLI88F/gi5m64
 Ei6Z3WCtQFU+ghmWvzQP+xN4HwnMW2l/6X1BBclPWOrZmHnvtp/5qwffVvDgdv2+9tu2
 uBficrD4ETqurG9n0O/qyhrLLSLK/Jbns/lwGBV6gfY9QkiYN/lihxnfn6sX+JnThija
 UCPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfBZ7sjUvC02hD++Pr+Q3U16ZnMwXaspU/0W5YcF7PX371rJKnCyAyahxApLf9FgBtFjpGcKT2O5gZxHYd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIauQ2SpB0hjrIhh4jMB+TWdgFhK9oCSginh+Y+B7d1K3dT6NKi
 0BoH7f5d/By8EyJKaG8kPDUskkBMP3yZGrL7zGGgYG1njeX8ed84jFXJ4gfVvx6Z16AR/cqh9Vb
 ccSEOenh5CVtlYK3/g+a35bE68nInkCMkRySMeo8DUOU9pgzxVsTprl9hgTQKJvHvczaM
X-Gm-Gg: AYBFou2svokZOBnuuSXUuh7hew+ZbmF4J7YcEvqqgrzqzOmJBzFZtoI7PnSGqMZZkPu
 UDvIqswJ0f0x4Ss3cOS2NcWqdJjfucQ39r/GAcGp+NnFUVN7yyL+ELVtKi56gXd5Pn9gKysx8Lb
 FR9pYLWk5+W73vMdnp66xCxQcbWJQG0o92LWL31DclbYhYZnq9/24DHWTevHtyvZE47KplFJeU9
 pGC05vSH68m3uOifrQ5dn77KcjGs1xF0xXyoJ+YbMbyhx3TJqlxHtIBB6VwSxTMSRL5/BTIUCje
 a2p7CKbmK+gKBKC00oMB6ix2GDyJF3I/lGpEoLzUQgO3Hyy5/IT34zV+MAMiosG+tgWSFv/V94Y
 +H+l0xfNxl7l04GATrOdv9J8XBAqHnPDbK/P82cph0YfT9irqCt1vBtp2DRt44xI+RrSTw8eW2O
 n0lHUHrqF4xewJdkT1Q+EC6zlJ2xQD8ooNUZzC9ekvaJ6YfJI2xSDKqRYZSHcyZ7kuNACF6Gm/E
 65KBJDr8hLWMHxqSdk91tijsx+MvTmVuTinjQbvaMuYUOqIHdNorzjI+aEOWm423BNgAYFMRQQT
 6jew4OZm9b1uPCkvzKnmyrxih7Ae6OQSHKF+S2cWIbGrvNyFZOlrswBGEPF12yL5jujU2s8umOK
 w8nZH20h4Fry04qAVxkTGatCvmyFodTpIswy6zFlnJF9HLws5agC6xqSU4GgMj7G7buChNPX1Mb
 Z1Yce7Cz8YuU2z6Q==
X-Received: by 2002:a05:600c:1d11:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4ac174712admr175829495e9.10.1793536722178; 
 Sun, 01 Nov 2026 04:38:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a6bsm13795985f8f.27.2026.11.01.04.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 04:38:41 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 12:38:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: b9f4c1f5236329ee63284a2b85ebba5baf2095e1
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 12:38:40 +0000
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9917b778d2f3cc498e979d0f6569854488972af7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNUpk-000000002pk-3YdX
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
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5281979156007882089=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5281979156007882089==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5ZelYo4rUpw="; charset=UTF-8

--5ZelYo4rUpw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Hansae=
m Wi has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail )

Change subject: auth_token=
: Wipe the server secret key after loading it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/ope=
nvpn/auth_token=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076/comme=
nt/2b59e930_e9fc3717?usp=3Demail :
PS1, Line 176:     buf_clear(&server_sec=
ret_key);
> this is doing the `secure_memzero()` twice, as `buf_clear()` al=
ready does it - so yes on the concept [=E2=80=A6]
Thanks for the review=2E =
The two calls wipe two different copies of the key, so I don't think one of=
 them is redundant here:

- buf_read() copies the key out of server_secret_=
key into the struct key on the stack, so after init_key_ctx() the key is st=
ill both in `key` on the stack and in the 2048-byte heap buffer that read_p=
em_key_file() or generate_ephemeral_key() filled=2E
- secure_memzero(&key, =
sizeof(key)) wipes the stack copy, as tls_crypt_v2_init_server_key() does w=
ith srv_key=2E There the buffer points at srv_key itself, so one call cover=
s both=2E
- buf_clear(&server_secret_key) wipes the heap buffer before free=
_buf()=2E This heap copy is the one that was found by scanning freed blocks=
 in test_auth_token=2E

If you would rather keep only one of them, I would =
keep buf_clear()=2E I can also add a short comment to each line so the two =
copies are obvious=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2076?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
G=
errit-PatchSet: 1
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Com=
ment-Date: Sun, 01 Nov 2026 12:38:40 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--5ZelYo4rUpw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Hansaem Wi has =
posted comments on this change by Hansaem Wi=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View Change</a></p><p>1 =
comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/auth_token=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2076/comment/2b59e930_e9fc3717?usp=3Demail">Patch Set #1, Line 176=
:</a> <code style=3D"font-family:monospace,monospace">    buf_clear(&amp;se=
rver_secret_key);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">this is doing the `secure_memzero()=
` twice, as `buf_clear()` already does it - so yes on the concept [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Thanks for the review=2E The two calls wipe two diffe=
rent copies of the key, so I don&#39;t think one of them is redundant here:=
</p><ul class=3D"blocks"><li>buf_read() copies the key out of server_secret=
_key into the struct key on the stack, so after init_key_ctx() the key is s=
till both in `key` on the stack and in the 2048-byte heap buffer that read_=
pem_key_file() or generate_ephemeral_key() filled=2E</li><li>secure_memzero=
(&amp;key, sizeof(key)) wipes the stack copy, as tls_crypt_v2_init_server_k=
ey() does with srv_key=2E There the buffer points at srv_key itself, so one=
 call covers both=2E</li><li>buf_clear(&amp;server_secret_key) wipes the he=
ap buffer before free_buf()=2E This heap copy is the one that was found by =
scanning freed blocks in test_auth_token=2E</li></ul><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">If you would rather k=
eep only one of them, I would keep buf_clear()=2E I can also add a short co=
mment to each line so the two copies are obvious=2E</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/207=
6?usp=3Demail">change 2076</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2076?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2076 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Sun, 01 Nov 2026 12:38:40 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--5ZelYo4rUpw=--


--===============5281979156007882089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5281979156007882089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5281979156007882089==--

