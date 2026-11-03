Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729F606D835
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nTE3vrnX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hdVWEDFG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PWWX1L+X;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=e2XQSgCp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=44QDKuOYLohvVnQGTnILHdrdEoZiHDpG+xLmomawGZQ=; b=nTE3vrnXdbRMEF06e9DruJoXkB
	t+eOzMFt+a2lX3+AgmgWEYcvHEHL+gyhSqMQO2IDuZuJiHdwGdwsFDhUyCR7Yh+nCSDxnGxYUWZ4E
	nUmSW7rq3zkcKJiO8bNRXCdwF7Ub6R2j/qe49HyVtwPuOt++ZzMLwocbnTsDQFrXqO2I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOF5v-000000005RQ-3BNv;
	Tue, 03 Nov 2026 14:02:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOF5u-000000005RK-44Hq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:02:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VIflAZNw7EWJDlaXX7+sveQ/9pABExcW+dGRDzj4Rw=; b=hdVWEDFGXwK8A4ksHnEUeWDwno
 Y+H56MYFBCYBYzx3E2rFRqS6X1JAVbek9Z0fuvoGJPrYqSbizQ3wUc/YOtoWleutwvfmUJhhlb/n6
 jr2ylZKdBCu4rBj/c3M6Y1SeivlEtqnRAWjTQJREaTAOOAsDwmbvrzMm8WXGzUlWQ2Bk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VIflAZNw7EWJDlaXX7+sveQ/9pABExcW+dGRDzj4Rw=; b=PWWX1L+XksImLR4DM3BiQOBjS+
 JpoOHB+kysG/4M7s6dBGl94V0okyFkhYedL3zwqFhTpxLTZ1n4Crsvfix/S7RjZ226Hr18o/0LtK2
 C47TuzqP44FmlNA4i/cji2V6/ofrvUkbLIpnRljKMz8fWa4qOwfmV2oIwodnNpG4vRn8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOF5t-000000004EN-1Mrk for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:02:34 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so496519f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793714547; x=1794319347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2VIflAZNw7EWJDlaXX7+sveQ/9pABExcW+dGRDzj4Rw=;
 b=e2XQSgCp6h057L9i+qSOpsNchdQ/E4zuXbg96YfTG8p4+ppRTLANHclvgD3FqaZ8fY
 gZh2gJPSM9u2UN8ZYJUoGgGG7bAh59xTcRJIZjmziDtQznlrkpCPjN+XWIW92JFNO4nH
 l6YhVipisEWqI2SwAhtb4JE+SjIg0hOdjUHn3yTwvyZrFz1d9jI0AYQw1QJ7qsMSXJR1
 cRq9ktq2Fysn7y0xSmkwyAbPiA4W7j1wQtbDxHCMjY/fkT1DBKnQFY2qrbpJYqyAqojO
 9IdzZaUsFKFP7qmwJ5V3BVTrStYAP6GgFGoaVbMNHDqgOs1YLJ8v6G5/x2NecmuqSTc2
 168g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793714547; x=1794319347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2VIflAZNw7EWJDlaXX7+sveQ/9pABExcW+dGRDzj4Rw=;
 b=wDmI7JxaG60yhMLwc3O9YGbZ8E4GwWcYnW5/o+ZbeuhmOX6lvloD+WE419YH9GX85a
 lV9pGArtO+FvAaSs+GgmmtksvRA3fO/zkxZeemJdXyft4CTLUnzwCRZRalGGbwOkoMU4
 Krhotq+ruZTNV2I8WPNJzqAKBFRZxpG8in2SydGoLQD3MXhNK1wKASFPZHQ6rHDZg936
 X8NUCVIAHFFMnOoirkbhRx1aLLuFnVgadsIaEzLhLsG7Q/BcI/3UpgRQisnr5/JgId49
 QsRB5r7dMj4HIPs09MHh6qDM3/fixfDc0c1a9lJSWpitsb0Fv6ZlsmaSBz9o+e5odQAB
 wBSQ==
X-Gm-Message-State: APuU4Z89aTJ4ptrLCZyIO4vMvlImfVSW72xvpsggVpRbywd2zRi3DR8O
 tHHSUEgc2vK2f3tQ74Bau8y4EX+vupquqB+4wJWv20fv3WNDBUbnh3Gl8rc2jC5o1B+v3oPo9aH
 lqdqNo2OyokbNeNb8XLQLLYvi6IoHLALzsrYwD/eF170vCaDh8XqDhU6lLlRBEuyaXaZa383GHT
 ajZBrzqg==
X-Gm-Gg: AYBFou0G7yWj+lW9trvEngulMtH7LAafYJPUK0nU1eV0UvyC3TQWrLTGfakSA14aEbZ
 2qJOpR6hSRTOYZaWmS/fx0JzQ11uAuQU5tFjRMnrKK/lSe9qmZ0NLT5FTzgaLH/zCISeSPXQuQB
 4s6b1uwzMzEoGEOUVpxYfzWWfUzqke7m9DtPXgQ9FRdpbqhGoloYYLPyuZRHnAZn+JLTOW8mEVK
 mKN3sM/h7d2Ow+LSw2dkhtogHRhrzhhhiTfsH3hqcs41wPvx1xeyYtDpi12KdrO84RgPK42MtBO
 OFcDVMJj65HS2x1JDss7aMjRTKmqzPKarUQc0fAMjidH88xxSzbTl23fzknzvtYkwzyptsipC2/
 ArAzukpV9zp8aF47+kU7IQ8noUNzxYfzqi9kaTATx+nk+hRvXo1XfJkP/230P/XZQfhJfLdVNH1
 hQifu8u8Y3ZZpO9dBn82qC5Aoa0MwK45VYtM7p1AfYIha/gxEu2aybEPkflxpZvTYklfyIEIRW9
 4IwpmF4j8sSLzrPK5Jo9iFD9C2B3HKfyo6yDRSLXdLa5VePG+UP+aPd55yqjUkmWEJSE+vJufhS
 yyrly4E2cA7WCcrWJv1txtocG5uzJegIT/nFtnN3eG9vXYoEJrnSoUcKRUuXhyXAbYC1tspUjLt
 kyitvBQOMH0g2QJtjYZVVXASDENp2b3y6+pwvnKj1hBFgCPljXdybSnBZKNfi1u2yNTv7gT9+iK
 u57CyryjZ5PqQKOhQ=
X-Received: by 2002:a05:6000:4910:b0:48c:69b3:6114 with SMTP id
 ffacd0b85a97d-48e6494c24fmr42429244f8f.3.1793714546470; 
 Tue, 03 Nov 2026 06:02:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm26997366f8f.55.2026.11.03.06.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:02:24 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 14:02:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 62f2e92139f2da7f4d5d29f94c3a4d995ff56e41
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 14:02:23 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c1facf6225d61b20629a9caf9e569f721c15dfa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOF5t-000000004EN-1Mrk
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4038701060165894755=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4038701060165894755==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eM/zGdsECzY="; charset=UTF-8

--eM/zGdsECzY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the mangement interface
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(3 comment=
s)

File sample/management/omi_client_protocol=2Epy:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1859/comment/e3dc6bcb_61804468?usp=3Demail :
PS5, Lin=
e 52:             logger=2Eerror(f"Error: trying to send ACC message with p=
rotocol {protocol} is not in the negotiated list of protocols ({self=2E_acc=
_negotiated_protocols})")
> Should we have return here?
Done


File sample/=
management/omi_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1859/comment/21bea54c_a988959e?usp=3Demail :
PS5, Line 285:     print(f"M=
anagement interface version: {management_version}")
> Mix of logger and pri=
nt, should be logger
Done


File sample/management/omi_tools=2Epy:

https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/2246fa11_c3fd16cd?usp=3Dem=
ail :
PS5, Line 27: from omi import OmiProtocol, ConnectionProperties
> Lik=
e other files -  missing typing
Done



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
Gerrit-Chan=
ge-Number: 1859
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of =
user not set #1000061
Gerrit-Comment-Date: Tue, 03 Nov 2026 14:02:23 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Name of =
user not set #1000061

--eM/zGdsECzY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></=
p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi_client_protocol=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/e3dc6bcb_61804468?usp=3De=
mail">Patch Set #5, Line 52:</a> <code style=3D"font-family:monospace,monos=
pace">            logger=2Eerror(f&quot;Error: trying to send ACC message w=
ith protocol {protocol} is not in the negotiated list of protocols ({self=
=2E_acc_negotiated_protocols})&quot;)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should we have =
return here?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File sample/management/omi_server_demo=2Epy:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/21bea54c_a988959e?usp=3Demail">Patch Set #5=
, Line 285:</a> <code style=3D"font-family:monospace,monospace">    print(f=
&quot;Management interface version: {management_version}&quot;)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Mix of logger and print, should be logger</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/manag=
ement/omi_tools=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/2246fa11_c=
3fd16cd?usp=3Demail">Patch Set #5, Line 27:</a> <code style=3D"font-family:=
monospace,monospace">from omi import OmiProtocol, ConnectionProperties</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Like other files -  missing typing</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c=
86a450c73228a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 18=
59 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user not set #=
1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Name of user not set #1000061 </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 14:02:23 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: Name of user not set #1000061 </div>

</body></html>
--eM/zGdsECzY=--


--===============4038701060165894755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4038701060165894755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4038701060165894755==--

