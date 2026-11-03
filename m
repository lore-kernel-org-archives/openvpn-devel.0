Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB447606A32D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TndGOtJh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QBuzROGV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EHjExXOP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qk9M1Go9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sZnyx+8foyHXtNahFxafKtXuZvoVIwn/1iSORcbhzus=; b=TndGOtJhE/DDLdQ7YZQYvgTI1i
	xSbcx7tus+CAwrY13EQy4+N43qeF4l1PJ7390J907KKh/aKzFaDiWclWJ1HzYi9inBLGcv+g745XH
	6WB1ca2QDPRcWKFvjTQtEsh/1Nndv2TVCPJV5d6tnn2wTOGHL8mpKxgf/Fl622AMaJWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOAM2-000000001CR-3bAu;
	Tue, 03 Nov 2026 08:58:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOAM1-000000001AL-49PC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/A9n4h4LdzOG7OktoBKzS52OXGo45Puq11kefD6/sbY=; b=QBuzROGVQL/h5Ha6FSNn9rDylN
 JROqWVLqeY87Ud9w+FG6TAdYhY/d+BvOoDBu3z3c0jgrFx3mI8c+4jrG4ulrhCSpL501j8VnaGNre
 XvGVkkTcubaQoSeNF0ojPqGw6gk63RZsGgpzboAVWNpmLcBDcaJQd5MgbRm0Nqf9e4vo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/A9n4h4LdzOG7OktoBKzS52OXGo45Puq11kefD6/sbY=; b=EHjExXOPWUzstgMuBOLvf26k6b
 v9S/ADD+u3LJ6lMXTg4UChrF+n5xpzs6iI/1GnXt7JCWIZCnDv8/s+Lg9XJK2JOzTI7Eih9JlK/RD
 Tym+zRhWMUn4t7swVB1Dsjwro/dPw8BooubPvDYW736CIJFGOhG7zNsb8WAXg6NPYHqk=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOALk-00000000670-006e for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:58:37 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2320940f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793696309; x=1794301109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/A9n4h4LdzOG7OktoBKzS52OXGo45Puq11kefD6/sbY=;
 b=Qk9M1Go93TvHfuKWirZxuKmfWFvAJTOVQ++XKd7Ql8mdxQrv00FCDx+fM1sXeJRhk8
 5KkWL7rNX4I2lMjXZtwn6FHdoY0uS4mWktv5TSBB73mg6w+08HyZGuZprbFl8QK14jHV
 g3hcTIPRCSiTSXkEY401sUniznd9uSuxtF34hx8mtaT2d5gRRQGJDcvtMIAq05Edc9+Q
 eK0lLaPq5yzE3qUd0nNwCiIpCUEEbmY/iaVVP1z2yzN+cuWgXn5cLPEQTYsA6F945NJc
 ZYzONeHyh3VkcPxFHpe1Ter153Vzt1rpiy+E2AV7i1EfMjWkUhzmMTVGuistuONRmD9K
 ACCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696309; x=1794301109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/A9n4h4LdzOG7OktoBKzS52OXGo45Puq11kefD6/sbY=;
 b=1lYhtOc0re4kMXtIaI9QYtWR01PLZBYaWkpmA8ovyNS4aF26xdVsYNp/CoV5CYVQu9
 8Bf2npnbdkQRfE2jZe8dpO3q9EXlsEcwjdGtpYfyKGcIb0g3iBIyQwUcNyKBn3RHe09w
 rWzYdinlHgUn+UW6GX7+c1lberrghFPpzo6W17AUOdMgX/G6wPGCot+Bd3fXa9bj3a8i
 BX1vZA7Og2U8+O6FCm1kUdy4UsysBiAkM8BCSSLSi3jjlzUUnuImMwNIoG0y8+xm6Pq/
 RhkMFFc9WWp2NCDQOMePzaoYSXRnggLWQdVPoVecmpDBgLabBI7tnONP5asVV1jtcgOQ
 DBNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7DNiZfZPRlz9x14uK+zIecK2L/xbrjF+osmGH6GNp9NjCMS64T0gcKxYB+pp/YMlMSZNz7vZEQSRJ445T@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+IgVUp3GebmUQTszDVO6jo6byK4eC52cQ6c84D1kMmGKF1fUu6
 4+nH8vhJq4nTQTYC7u8LPwgclCKOZf9u44FMLkXcj9N/05GurOjt6RreQdoWZe91vhbfrdfRXHb
 LFCOliG7vsiSj336WEI9rA1qk3q/gy5Rcbc4jo9n7yOJdU73vs/iFOc+YYH15Dz7+FHud
X-Gm-Gg: AYBFou3bU3T65jpQBz9LjOYFgP70LROkeJ35A5T2LP8cEXeA9Gf7828eO5JCnY7FpXV
 In1oJcyfVGU+tEyF4OSrBrm+Cq+nP/rq1Uu0QWmKT8NRjNXkpjSHdnuBmW7glB0QD6PlWjmzCqU
 pt46LE8Y37fJzz8BYpwofl3nju8tJz0baNUR+AYInDNBx5tvGDDs8q/jn89JFVcrOCHTdgnfnJe
 w28jOujFkozmeqVkr5Sed5FpKenOxpjPMmCZ07WUxyeac5yMoSJt7rgHBOjTTtEYZQbUWuGVeYT
 OXC+NGHlhgPb2YM2CBd7ufQsMNi19QUttUzEAwZrvyCS5o73C+GgUVQ7KF0Jqv7O7kPaHHNXt7c
 SDtZj8VPlaa/feRrTtC56QVN/DQr0bY9PDfMLsZ0qeIDr5bM/wT3xYI5SRUq+OC5qXdNE9kD2JK
 98evWKbfIXDWs9Y9IfiuEX+nD4SgnQZIqWjfDAk+oj8C6HkU20Db1Z9YY2qJ8+sMytlb1xMFMBH
 ql7DsSEDY7xbD+Lg3va8nXls0Zg7Q4IBElMu9uuu9WFkCWAtuD6Cpp4JCFCngpcMcEAKqJAHQAn
 BQYQnuPe0aOoeTeLjoiUp/PoyP3Bxt3IxOnEP+4dj2TrQMTBiOz5PXbcEPeqgnRfw9Q5HVF0Ugp
 pkWWiKc5C+caLZfG2kOBqrpWxkrBNGbd5E80pc45XGN7wxaYYoqlEfjXa2YZluLmIN7NI40wF3M
 vFkvYQQgY9gWED6w==
X-Received: by 2002:a05:6000:41d1:b0:48e:720a:ccaf with SMTP id
 ffacd0b85a97d-48e720acf66mr22817219f8f.5.1793696309199; 
 Tue, 03 Nov 2026 00:58:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80eb1sm25294118f8f.34.2026.11.03.00.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:58:15 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:58:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: 5219cd07ee23243dbc5ed986ad78aab34458435b
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 08:58:13 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c563b4fd77f9638c142b7d9e0bb52c291a50aba4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOALk-00000000670-006e
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5171975650864990111=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5171975650864990111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NhsWh+wyjS8="; charset=UTF-8

--NhsWh+wyjS8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gianmarco De Gregori has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpn/mudp=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2046/comment/a54930dd_52a113e8?usp=3Demail :
PS1, Li=
ne 489:         multi_process_outgoing_link(m, mpp_flags);
> This used to d=
o nothing if `m->pending` was `NULL`=2E [=E2=80=A6]
Thanks for spotting thi=
s=2E I added a part to this patch to handle exactly this
case, TA_SOCKET_WR=
ITE no longer falls back to the bcast/c2c queue, and
the drain extracts the=
 queued packets itself with multi_get_queue()=2E



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
G=
errit-Change-Number: 2046
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gre=
gori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 03 No=
v 2026 08:58:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment=
-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--NhsWh+wyjS8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gianmar=
co De Gregori has posted comments on this change by Gianmarco De Gregori=2E=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Dema=
il">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/a54930dd_52a113e8?usp=3Demail">=
Patch Set #1, Line 489:</a> <code style=3D"font-family:monospace,monospace"=
>        multi_process_outgoing_link(m, mpp_flags);</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">T=
his used to do nothing if `m-&gt;pending` was `NULL`=2E [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Thanks for spotting this=2E I added a part to this patch to handl=
e exactly this<br>case, TA_SOCKET_WRITE no longer falls back to the bcast/c=
2c queue, and<br>the drain extracts the queued packets itself with multi_ge=
t_queue()=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail">change 2046</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c379210=
4101cb2e828be3b7fd8f44156 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianma=
rco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Tue, 03 Nov 2026 08:58:13 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--NhsWh+wyjS8=--


--===============5171975650864990111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5171975650864990111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5171975650864990111==--

