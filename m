Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E416ECCF2DA
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRhluR+JxnEqu8D8dCAIc2gquukHQ8k81KOas7VD4DA=; b=eG16cz1nesXyg6WKSE2XzCGN49
	9KBSlDN7sNkCH5ZCl482YN/3al2ACCKRQCayDVSfFUmvLM4BNQ4tLZhRL7uD5AawP4Gpl88V9Awb7
	q+1+Mb4pRyyevWT55+EgwV0vH86UgSxXVW+ISPYqPSZzuqzAccHuk4zEIiTrUhvJt2aM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIh02-0002Tr-6W;
	Mon, 19 Oct 2026 06:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIh00-0002Tk-Dq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 06:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LsDuFhRPnpwnACvs1U20W2bSGylvMd6lidbn1Bph1ns=; b=I9asy4jx5Kl9tSfBh+puIuCyrg
 pMvjrf9Oi6vQQ3gPElXf0i1uebwBw5LIcdarJ+WoPOOqQUBZtXeR+VewFdemqcEuIYzB8a8Y8jRUy
 9+5ZBpNZb5PGevUmQVPrh2a4JdOJrZQRCZjGYjsL3/4SBi0/j0Iwry2VO+6o/Zj6Mx7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LsDuFhRPnpwnACvs1U20W2bSGylvMd6lidbn1Bph1ns=; b=O
 3t+lEnDjd8N/yUtLWcvufDf7DEnWQJmcNOLg6eaFkN+mOSgUCVh+h1cPojEdbC9jKAGsGgH8SEEWx
 9XgweFN7sJaOuX5Y1mVZxv5uT7SRJqotMwGsvHa1AUwZ/SfzexUN2dnWyddUpNo1OvzEpw7xNBRJ8
 lUEtkbZC6vtaYcOA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIgzv-0005es-Ep for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 06:37:32 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso762985f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792391841; x=1792996641; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LsDuFhRPnpwnACvs1U20W2bSGylvMd6lidbn1Bph1ns=;
 b=ffz7Spon/aXSvdGvQOxZ+oNoKpRfPLbMz34NmNXZzmSG/uGEpGfZLd/ZtsQnytqpSB
 4mJ1tUiIrKefC5MngBreShSbppfDMeWyV8/V9WJj+/rhCTtkuBfhchiMDMgQH/H+Du03
 Yr0B8t7XLYYfpKd3qAA5fdbyNGvuT8AxulCLUyXxaGzgcbsXTfMeNZDhVgUOcC5r7TgT
 +xO7G4pwNTcHntUi5EPbOnmDKdXgqkTRlK89kFXKZh/+LUnlS3gAR2b/qXZc+vCPsVaL
 kcm1SCwepK3zwqkbWzxOWljWihITM5lx+fkdSR4LK24hLSnF58kS48FAhH+auhaWd2ai
 M9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792391841; x=1792996641;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LsDuFhRPnpwnACvs1U20W2bSGylvMd6lidbn1Bph1ns=;
 b=xcVPPOPkaij8AIakzkKE9GdkSn2WPJOCVkKzyJyXk8dyLEPC1GFaxAR6wot/eDShGC
 dTwAwwidC0aWrP5Mb97XRhaL402RJ3NhHKbulgYVpGSjPHs2trbkoIM5GQzGbox948Wf
 Jno+CEsSG4wXkeOYyJySB6KCTkvK9pbKx4EMKwmwmqs2dggQdW0iji7ziBkWUFvWfCxB
 w4bmLbWRBn70NQ1RIZVx+oIg8ti5mF6pXaeFM9/WE5N0TVZfuOyCMbpCZKFWm74PC/R1
 Pwy1TDOEeYs6IZj6xRqVfAN/UQR4f16ndjMbGTVpz9NxPz64VpficR7oQKr+FSxFtA15
 YRqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByi2z5E8Rq25HDklZU4eha5TmFJKCf7yB55tQXFOFqpZmpJ42WWWjbE9KGrPZl77nhixzY7uLyyVZWtmPJd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJgRuB71oSxazIiYaICjtOFGaxusD5OnKyz8kCFF3IqNKIz02Ed
 wHExMsmeytgvFtr4aJ9h6G+jAI94HbpJyLX7HZ/bmD4ZknPfk0u4p9GSw5rhvWC/LsP3Bo9syMy
 EXSWI6U50Ms5FSBmisxDxTVUMrHY8rGKJNrk/sbqdyhilg4VbthwJhVK5tfWlLKCrhq6mQMh1Yz
 f7/wJG/A==
X-Gm-Gg: AYBFou3is4W4Ijjn0L8I4VTOgrECJotDeVoh1JQmg/h3R1Q/7Tsx8mYH2DbiqX3Fhnm
 GrE7w+K3hcTqbpJ7iOP4Bo1k1CdkTbTiReSGMj1kGVhvnFuJahci7ysh4naTJr0ejoKGLk6/N+g
 kq4surZrTg/DaDYHBaoFahvq8JQjMvenFXQN1wWFDjbMKMPeQTnUehDVfJJNMDuhwfLwpxaK/wJ
 YVZw0LUkpg8mawCjea7yu3k08j9PeiEclieypKXCObz6J+p5bMsLctaapWEhVIW1PUbNkebn38w
 pPeHL5rAUmIUTtp7NXHvF36b2NwGhn8PDm7BBxQ3JTUhwiA8rScF3Ck8vLjcDQuky89i88rNmtC
 gkT/HnAhemL4QA6IABQ702o7+gWQ6n7h7l5kMKteQTh3zw6x0u5a2FH4xEHqhTkp/Q2AB3Tgp5T
 1lcbOx7iLsV7zHwSrTkAHsY7QeL8S4r/TZ2K0fxd9/fEnSOMmOwlozDeJ6MZ5JsKEBHimlm31sX
 MbYtd1mmzQGdHVCRXiN8gze9J5GkLx3LmKyOAc3amh9gv5F7LYeEsc6M7Jj5Umgmf0LPTy/nMPD
 PWnHgUcj5zxK+Czb6oxhJmQupJY1K18MB+PA4bdwey2pZWIoX2S7OEznFrTa
X-Received: by 2002:adf:f8c2:0:b0:48d:fbf4:895e with SMTP id
 ffacd0b85a97d-48e07fb31demr7921992f8f.11.1792391840519; 
 Sun, 18 Oct 2026 23:37:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4fe9d9sm19959642f8f.40.2026.10.18.23.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:37:19 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 06:37:18 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: ae129436e9cf54ad395798a24ed7fbb13a15708a
X-Gerrit-Comment-Date: Mon, 19 Oct 2026 06:37:18 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5259f394f430bec75fa0c45c61b670a5f3934893-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIgzv-0005es-Ep
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 P_CONTROL_OOB_V1 and the probe request and reply TLVs
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3477405791733999046=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3477405791733999046==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lgHfPU8mEmM="; charset=UTF-8

--lgHfPU8mEmM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici=2E

chugly has posted comments on this change by Lev St=
ipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

=
Change subject: oob: Add P_CONTROL_OOB_V1 and the probe request and reply T=
LVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 21:

(6 comments)

File src/openvpn/oob=2Eh:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/40e53d39_3d7df312?usp=3Demail :
PS21, Line =
40: #include "session_id=2Eh"
session_id=2Eh doesn't seem to be used=2E


h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/3c48c8e6_fa76c30d?us=
p=3Demail :
PS21, Line 57:     uint64_t timestamp;  /**< client clock as a =
UNIX timestamp */
What is the timestamp used for? The reply doesn't echo it=
, so the client can't get an RTT from the reply alone=2E Is it for the serv=
er, e=2Eg=2E replay or skew checks? If so, worth a line here=2E


https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/2035f108_d087efc5?usp=3Demai=
l :
PS21, Line 58:     uint32_t flags;      /**< client capability flags, c=
urrently must be 0 */
oob_probe_request_read() doesn't check this=2E If the=
 intent is "send 0, ignore unknown bits on receive", maybe say that, since =
rejecting non-zero would make adding flags later harder=2E


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/cfb71fcf_77406b58?usp=3Demail :
P=
S21, Line 69:     uint16_t connect_lifetime; /**< seconds the reply stays v=
alid as the handshake reset */
I don't understand "stays valid as the hands=
hake reset"=2E Is this how long the client may reuse the reply before probi=
ng again, or how long it has to send its hard reset after the reply?


File=
 src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comm=
ent/318898e6_505aa142?usp=3Demail :
PS21, Line 3712:         msg(D_TLS_ERRO=
RS, "TLS Error: unknown opcode received from %s op=3D%d",
Opcode 12 is defi=
ned now, so "unknown opcode" is a bit misleading in the log=2E Maybe a sepa=
rate message for OOB arriving here=2E


File src/openvpn/ssl_pkt=2Eh:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/21aa5dad_11e20135?usp=
=3Demail :
PS21, Line 62:  * control channel: no control message id and no =
ACK array, just TLVs
"just TLVs after the session id": is this wrapped by t=
ls-auth/tls-crypt like the other control packets, or sent in the clear? Pro=
bably for the follow-up, but the wire format should be pinned down somewher=
e (the protocol RFC draft?)=2E



-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Numbe=
r: 1741
Gerrit-PatchSet: 21
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici=
 <ralf@mandelbit=2Ecom>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <l=
stipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Mon, 19 Oct 2026 06:37:18 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No

--lgHfPU8mEmM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici=2E </p>
<p>chugly has posted comments on this change by Lev Stipakov=2E=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dema=
il">View Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/40e53d39_3d7df312?usp=3Demail">=
Patch Set #21, Line 40:</a> <code style=3D"font-family:monospace,monospace"=
>#include &quot;session_id=2Eh&quot;</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">session_id=2Eh doesn&#39;t =
seem to be used=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1741/comment/3c48c8e6_fa76c30d?usp=3Demail">Patch Set #21, Line 5=
7:</a> <code style=3D"font-family:monospace,monospace">    uint64_t timesta=
mp;  /**&lt; client clock as a UNIX timestamp */</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">What is the tim=
estamp used for? The reply doesn&#39;t echo it, so the client can&#39;t get=
 an RTT from the reply alone=2E Is it for the server, e=2Eg=2E replay or sk=
ew checks? If so, worth a line here=2E</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/2035f108_d087efc5?usp=3Demail">P=
atch Set #21, Line 58:</a> <code style=3D"font-family:monospace,monospace">=
    uint32_t flags;      /**&lt; client capability flags, currently must be=
 0 */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">oob_probe_request_read() doesn&#39;t check this=2E If the =
intent is &quot;send 0, ignore unknown bits on receive&quot;, maybe say tha=
t, since rejecting non-zero would make adding flags later harder=2E</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/cfb=
71fcf_77406b58?usp=3Demail">Patch Set #21, Line 69:</a> <code style=3D"font=
-family:monospace,monospace">    uint16_t connect_lifetime; /**&lt; seconds=
 the reply stays valid as the handshake reset */</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t und=
erstand &quot;stays valid as the handshake reset&quot;=2E Is this how long =
the client may reuse the reply before probing again, or how long it has to =
send its hard reset after the reply?</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741/comment/318898e6_505aa142?usp=3Demail">Patch Set #21, Line 3712:</a> =
<code style=3D"font-family:monospace,monospace">        msg(D_TLS_ERRORS, &=
quot;TLS Error: unknown opcode received from %s op=3D%d&quot;,</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">O=
pcode 12 is defined now, so &quot;unknown opcode&quot; is a bit misleading =
in the log=2E Maybe a separate message for OOB arriving here=2E</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt=2Eh=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/21aa5dad_11e20135?usp=3Demail"=
>Patch Set #21, Line 62:</a> <code style=3D"font-family:monospace,monospace=
"> * control channel: no control message id and no ACK array, just TLVs</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">&quot;just TLVs after the session id&quot;: is this wrapped by tls-=
auth/tls-crypt like the other control packets, or sent in the clear? Probab=
ly for the follow-up, but the wire format should be pinned down somewhere (=
the protocol RFC draft?)=2E</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 17=
41</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipa=
kov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Mon, 19 Oct 2026 06:37:18 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: No </div>

</body></html>
--lgHfPU8mEmM=--


--===============3477405791733999046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3477405791733999046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3477405791733999046==--

