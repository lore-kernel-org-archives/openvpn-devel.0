Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4F606A328
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XVDIx86k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D9NwO3kY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TlGoeNH6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OF1OTpOR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pG5Togrjg2zMRFMKSL4g1bF3zeX8WngZmB3v5UU+EQA=; b=XVDIx86kaDSAOa/H/s/bSJhFZK
	2nLcwkqUAuarGHZby6JufQboe8taJrapIfyyeWCUjqbjKpVc7htleOOngoZoIXB0gSWoxwSsHhB+h
	5IoAdtRERh+ilxgiRcsHDmDTHhQXdRgJrZdDZygV1dXyJr21dcWIOaseD+j7KLrfmbIs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOxYK-000000002Ag-3qLt;
	Thu, 05 Nov 2026 13:30:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOxY2-000000002AH-455U
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AHVHExzxaHDxbHNWLnEr0eGkjfZMm/phRARn/v6iTok=; b=D9NwO3kYykth2in64XHM81ZBPp
 EbFvRHYdzYC5pHua4m4f6XAz9UW/7zQjcmNTg2hRNOhvTa9Rgzk3wnpgoxJH7c9qAzcNElshyY8cO
 gWpgnsSYinIo3PrZ/syFsKD4BVMDuPHaG8YIL3/VTrYE/n0jN7WmXsjQniExrnao+o0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AHVHExzxaHDxbHNWLnEr0eGkjfZMm/phRARn/v6iTok=; b=TlGoeNH6IzlwZM6QTVnhu75Chb
 37zRytArnyosdTAkNIU5FBal7slebD6+ZuOY91Eogcphpqul7oHUC8LZUg3Tu/yKeBWfnFdW8hvj/
 wtAceal9Bwkfn3MG6X54CwtW+v07YTCXFM5ZmstwIiNrf/d/YtyOObv82BM+IzAeTPHo=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOxXl-000000004qG-21XS for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:30:21 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso839731f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793885411; x=1794490211; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AHVHExzxaHDxbHNWLnEr0eGkjfZMm/phRARn/v6iTok=;
 b=OF1OTpORqsCCTc1hQuYyUQVNI+19kvElzN+XT+DQ2QgJngVbX3w2Kr28Frzx35tJxI
 NHACcKAAG7x7msgh7GrTJT9lOh/WpX2lLBoXUAIkK124paE6zzNBB0I8QH65A7eiHdUQ
 +LlO9IPMgeywRXRKU1rs7Puh0WEQ8rFl1OKjZJBSBV+Zlh7rnI7jH1hd3AT49th/pEsI
 3rxsPEuhJqnldDu4YNWiL6jjmqsk/L9SaZ+F+kd2TdGFHc/fyslcScJKqzeYZKBl/ACn
 FCTc1prsR4dybm/r1Dputbn7IWwp0kpOfwA271yiCWvI1yVfeIFz01eVY4G8zbSbwPb4
 Lgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793885411; x=1794490211;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AHVHExzxaHDxbHNWLnEr0eGkjfZMm/phRARn/v6iTok=;
 b=DhE6lIi1LW3FSfSV0Ham1QtIf0DRm/iLLXFKoNKNBLJOOrX6LD3bf+7ye+sGrpd7N9
 ukzLrTjY40bD6ol+2jsJ8dixi9eLY3ED9zkpSVbbFKiteHUEKpPf9r5y19DFxfMtGc3Y
 c6mk9wWQGdkJYYByyQifjWQsr76PZY3ISIe/zD9M6yk2s7QIzqHhXC5+CJ3cXlMegeL0
 7hC+wg9T8pTFmrBjMgXG3MvzZ4wrwv3dv48lKMbwvZwVjWaKZkpmZeG2yx9wN9ntc226
 2dWijIvDDEBmL7DeMIc6K+X8h6rCFBxbkbZau0br3Gg7p7eKXToU3FMJ52DpOtJwJUSz
 GSdA==
X-Gm-Message-State: APuU4Z98VhxwadmSTz1DXCuoEFW+0RsADx6DbW82Nax5sFR0mSta7Oa+
 WOFj5cue1qJh8CiF5iiSkkxK5p+Xcsqh3PLe0L6r0mez94mIeAujZp6jacd1hIcxTDQDHJHDQHs
 IJcrQ/gqftBkG5DHagxDysUARbXCIIqsSiBRVH12ndI4nidKPyNWKPdjPlJRjzsVZo8t19ux4we
 tE4hE9Ag==
X-Gm-Gg: AYBFou00edVxzjOwoU09py+abqK0NPyGfT/DHpFo+QE2E7cj7DVPVfY62AAmtoIm2BR
 DwheAgkQzHg43RNhC8cJfDJSVlEM3c0VWZGzBgUJZ41O8GICM7nxpg3V0AWYN4XMX5CJnHTZtKN
 n4O95CXJuhDjz1AKnoUt3E2tHoVXTQmm5ivwreVbDYFU4vm5CniK0stY2USedr/y0/VKcOk0qMe
 m0/k27QvDMm/hDR5CbD9hxYoKRLqek3ZkGc/1D1xWfM3JdWvma7vR1MZjDiT1DI6MTxCgdXolXj
 wY3TXkE3qQI3j/r4JP8skhdQ+jYni9hFQIUBh/4VJBxplLiolNljqpuPJQ+78TQC8Zi8iTs6z1p
 XRY9TYpBVNB3oU2G0P48rQzh4hhpH/3trxVob8DDrLF0H1inadRqC8fGt9/Qb593qg73OJ5Rf/G
 myaxgTxNnPEHhmMYUG5VrGACObQuYjWaRN+B7FK3o/wKrp6//uErb77It2G0iLnVx7b4uLm1r6e
 PLmH+9xv1yL1OYFdV8RNFZfGQDGT/iBYP2W0Up+fBbypIKGFpNpK1jLN2mytxQw/bbf4KgHL/q/
 wlSxfHxpKAdwWvhqj8YPztckaryiSB7Tg0Q5ScwaHPuseeMkT6jY5egx5+dellilfFobuUIDxeH
 a0Ue5MQVHCOfMCVAFkidoLNeCRQyXjuPDMd2ZkqVfa/21tdKFHZgBtPUD8/MXdh/q4bOBHhYegm
 pQigAgAF5r5YXZlg==
X-Received: by 2002:a05:6000:178c:b0:487:b50:101c with SMTP id
 ffacd0b85a97d-48e6e2bc04cmr42549517f8f.5.1793885410445; 
 Thu, 05 Nov 2026 05:30:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea1811c4sm10085263f8f.3.2026.11.05.05.30.08
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:30:09 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 13:30:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: a6b44bfb1993df37250449250be5113b66181664
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 13:30:07 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8478208972b8f2110f69184e8d87a5c7028b89cf-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOxXl-000000004qG-21XS
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
Content-Type: multipart/mixed; boundary="===============1058438494026068471=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1058438494026068471==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8dKCgr1yPXk="; charset=UTF-8

--8dKCgr1yPXk=
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


Patch Set 9:

(12 commen=
ts)

File sample/management/omi=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1859/comment/7db6ffdd_e00436fd?usp=3Demail :
PS8, Line 105:         =
    logger=2Ewarn(f'Connection lost ({exc})=2E Shutting down=2E')
> warn is=
 deprecated, use warning
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1859/comment/e48d8d77_3212fe8d?usp=3Demail :
PS8, Line 211:             sel=
f=2ErecvBuffer =3D self=2ErecvBuffer[len(OMI_PASSWORD_PROMPT) + 1:]
> snake=
_case instead of camelCase
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1859/comment/64acbcd9_4d454eb8?usp=3Demail :
PS8, Line 308:     def log_m=
essage(self, time, level, message):
> misssing typing
Done


File sample/ma=
nagement/omi_client_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1859/comment/f8f17d62_40684961?usp=3Demail :
PS5, Line 66:             =
flags =3D "6"
> We should move it to well names constant
I feel that is a b=
it overdoing it=2E With the same argument I should also move all the other =
fixed part of the protocol like acc-msg, client-auth-nt and so on to consta=
nts and that would make the code harder to read=2E


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1859/comment/e3e8fa09_fa03c57c?usp=3Demail :
PS5, Line=
 116:                 handler(self=2E_partial_acc_msg)
> Hmm, right now we'=
re not allowing async handlers=2E [=E2=80=A6]
I implemented support for asy=
nc def function using inspect=2Eiscoroutinefunction in dispatch_to_handler=
=2E I am not sure if there is a canonical way to do this instead=2E


File =
sample/management/omi_client_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1859/comment/2908d622_516ab121?usp=3Demail :
PS8, Line 38:    =
 def __init__(self, finish_future, connect_data):
> Missing typing
Acknowle=
dged


File sample/management/omi_server_demo=2Epy:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1859/comment/9a0ae035_1d50f73d?usp=3Demail :
PS5, Line=
 118:         username =3D client=2Eenv=2Eget("username")
> get can return =
None, so it will fail with startswith later
Done


File sample/management/o=
mi_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comme=
nt/b34259ca_767ddede?usp=3Demail :
PS8, Line 88: class ServerDemoConnectedC=
lient(ConnectedClient):
> @dataclass is missing here=2E [=E2=80=A6]
I want =
to repeat that I find Python dataclasses are weird=2E Fixed=2E


https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/c7251e61_379934aa?usp=3Demail=
 :
PS8, Line 189:                                          "NOTIFY:Please w=
ait for 23s to let the server think if it want to admit you")
> NOTIFY:: ? =
Currently the text is in the flags placeholder=2E=2E [=E2=80=A6]
Done


Fil=
e sample/management/omi_server_protocol=2Epy:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1859/comment/af33a899_967363b3?usp=3Demail :
PS5, Line 186: =
            handler(client, kid, env, extra)
> Exception in the handler wil=
l kill connection=2E=2E [=E2=80=A6]
the dispatch_to_handler now has an exce=
ption handler for this=2E


File sample/management/omi_server_protocol=2Epy=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/170fed7e_c9ff337=
9?usp=3Demail :
PS8, Line 143:             client=2E_partial_acc_msg +=3D m=
sg=2Edecode()
> Each fragment is decoded as UTF-8 separately, but messages =
are split at byte boundaries, so a multi- [=E2=80=A6]
Should be fixed now=
=2E Now every line is decoded as a whole =2E


File sample/management/omi_t=
ools=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/d2dd06b=
0_157fe3c7?usp=3Demail :
PS8, Line 39: def openvpn_escape(text):
> missing =
typing
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1859?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09b=
afabf612e9501ea757647c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-Patc=
hSet: 9
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
Name of user not set #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Name of user not set #1000061
Gerri=
t-Comment-Date: Thu, 05 Nov 2026 13:30:07 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: Name of user not set #1000061

--8dKCgr1yPXk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></=
p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi=2Epy:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/7db6ffdd_e00436fd?usp=3Demail">Patch Set #8=
, Line 105:</a> <code style=3D"font-family:monospace,monospace">           =
 logger=2Ewarn(f&#39;Connection lost ({exc})=2E Shutting down=2E&#39;)</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">warn is deprecated, use warning</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/commen=
t/e48d8d77_3212fe8d?usp=3Demail">Patch Set #8, Line 211:</a> <code style=3D=
"font-family:monospace,monospace">            self=2ErecvBuffer =3D self=2E=
recvBuffer[len(OMI_PASSWORD_PROMPT) + 1:]</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">snake_case =
instead of camelCase</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/64acbcd9_4d454eb8?usp=3Demai=
l">Patch Set #8, Line 308:</a> <code style=3D"font-family:monospace,monospa=
ce">    def log_message(self, time, level, message):</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
misssing typing</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File sample/management/omi_client_protocol=2Epy:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1859/comment/f8f17d62_40684961?usp=3Demail">Patch =
Set #5, Line 66:</a> <code style=3D"font-family:monospace,monospace">      =
      flags =3D &quot;6&quot;</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We should move it to we=
ll names constant</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I feel that is a bit overdoing it=2E Wit=
h the same argument I should also move all the other fixed part of the prot=
ocol like acc-msg, client-auth-nt and so on to constants and that would mak=
e the code harder to read=2E</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859/comment/e3e8fa09_fa03c57c?usp=3Demail">Patch Set #=
5, Line 116:</a> <code style=3D"font-family:monospace,monospace">          =
      handler(self=2E_partial_acc_msg)</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Hmm, right now=
 we&#39;re not allowing async handlers=2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I im=
plemented support for async def function using inspect=2Eiscoroutinefunctio=
n in dispatch_to_handler=2E I am not sure if there is a canonical way to do=
 this instead=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File sample/management/omi_client_protocol=2Epy:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1859/comment/2908d622_516ab121?usp=3Demail">Patch Set #8, Line 38:</a> =
<code style=3D"font-family:monospace,monospace">    def __init__(self, fini=
sh_future, connect_data):</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Missing typing</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File sample/management/omi_server_demo=2Epy:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1859/comment/9a0ae035_1d50f73d?usp=3Demail">Patch Set #5, Line 118:</a> <c=
ode style=3D"font-family:monospace,monospace">        username =3D client=
=2Eenv=2Eget(&quot;username&quot;)</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">get can return Non=
e, so it will fail with startswith later</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File sample/management/omi_se=
rver_demo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b34259ca_767dde=
de?usp=3Demail">Patch Set #8, Line 88:</a> <code style=3D"font-family:monos=
pace,monospace">class ServerDemoConnectedClient(ConnectedClient):</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">@dataclass is missing here=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I w=
ant to repeat that I find Python dataclasses are weird=2E Fixed=2E</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/c725=
1e61_379934aa?usp=3Demail">Patch Set #8, Line 189:</a> <code style=3D"font-=
family:monospace,monospace">                                         &quot;=
NOTIFY:Please wait for 23s to let the server think if it want to admit you&=
quot;)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">NOTIFY:: ? Currently the text is in the flags =
placeholder=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File sample/management/omi_server_protoc=
ol=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/af33a899_967363b3?usp=
=3Demail">Patch Set #5, Line 186:</a> <code style=3D"font-family:monospace,=
monospace">            handler(client, kid, env, extra)</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Exception in the handler will kill connection=2E=2E [=E2=80=A6]</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">the dispatch_to_handler now has an exception handler for this=2E</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/manage=
ment/omi_server_protocol=2Epy:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/1=
70fed7e_c9ff3379?usp=3Demail">Patch Set #8, Line 143:</a> <code style=3D"fo=
nt-family:monospace,monospace">            client=2E_partial_acc_msg +=3D m=
sg=2Edecode()</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">Each fragment is decoded as UTF-8 separ=
ately, but messages are split at byte boundaries, so a multi- [=E2=80=A6]</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Should be fixed now=2E Now every line is decoded as a whole=
 =2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/=
management/omi_tools=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/d2dd0=
6b0_157fe3c7?usp=3Demail">Patch Set #8, Line 39:</a> <code style=3D"font-fa=
mily:monospace,monospace">def openvpn_escape(text):</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">m=
issing typing</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">c=
hange 1859</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib09bafabf612e9501ea757647c86a450c73228a5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1859 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Name of user not set=
 #1000061 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 =
Nov 2026 13:30:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComme=
nts: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<=
div style=3D"display:none"> Comment-In-Reply-To: Name of user not set #1000=
061 </div>

</body></html>
--8dKCgr1yPXk=--


--===============1058438494026068471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1058438494026068471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1058438494026068471==--

