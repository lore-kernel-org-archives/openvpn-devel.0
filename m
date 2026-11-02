Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEDB606E033
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aOF1OiC2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DLYcrr7S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gqG8Qt1m;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UeJq7Oux
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VZ7WnLtc8sl4NNZ8wPCzuDDxjHGI+wozHADE7dxG4pM=; b=aOF1OiC2hwZ6rw7GyDKHuwnihj
	6RothxboNHPtMiOyFdKhaEVZoLmYD6QigtlxQPt1QsS7wyLl9TKrEj6FTHpbsjgq79J5ANLEyRhdb
	GR3riV46Xh0En6xIJM49qRmIhnUJ5MDe8QYw7ShxhiAKhadg9TWt5QUwqU/nTuSNRI2I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNuJy-000000006Nb-1jDL;
	Mon, 02 Nov 2026 15:51:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNuJw-000000006NU-0K7Q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mWDixCrqY6caYGwxscAHkQmTQKrnNuPUJdLJNpO4P4k=; b=DLYcrr7S63XNJtdF/ERiHhGLlW
 Uz5f2Q+0jZIPJUs2R9h3HJSBQ6ARqP3vNJFBYz0wWa5SyFbM+a8Tdp/0JjaQkG/Y0P0qkNuLQNqIc
 KZxiXVBR4sRdpKGBiyVL29cURPn6SeXW9mmMh2MnO9WK0P/AlscAFjuCNqnxcuFFuWd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mWDixCrqY6caYGwxscAHkQmTQKrnNuPUJdLJNpO4P4k=; b=gqG8Qt1mY/LteCmL6yYiViu36Z
 rDY9yVnpAlxbEfaLA7cvTC5JdPpdatx1djHc+J6wzVEfHIpx2zfRhDmdqfTMxgvctaq0I7Z5OSiZb
 PZDjN8ObRR4RKZlsC5T6Yr8PZDzhBtvnAI/SKZZQPWL5a4VeO4m/1LtmRJ63UuIVnaqM=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNuJt-0000000045F-3nax for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:51:40 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so2830427f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793634691; x=1794239491; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mWDixCrqY6caYGwxscAHkQmTQKrnNuPUJdLJNpO4P4k=;
 b=UeJq7OuxpKn112gBWv/70C/yfMPpjtr7z4hQWnHaqXpitwx1dfvAif9XIOYifYoNxx
 m2Gr2P6ix+P+tTO5mA2+L59IdNXs0aJ+2QkCMPHryZEY2r6sGoMt+Q5i8YTNFXugl60K
 T66M0fOFY4SkhxZvzQ6jHB66nOoP3VqP7KNnTjKHdM1Slxs6XuOnpU7X3JYBmOpDcLNB
 IOvBrfe62iRYZBJ8ixQmO9k85Es2ABQgcPhZBaaBbMgEh6R5l5LfXGxp0N/ctsaL0/c1
 fxXFOyjKU+95y4iNmo4WLiIKG4QEl2XclFBzUlD34znW3lQf6yFkvFvq68A/NR4LRhEZ
 SMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634691; x=1794239491;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mWDixCrqY6caYGwxscAHkQmTQKrnNuPUJdLJNpO4P4k=;
 b=oUqssIQFCz7TjiVh7NIi6Y2UXTgmNQHi8mqW2deEdj0WWg14CZYpVKHFcNfDi0pvr9
 UZwexvNtHCQwZyLpYTs4IykrqS484jcw0GYNTJMQzWaUrcDbq8zycSbPKDD6nsLVBEyo
 /dV8p7hIL1doBsLBhbL5Q+FSrDv8OozlyZzVh2+vvpia7tReyIQ3PwHUkghoyRxxQ7xS
 UJqq+9tsO8Ew1veTDzWoBjiDyiy9AR321zcDctGs++eQeQBcBdkmo5LyWC0F6B0vUec3
 /gthGzXb13rPf4/CNL+eyefh/7yRNpTvb4NykmQidy2BKzD/Rnrr4rkS9wMx/BSi3/Dy
 c1zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzP7SGOJo2jqYVMzvmgHW5//ZtoLu1w1k0YoglZX+aQD/XKse3XPN7gqMigmMt1wuNeeKP3lblEziLbtfpW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9XPXESGPqJmzlEQJCiGk6mkG/HBhnIZWXgGS2pe07sLu23+kDI
 iMTHKCEsEPwrnEijUu6DzUgH7Wd5Zfbi/B0O0hKOcS4cJK9iJPWv2H0X9VOeNVXOG2LB/OZ+Jxh
 SCwfAu9gn8GPfS62nxZaIi7W4A0W7wV1mPvZ3+BrzKC3UrkN4CkhaR/mcWQg6Rlce+QFu
X-Gm-Gg: AYBFou1kSsCSoiB/gQlH+IOauU6F6AcxhIRyrDCyFztoGxT0D25lny2Y7GHFBNY+JQf
 GNaAbeXc43Xg/wj+i1S10/Md7N4/bPkCoUy185CsfEq8ioht2IOBBkeksBh4f5Qq+PD9TLeoek4
 +74A0GdnkHbuj0rdF/1RTGby1mIxSsQP+Ks9R8W6lQ96G8VRjQdXasC5sSz3PHK2tEZsIo/ZC7+
 cqi0tc/2eIFCOLmXmq458hQ/H7s3+kv1WJ5cord3ZvEA19liKFLANizr5SPPCqH8xTsW+bZksMs
 26D9a54/CkZ1gETeLsUW+czlIg9v6H4HKPv0OdFTA+sqSJ3PYjjtsp1qpWq8ZV1Pn0fpTIOqjAi
 qShPjhkCGgZZ6Hq3/wc7zFATfg1o82vtbTTYlA+1baYhPjNWzgO4TcJgUQNH8e9xw9gu8Fh53Xz
 RG9bEWkZ7M3JVb6nZA8gQWWhLd+FzeOM6C/7QV7JFzDRIrXu/wjTICubOfn2VSJDRcqucBP9lMG
 KkMPY/ajoKqTFpTAVSvE5G88xRbIoXD5YvkW2dvjFgMZF+YFZ51L4b57kVYbzTnV9vlVTdRx0yn
 im8WMOoDNi8ylxHrigfKWHMGlg7/cBUyDxHCvIsQw1KADGENmSAusOloK7cwqShFqNTVK1RcJJ/
 dvG7449n/HEKDMsuVqbHmxUXurzxejES9vYeMafiH76gNt6Hgq+wzDDq3eSGGDJeCyY2D7lwTuo
 IrHmmcsW9RnUqedg==
X-Received: by 2002:a05:6000:2c03:b0:48e:3ebc:d242 with SMTP id
 ffacd0b85a97d-48e6e4ff743mr21013487f8f.37.1793634690108; 
 Mon, 02 Nov 2026 07:51:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b959c1sm20348078f8f.45.2026.11.02.07.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:51:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 15:51:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 168d741a412fe24413fcf382db0800a6ab23c95a
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 15:51:25 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7596cade7231143f379459dd7c90c1dd1ef57dbc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNuJt-0000000045F-3nax
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3188814022375633693=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3188814022375633693==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dELA3bUaNl8="; charset=UTF-8

--dELA3bUaNl8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(6 comments)

Patchset:

P=
S4: 
Do we want to document --allow-deprecated-insecure-static-crypto as re=
moved in unsupported-options=2Erst?

Also, a recursive grep in `doc/` finds=
 references to static-key mode, but I'm not sure if you want to remove thos=
e, or if you do, if that is for this patch=2E


File src/openvpn/options=2E=
c:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/714bf9a8_e33178=
da?usp=3Demail :
PS4, Line 2016:     if (options->tls_server + options->tls=
_client + options->test_crypto !=3D 1)
Since we know that `options->test_cr=
ypto` is always zero here, we can drop it from the `if()`=2E


https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/cf50b019_e22754bf?usp=3Demail :=

PS4, Line 2038: 
This now ends up as double blank lines=2E


File tests/un=
it_tests/openvpn/test_crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2081/comment/5273dc8a_419c3fe2?usp=3Demail :
PS4, Line 344:     /* No cr=
ypto at all */
This is now the same test as "auth none, cipher none"=2E We =
might drop one of them=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081=
/comment/2fbe1351_4c951cb1?usp=3Demail :
PS4, Line 361:     /* secret, ciph=
er AES-128-CBC, auth none */
Leftover comment?


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081/comment/81a515f3_4b35be73?usp=3Demail :
PS4, Line 3=
92:     for (int i =3D 990; i <=3D 1010; i++)
Should this loop go to 1015 a=
s well?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
81?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icadbee50=
a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change-Number: 2081
Gerrit-PatchSet=
: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Mon, 02 Nov 2026 15:51:25 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--dELA3bUaNl8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 4:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">Vie=
w Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2081?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do we w=
ant to document --allow-deprecated-insecure-static-crypto as removed in uns=
upported-options=2Erst?</p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Also, a recursive grep in `doc/` finds referenc=
es to static-key mode, but I&#39;m not sure if you want to remove those, or=
 if you do, if that is for this patch=2E</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2081/comment/714bf9a8_e33178da?usp=3Demail">Patch Set #4, Line 201=
6:</a> <code style=3D"font-family:monospace,monospace">    if (options-&gt;=
tls_server + options-&gt;tls_client + options-&gt;test_crypto !=3D 1)</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Since we know that `options-&gt;test_crypto` is always zero here, we =
can drop it from the `if()`=2E</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081/comment/cf50b019_e22754bf?usp=3Demail">Patch Set=
 #4, Line 2038:</a> <code style=3D"font-family:monospace,monospace"></code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">This now ends up as double blank lines=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_crypto=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/5273dc8a_419c3fe2?usp=3Demail=
">Patch Set #4, Line 344:</a> <code style=3D"font-family:monospace,monospac=
e">    /* No crypto at all */</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">This is now the same test as &quot=
;auth none, cipher none&quot;=2E We might drop one of them=2E</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/2fbe1351_=
4c951cb1?usp=3Demail">Patch Set #4, Line 361:</a> <code style=3D"font-famil=
y:monospace,monospace">    /* secret, cipher AES-128-CBC, auth none */</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Leftover comment?</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2081/comment/81a515f3_4b35be73?usp=3Demail">Patch Set #4, L=
ine 392:</a> <code style=3D"font-family:monospace,monospace">    for (int i=
 =3D 990; i &lt;=3D 1010; i++)</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Should this loop go to 1015 as we=
ll?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0f2069=
f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 No=
v 2026 15:51:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

<=
/body></html>
--dELA3bUaNl8=--


--===============3188814022375633693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3188814022375633693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3188814022375633693==--

