Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DFBC79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CNo7qAN0F2n4mmH4y9oNKK8uXmhv0vKsttRggULis1U=; b=PgCFNTKtssvY7B0eEztNrPm3wd
	bQlm0+1ZTImsxXTv5RHMGkvz/RqIv7CLqk2qtshgudmif8O0m/KybgCiysg0NqAohI8/+5CCb+Xaz
	mBvUqQxVQXoVerTt/VbB+t58DzYrIccABPF7pzmmQCTDKfDhaoDwNyQJVqAkVVmY1kvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3c7b-0000Dm-PV;
	Mon, 07 Sep 2026 16:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3c7a-0000Dg-HT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5WH96/6E50cZZY7bWlZo5a34AUgAQg+nZ8xAZfV5q58=; b=QMawkEBTCxz8Ha69gxwMZprrh0
 8X6zHauAZ54vLwhq7BK3wj2atGufI5lXIZIZAIYNfTZTL10JbZuFvhm/2GKZvHdoPLN2RkAOtj5s1
 7T2Ro0BJiay9nPSWA9DLenYpv/aPgEtM2yVb45aKIx5zEyNDm1knbh/p0Jx08kK246Lo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5WH96/6E50cZZY7bWlZo5a34AUgAQg+nZ8xAZfV5q58=; b=j
 HGM57aRc4ogLoj5NQtwRLozQOUHqQTvz6BH6Q+7aWrtDcPcvrYUZzaUwk/H7eY3or0U73lTQwFX5/
 DknSwcP8ov6rJophsHJTYsO3/n574NVMDgJ4q1HceQwOH+gZNmLhiQ6Eil4YawJFEXvZSs5fuOj7+
 U17u+N2ShudKqNEg=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3c7a-0006TU-BN for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:23:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48436216a98so2537590f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788798176; x=1789402976; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5WH96/6E50cZZY7bWlZo5a34AUgAQg+nZ8xAZfV5q58=;
 b=CLi+GVadb1yxgd2F76iG7sSG/v29csbqewEihFpLOM/lO61Oushn62yHKXUyWvGnUI
 TYjlfGiUrVMP5M8mevmhE0rCS5/nYuyze+HH1gv8pPXJzZ4QQCiMDCpH1xF1QiP30ap1
 nqahPeaYbT+e+WmoBsg67bJ5el+qYs0ghKP8sNbQ/FPpuSWBRf8OILUXs+CyHq5jrv+4
 xFHEtMi5whxZxxKN9Ut14RDCMS6shd4UlLanBd4hJ4CgCMGAxGIZJ2URHea7Kr7ctWzK
 dvPkXv6fnfyE+OqfVlOs5CQqVHEYZO6BZ0jVh8WFmCT/Mlm8Svc1jPL4GBAxcNj7ELkm
 YFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798176; x=1789402976;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5WH96/6E50cZZY7bWlZo5a34AUgAQg+nZ8xAZfV5q58=;
 b=joKw+VB4tlMJ0sRxCrFQ8Lr1QJxqnEBs2KoAeUHuLtpAv10au+bkrXv5X+m54ujCj6
 tyXA251iXMtstiwVd9J5/jh+vYoUK+I4dFVL6C+fy92TXxsPfArJnUrZhndLlpQ1vn62
 DrPH70N0Mmn//PWxU20AQwQa2yG4KjUJnA+F8rVv5ZYei2kHpVvWjKy0ufU79BhL/7Vv
 7DPsO5jlwM9iRPrNkYO9/6ADjZEwugDn/E0VEcguKPZLKM4G2gujFWo6NE2kfb9hSmlm
 8hWRd9bk7ST9eyoTELYy2SKaYkwT/P1gVZMCxB8iWJHG8ZQb5ehFXQOzvyGWH0oTPgNu
 T1rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvN55f3g7mV3F5hzqRu3ZckPQVDqWr5/Euoh48WQzvHx7F7RsJ3hMM/GCx4aZ+zCS71EebZ7Om+jvJEj6W@lists.sourceforge.net
X-Gm-Message-State: AFuF++lMdPPutBjBwOWNSLpWVDUOdk5XWpOFxZariZhBBD73BggAoPKS
 fNZ566p84IHmX3T4nPnF19lRjzbwY0IldMpoIlAX6M1MjoGMzfswnOKWDbVoQtUfiQ+vdWXiv3M
 XikI7QUy5MYgvZZFuGEU2gY+8XmSuBYrl1tgcgQGtcXQpC/0iR7Y//NE+rqzDtVX0Ns+W
X-Gm-Gg: AYBFou1NF0hyEnNuhOOb16I0KeVEVBnXLUXvCvb42cZ0sqjVb7mZvwgaBsRKLgCyHmt
 mNWw/lY27/GmRVovNqGrmDaZKhgvlKoO9NbUJs4Zx1WN0mTkhF3jsWHgvFjXGDD8B9i34haFD+p
 bwYFfQTxqcd/ZftfcJj6t4s6HPkoRwRcBsPzO6yFl/3WrBUeMxynah1310Dg62tslkGNDwcF4XD
 k4I136v/ARqlVZEu0NXskoNTEj5l2rshXt5OT7S6IcnP174TbCsWWhEiyzuoNzFsw5vwpgN8CHe
 BzGZvXVu+Z2Ld6+b57ItwJBX4IzY5USnIoEQRUaFw4a1RuIhrvpkHVSEFTx3OCcB3KKGZi9ieg/
 hvWRROHzvXjfmJmw/ArG908nVh/INLLYaVaIp8JyZAFVAYpJNiJoawbdy3+Qt3QMjwF8D7iQUUG
 f/k1b0BPUWwefWsEX1tr2ULJNtw0eu2iWQXy3KnJexzyEqLfaMxqtiiwHRJJCG17z5Hc6u2ULAj
 jUGmint5HYBjrTQfpXoo5koc2C26WhZ+wawCWXDZKC7LWBSdGiqnvRIjIYGtuv68tl6/KpWkghI
 +YNdrGndIWuSbwN1XqImHkRuiN8tt0f+4beTMoF2nUAF5A7rV6w=
X-Received: by 2002:a05:6000:2508:b0:485:9879:a45c with SMTP id
 ffacd0b85a97d-4859879a4ebmr11045004f8f.53.1788798175601; 
 Mon, 07 Sep 2026 09:22:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858bcefd59sm24848777f8f.19.2026.09.07.09.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:22:55 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 16:22:54 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: b401b0989fda78f36449073f3b64df9900d21bc5
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 16:22:54 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8c9098a907844f312462d0e00c1b53082686549-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3c7a-0006TU-BN
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4804177121663006254=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4804177121663006254==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5HQ5rG1eWDA="; charset=UTF-8

--5HQ5rG1eWDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: Code-Review-1

(2 comments)

Fi=
le src/openvpn/control_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741/comment/7fe73b74_450fca1e?usp=3Demail :
PS12, Line 73:     while (ctrl=
_msg_tlv_read_header(payload, &hdr))
Seems like a truncated TLV header afte=
r the wanted TLV is accepted here=2E Once `found` is true, `ctrl_msg_tlv_re=
ad_header` returning false for 1-3 trailing bytes ends the loop and the fun=
ction returns true=2E

I think we should distinguish clean EOF from a malfo=
rmed header:

```
while (BLEN(payload) > 0)
{
    if (!ctrl_msg_tlv_read_he=
ader(payload, &hdr))
    {
        return false; /* bytes remain, so this i=
s a truncated header */
    }

    /* process TLV */
}

return found;
```

=
Probably a test with one byte appended after a valid TLV would cover this=
=2E


File src/openvpn/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741/comment/b9ac27b9_00f52354?usp=3Demail :
PS12, Line 78:                =
                         *   0 means "defer to the client's setting" */
Thi=
s comment wrongly describes 0 as a sentinel=2E If the client has no overrid=
e, only the fastest server and RTT ties are candidates=2E Whether to use th=
e client or server value is instead determined by `client_margin >=3D 0` an=
d the later patch implements that correctly=2E So I'd update this comment t=
o reflect that=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-=
PatchSet: 12
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Comment-Date: Mon, 07 Sep 2026 16:22:54 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: Yes

--5HQ5rG1eWDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741/comment/7fe73b74_450fca1e?usp=3Demail">Patch S=
et #12, Line 73:</a> <code style=3D"font-family:monospace,monospace">    wh=
ile (ctrl_msg_tlv_read_header(payload, &amp;hdr))</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Seems like a t=
runcated TLV header after the wanted TLV is accepted here=2E Once `found` i=
s true, `ctrl_msg_tlv_read_header` returning false for 1-3 trailing bytes e=
nds the loop and the function returns true=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I think we should distin=
guish clean EOF from a malformed header:</p><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">```<br>while (BLE=
N(payload) &gt; 0)<br>{<br>    if (!ctrl_msg_tlv_read_header(payload, &amp;=
hdr))<br>    {<br>        return false; /* bytes remain, so this is a trunc=
ated header */<br>    }</pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">    /* process TLV */<br>}</pre>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>return found;<br>```</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Probably a test with one byte appended after a va=
lid TLV would cover this=2E</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comm=
ent/b9ac27b9_00f52354?usp=3Demail">Patch Set #12, Line 78:</a> <code style=
=3D"font-family:monospace,monospace">                                      =
  *   0 means &quot;defer to the client&#39;s setting&quot; */</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
his comment wrongly describes 0 as a sentinel=2E If the client has no overr=
ide, only the fastest server and RTT ties are candidates=2E Whether to use =
the client or server value is instead determined by `client_margin &gt;=3D =
0` and the later patch implements that correctly=2E So I&#39;d update this =
comment to reflect that=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d=
302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Mon, 07 Sep 2026 16:22:54 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--5HQ5rG1eWDA=--


--===============4804177121663006254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4804177121663006254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4804177121663006254==--

