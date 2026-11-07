Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1C606A326
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LeFMkUcr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SkIObL52;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b1MKH5GN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P2cDC5Lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o4J7BPuYWVuJNUbPoyycBDFC6GFlP4rOMIVMnX6gQEs=; b=LeFMkUcrqd7kVUladFNUwci+CJ
	AN2wM+lpPo2+V2mc2qHjWMyneejEsIiW7QYzxneK7wp0mVVszN8kTA3yjZ7JdXfA5rEA7Ckjzx8IS
	IAYUUmL8E0Rt7useO8ioUK/bTbFBX/yzTRsjxRY/e/UtdORFPKpcUKMyxE+jFDsvBptE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPjwW-000000003vf-0fn3;
	Sat, 07 Nov 2026 17:11:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPjwT-000000003vP-2j7Y
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 17:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/MLpQMQsUaKGez5gFV6ssMMR5lrctL7aY++Cmk61fcM=; b=SkIObL52QjTrVcR7hTiH0k+zb+
 +wX0Lezh28rkY533JMZeGUjM3Zw2UitdstGqVTGsJKevpqQZHIeX9+lUzn4V8SbHvAU/5sKzVp68F
 v3d5MQDkPtTTdkjWLfRRa0MdeQ/ohw/Z/G0YiBedyhrisXlrIvXrK0sjv++Ao4G6udSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/MLpQMQsUaKGez5gFV6ssMMR5lrctL7aY++Cmk61fcM=; b=b1MKH5GNUkskasULJHFS7uQVPv
 kON0uzagrb0HlPlzFleK3qa+dwDlVAZnbHT3JUdt/+SDIeHl3D2Q9VJGp4R9ibYDpQEO/94KWeVpS
 ZcBhdNVkYWftIlj9oFqn/8ftuZqLt77G/9IhlmwxJlNOmU7gHOoqKEfZB4olx9E5k+VQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPjwS-000000002we-238P for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 17:11:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so12814885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794071454; x=1794676254; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/MLpQMQsUaKGez5gFV6ssMMR5lrctL7aY++Cmk61fcM=;
 b=P2cDC5LtLau3vzDUdP+2YyLFe12K/HsRJ2kDL7d72ssbyZQpXxHbTm0KijaND74bMy
 dJxe8+pIJMyBF1MIdPOidNqyDZcRb3wZK51A1TfzF94AOI4v0JOeB//o9RyW8aT7tCMA
 +nYswXGxUAas/b567mgn9rYBYVrJ8nx04bDzlC4p+kE3ENwHoCLnt9OGoSurPqB7tD8A
 tUbqLAE6KdJythXo/X9S8Kmz8Hx6sLNlTbU0zpAdI2s0D8lWp57OqoP+nVlbTz7q38N4
 tur/OreguKad+bMbBUfZsYmks0m9cnYokX712kVJ88Mh/mYlclQSDs5tJPqdrcYgaONm
 /Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794071454; x=1794676254;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/MLpQMQsUaKGez5gFV6ssMMR5lrctL7aY++Cmk61fcM=;
 b=22NAqsQj0cqUxb8yoOArCEI9x2JZcypAqnYLsAC+erUTBe5JP8hIGuKPl/DOfejG1b
 WKI7e+/OhN0j7yjO6ULqW9sKWy++XZwuI9lcOUUwVC++ov2wtdHR5dtFUiDvptwZxkeK
 BYKYv5as7rrmPTY99P+MNLgp+ybDdFNY+DnbL+mFllvlq+nCBxyxQQrdHioEacbmytpL
 /WSyqhzKJ4qCkzinNBcLgQ3pGclqsIuK7y4L9XOD0fhBZMf+dgnF7UwTaU09Tm69kVJM
 nilUEwn3ztFHimpD8gBmmyTlpk2kR1GqLA798dQSHVXx1FF45WhkB/k5ACmDZ81IlXf9
 nvKw==
X-Forwarded-Encrypted: i=1;
 AKwUvByIawdGH8dtw3GsCb30tOts498tIsd/JSUpBNIe8dMqiMnMJaugCRZ9kkbgJO6LshBQFLBV8mrTioFdoh/0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ZHHyUd/J29V7t+Oo1anq5+LDa4L+l5gbsGgEvHdMXS9IGO0rG
 NDUa8mxmnCFBPzXtD7EVBHvxo/51LModmfg/YwMK5iFfw4ptPKDMn7VD+wxavBg+hGX2G//qYwa
 4raBnhziZq3eZnwiXdYxPlgDMCaij8VvWtdzt8ZIyL+pZN3RnOu+arPsPSRuxZqUc1T6gK73Wvp
 bMxVMX4A==
X-Gm-Gg: AYBFou3yYRBD4DqvYy3DXd6fGGAk8CVnRCKp/5yP2lePK682pm+6Ar3yW9PsrpRxSdN
 AwZQXliBxeR58vbb0hZhqLYjFEpWWSiyKs8rr6oVLLmXnFqKryxKUUoiCMoSPNZkfzfZLsc9544
 LYG9HmmiTB65y8ExS3CMBax/6vdJqtnc7ery8GBwLS+Va+ZudniRTspEU/KBh+nshh0VLs+OcyU
 iBg35bJUn5M+NBUaaFb9KNoE78DEDb8vK5Gh9xAjzmzywlPw//T1bkRwU5bxdawjDwdi/13lnvJ
 e6IT3IlHfdIyDIs8a2TtOyE+CiM9tmj5Fcgys1brNH9YuatAy8IgQ+OFRPxd7XVd4Q6wKU+qCr+
 rSn+Olb8BkLvRm8tIBbSLfJbkaZ/q7wSnOh3u6EMTFPleXHL+GmhQ/p7T3+AHxCXPCUE4zWOrqW
 yF5pZ1fXCVdldkkRvN1i265xG6gVs7MfG7G6pDsSnJPOes8q8KiiZ/lUpA0DHkzHZPH+8pBEwu9
 Q2Osxh77qaf36a7HUEXwhopH6AWiXoH5ybiYg8CTpxp8hZL+ULguVPzliJipmKEzAYkh/ZfIU2G
 pDn0Q+K/TpC8nUYPyUkheclR/ZNmrG29VFzSVLuX9JMY7Dk7mhzjpSTb6ghcekhnFMHPzhbVD2r
 WhjCrgvHUFLCjwOX7OjbWj9poyVNf57fscnM/j8YkY9Tp2UTzkGlxSZ5vW/U3V3rI/i0R6OVnmU
 P3h+WGBoW6Z+A3SIznu4PnVsbSS0sJfst2Yic=
X-Received: by 2002:a05:600c:6992:b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4b6de4a6c7amr100696195e9.16.1794071453818; 
 Sat, 07 Nov 2026 09:10:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7950206e3sm61576995e9.3.2026.11.07.09.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 09:10:53 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 17:10:52 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 589b59dd314e72affe07497b2172199f194e3347
X-Gerrit-Comment-Date: Sat, 7 Nov 2026 17:10:52 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4084760aef4f18565c47e484a7256f970de1fd9b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPjwS-000000002we-238P
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
Content-Type: multipart/mixed; boundary="===============1496869079049537208=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1496869079049537208==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WiEV9ofbxCY="; charset=UTF-8

--WiEV9ofbxCY=
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


Patch Set 1: Code-Rev=
iew-1

(4 comments)

Patchset:

PS1: 
Apart from comments below, in managem=
ent-notes=2Etxt, under OUTPUT_FORMAT no=2E (2), we say 'the last line will =
be "END"'=2E Add 'or "ERROR"' to it=2E


File doc/management-notes=2Etxt:

=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/5cc4461f_a8ffdb34?u=
sp=3Demail :
PS1, Line 631:      END
Describe the protocol in the both case=
s separately from examples? Like:

For management client versions < 7:

  p=
kcs11-id-count

The reply is ">PKCS11ID-COUNT:<count>"=2E

Example:

  pkcs=
11-id-count
  \>PKCS11ID-COUNT:5

For management client versions >=3D 7:

 =
 pkcs11-id-count

The reply is a decimal count followed by "END" on a line =
of its own=2E

Example:

  pkcs11-id-count
  5
  END


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2148/comment/c76c252a_87366f38?usp=3Demail :
PS1, Li=
ne 641: Example for client version < 7:
This section is confusing=2E Separa=
te client version < 7 and >=3D 7 cleanly and provide protocol description s=
eparately from examples?

For management client versions < 7:

  pkcs11-id-=
get <index>

=2E=2E desccribe legacy reply format=2E

Example:
=2E=2E=2E

F=
or management client versions >=3D 7:

  pkcs11-id-get <index>
  pkcs11-id-=
get <start> <end>
  pkcs11-id-get all

=2E=2E=2Eindex/range semantics, reco=
rd format, END/ERROR termination=2E=2E=2E

Examples:
=2E=2E=2E

Also no nee=
d to retain the original '<snip>' as that's not how other examples are writ=
ten=2E ID:'<id>', BLOB:'<blob>' is better=2E


File src/openvpn/manage=2Ec:=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/049a071a_702e63d8=
?usp=3Demail :
PS1, Line 918: 
Two helpers split a small parsing operation,=
 interpret the start argument twice, and mix parsing with bounds clamping=
=2E A poor abstraction=2E I don=E2=80=99t see sufficient maintenance benefi=
t from this=2E 
Better to leave remote-entry-get unchanged and use similar =
parsing logic here=2E
  
A better range parsing and validation could be a f=
ollow up=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2148?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09e5=
5085cde6dbc0040e111a42128527d59832b8
Gerrit-Change-Number: 2148
Gerrit-Patc=
hSet: 1
Gerrit-Owner: opidopiopi@gmail=2Ecom
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmai=
l=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: opidopiopi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 07 Nov 2026 17:10:52 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--WiEV9ofbxCY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, opidopiopi@gmail=2Ecom=2E </p>
<p>Selva=
 Nair has posted comments on this change by opidopiopi@gmail=2Ecom=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail=
">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2148?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ap=
art from comments below, in management-notes=2Etxt, under OUTPUT_FORMAT no=
=2E (2), we say &#39;the last line will be &quot;END&quot;&#39;=2E Add &#39=
;or &quot;ERROR&quot;&#39; to it=2E</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2148/comment/5cc4461f_a8ffdb34?usp=3Demail">Patch Set #1, Line 631:<=
/a> <code style=3D"font-family:monospace,monospace">     END</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Des=
cribe the protocol in the both cases separately from examples? Like:</p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Fo=
r management client versions &lt; 7:</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">  pkcs11-id-count</pr=
e><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">The reply is &quot;&gt;PKCS11ID-COUNT:&lt;count&gt;&quot;=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Example=
:</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">  pkcs11-id-count<br>  \&gt;PKCS11ID-COUNT:5</pre><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">For m=
anagement client versions &gt;=3D 7:</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">  pkcs11-id-count</pr=
e><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">The reply is a decimal count followed by &quot;END&quot; on a line of it=
s own=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Example:</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">  pkcs11-id-count<br>  5<br>  END</p=
re></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comm=
ent/c76c252a_87366f38?usp=3Demail">Patch Set #1, Line 641:</a> <code style=
=3D"font-family:monospace,monospace">Example for client version &lt; 7:</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">This section is confusing=2E Separate client version &lt; 7 and &gt=
;=3D 7 cleanly and provide protocol description separately from examples?</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">For management client versions &lt; 7:</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">  pkcs11-id-get =
&lt;index&gt;</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">=2E=2E desccribe legacy reply format=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Example:<br=
>=2E=2E=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">For management client versions &gt;=3D 7:</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"> =
 pkcs11-id-get &lt;index&gt;<br>  pkcs11-id-get &lt;start&gt; &lt;end&gt;<b=
r>  pkcs11-id-get all</pre><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">=2E=2E=2Eindex/range semantics, record format, =
END/ERROR termination=2E=2E=2E</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Examples:<br>=2E=2E=2E</p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Also no need =
to retain the original &#39;&lt;snip&gt;&#39; as that&#39;s not how other e=
xamples are written=2E ID:&#39;&lt;id&gt;&#39;, BLOB:&#39;&lt;blob&gt;&#39;=
 is better=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148/comment/049a07=
1a_702e63d8?usp=3Demail">Patch Set #1, Line 918:</a> <code style=3D"font-fa=
mily:monospace,monospace"></code></p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">Two helpers split a smal=
l parsing operation, interpret the start argument twice, and mix parsing wi=
th bounds clamping=2E A poor abstraction=2E I don=E2=80=99t see sufficient =
maintenance benefit from this=2E <br>Better to leave remote-entry-get uncha=
nged and use similar parsing logic here=2E<br>  <br>A better range parsing =
and validation could be a follow up=2E</pre></li></ul></li></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Dema=
il">change 2148</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2148?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2148 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: opi=
dopiopi@gmail=2Ecom </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: opidopiopi@gmail=2Ecom </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sat, 07 Nov 2026 17:10:52 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--WiEV9ofbxCY=--


--===============1496869079049537208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1496869079049537208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1496869079049537208==--

