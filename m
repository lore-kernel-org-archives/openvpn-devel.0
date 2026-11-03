Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497C606C586
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l1Buel+H;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YqZTPiSW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CzBqWHkw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YvYgxtRK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/X7ztZnkbalQ9RyjRNpRnLAz/x4qEDItFXzW+K588Z8=; b=l1Buel+HU7brwC/O03NdhmRUzG
	CxjeCTgUd5ZlIEirhPXS/IxHUk5fOY4T2/zoOWwoPGUFyx8/Gd97kaqUzoLfHIHgDvPsEzgP/HLX1
	3U/RK079/XaR6RQ4dDhBfY8V6FN2z4CRsLib1iZM30azjdyTp7wcUek8FbnvLlf/CUQk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBpt-000000007VT-0BUi;
	Tue, 03 Nov 2026 10:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBps-000000007VM-0XI8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HDhiGxAg0ELqebCK8WPQvP6+usB5vUI3YxCotYNZi8=; b=YqZTPiSW0FDV+Hn3MhoslzXwtt
 tcALPhOKEohXYtFYQTPqd0HSWgCprtybBajnCOrqMk7y6lc7VBJtH7butpA4825wlshsrcc3Maxyn
 QJNoRU8tA1HIFv2sWYK2MTVLlouCPubevjIuh1VqJiW7Dv7hI9oE651/PRxU/jj1hhuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HDhiGxAg0ELqebCK8WPQvP6+usB5vUI3YxCotYNZi8=; b=CzBqWHkwm7ElcUXt+X3wgXnSlI
 65woIH8Y6gcn8PgM6jz1VHvUpfev5yJNtOBCaKNCh9tMDKqujrPv/seC/KQsNhY77CNY8vRk4Uv0L
 /g4H/fFkQcBBHaEa3UxHohjMjZxbLIp4Nsqpn0hKr8xZUA/r+mjDDUxVcq9JDtWkU6Zg=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBpq-0000000086B-0fXc for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:33:48 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so31163715e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793702019; x=1794306819; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/HDhiGxAg0ELqebCK8WPQvP6+usB5vUI3YxCotYNZi8=;
 b=YvYgxtRKxMcxtogrTQIUiYw4jjK5BRVVREh15971s/04iDbH+RnD7CZX/eBzg40Ip0
 DkAHsPUTtjLz/+yfgQumlOZgIZnlbnMfD0IiLS5Fu9N3xKdqFN9kQW8613TMHhmgAHgZ
 8CUQGDJePB000IptG7KBJfEx+5HlQp7kSBnMDJk2i7K9GoqAsRjCr0Qc2at4e3+Tl+42
 IrgrZRYHOshbI9pYBl8svA8lADBi2sdOfPq2Yk0EUPm07iI9eLB4Ln5qI9itCjYRM2Zg
 N7hUtWkPfnol/0FZJmOIL59m3sy+jwuLX9QNPLWmfWuKXDsrhGLfSGC8L4LKI6OsVPgK
 XaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793702019; x=1794306819;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/HDhiGxAg0ELqebCK8WPQvP6+usB5vUI3YxCotYNZi8=;
 b=19LTHSRJjaIUXq1SCnEm0AIP/Y5309oYCofgxW2yyVTm6vRwjx1LLnIW9U7cFnM+Zc
 fFJTiDV1BOFapoT/riE4q2FKf0Fk0R3hy9iYXwKjO4xetk0aJJcheawp0PAhH/ZbKt6B
 kZv9YNsOrYYXKGaVVg3v6rade3vrfUCQqB6mxzuWVypmThNCK+mDaGPWDNYQ/yY4yWhW
 1qpq2snuM4GFESccL3GT1PHilzQssf6JjGpDIYlcg5Kw+hHXiKQrxEAV+dEk419jPZ8d
 9DXR5/cKIhrOoBjCDjS0ARuWb78By2oSPBk67u1xJ7qcx0ig5ftcbsTfY14G+JGjlnRE
 ndtA==
X-Forwarded-Encrypted: i=1;
 AKwUvByG9Wer66PWD8qf3QPg3n6wNNX2xu9Jf7tnk6h9LSywPpcb6ismmCBSjyHFEUC7xFSPjZ7l45M62mYnHagP@lists.sourceforge.net
X-Gm-Message-State: APuU4Z94twBK/Bo4QL9usXYKA+OMO+vYirhqae4ET6UE10TXdXx3VXV5
 FDJHMZPDyHH6EVINJa+W6kcyuqDj3eTA+VSfoZlAHx5Ey/QWZT3JT+rsXlXsy7Uc0INKQBpjEJW
 e3IoGFGOKwyogetTWJXuQGD3I2DbW77lJm+zbiAsh/+upcSYb1yQfDe7QXG71a6jOd0MI
X-Gm-Gg: AYBFou1MUXQlzIzy+eqWMgRB0xvJaAv31zVUegDTD2qvZXP+dJe3xIpv4epkJSC+L3u
 nxXlor02T4X8/CuHcqPVKc419tj/Z+KU9IzmDXOufM7EXu0pWKzKukIQSqKyXSYZrJcWv1wcl7U
 U6FWlMPnYxImSMNkYLxYFb5jiFutvKethTIzhZhm6WdS8+I8iqzVptDWRYxmoDdUdUixAATmKMK
 5lnVN0fjL5MVt5knCjt8fLUW8LQKSADffLm2bXf6JNtdou8f609nM2SsxRCujqrzG8NWWeUBeJg
 bAWOBhE5qra/Thh1Lcc2JEZrLUDtokBPpcjAHake8t5NFpOKffOMiCBlQ12LAXebQgE3kONtIlY
 +rAZRPrNIKauxP9m6zmrj1iTAc8YVfHbaF1uGttNKAf2tuXXubWhq3/8POE/scAXyYk8JtQTAD0
 ReQM/0hfI+urBiilfeMoA1w++xt/yqUCDuAod681gPMz0rmVkFhdl6fhwaYCbA0x8aY4SRgpjSk
 Z/iZGy8AlN8hMzwwaVRTol725arkH7l+cjxfG5vCmcyrSQCtU/Q3DU2x7wRKRDayTZm5xEGU1Ip
 19mBXoDz0zqEXf0kPjibeCutUL26IrREsPIHM/4I8Z6VYrH36o7XMXDoDed6+BMqejLasPhR6CX
 grCxzzXUWyA5ukYGBApmmHi4xGsvqQXY2uMxUHJraRyaIZhJfQN4I5rtMEL3FCX9celVQkDx7Jj
 4j3vjuX3jF5i0x5Q==
X-Received: by 2002:a05:600c:858b:b0:4af:9cae:df63 with SMTP id
 5b1f17b1804b1-4af9caedf69mr137733055e9.31.1793702019255; 
 Tue, 03 Nov 2026 02:33:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm24892813f8f.30.2026.11.03.02.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:33:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:33:36 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4379a167419d464c000dca3c5c032aaebb6dac73
X-Gerrit-Change-Number: 2050
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2050?usp=email>
X-Gerrit-Commit: fc14e738f3444f427df093c599963e518ad70efb
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:33:36 +0000
In-Reply-To: <gerrit.1793094393000.I4379a167419d464c000dca3c5c032aaebb6dac73@gerrit.openvpn.net>
References: <gerrit.1793094393000.I4379a167419d464c000dca3c5c032aaebb6dac73@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0Mzc5YTE2NzQxOWQ0NjRjMDAwZGNhM2M1YzAzMmFhZWJiNmRhYzczQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <803fb7a9db6e0342a1d56d848b1be6367a1398da-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBpq-0000000086B-0fXc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: avoid
 redundant event_ctl() calls in multi_io_wait()
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3109931832624191297=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3109931832624191297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X1i62ogzhGw="; charset=UTF-8

--X1i62ogzhGw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2050?usp=3Demail )

=
Change subject: multi_io: avoid redundant event_ctl() calls in multi_io_wai=
t()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2050?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I4379a167419d464c000dca3c5c032aaebb6dac73
Gerrit-Change-Number: 2050
Ger=
rit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 10:33:36 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--X1i62ogzhGw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2050?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2050?usp=3Demail">change 2050</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2050?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I4379a167419d464c000dca3c5c032aaebb6dac73 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2050 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 10:3=
3:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--X1i62ogzhGw=--


--===============3109931832624191297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3109931832624191297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3109931832624191297==--

