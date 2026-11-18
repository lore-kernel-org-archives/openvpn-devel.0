Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAFA606A332
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eB8srfVQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Nt4H5bOp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S742Reb3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aVC3RHyx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RpwCpK/+f2FRDpNT7XF9OiCbWkjGNP3FuszhRLJUfWs=; b=eB8srfVQEggB5XCM7l2trnq411
	mXkR7uZ9GiBzYmpdbWz0zjiJaBopNipLFBdMnKi59KkNWqHD/hDpCnmhpqER8XIBRX0gLflKN5kk0
	FAZ0E2rFuTLni8sbIaAVdQkNSaUnhy2mmYMvFdSb5SW7l4EE4zd1lTdY7r86Ur1FsamM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTi2z-000000003cu-2Ous;
	Wed, 18 Nov 2026 15:58:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTi2w-000000003cb-0NI1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tg64cEY/NcsybMqUUcD1/NhwluqLW+RdsljmaLZKyhA=; b=Nt4H5bOpK6hKX/sN2TZk+SwNOh
 PhkJEr/2JIYb2gv/tzMd6QGf9UXR3XVFxCo4xJeMgmq7+9TRhUfk31FP5Z1nyNly2BK4c65IahC8q
 pwgzk8u0Oqfdt2ho7M5WhII5wWQEUEjQ8jGy7CC6f7Zj9U51RlcXaAefez1tpQYULe/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tg64cEY/NcsybMqUUcD1/NhwluqLW+RdsljmaLZKyhA=; b=S742Reb3bbqox9jacHWTKfl8gM
 5pc9lzBydac+43eipHQ1Grh0Dww+OxYXziAGHF0ZKAFLuCxD2ynswmcEBax+to9Jjo5ntlfnApdvo
 9z4aO2+bYBdKDuA99kWMdm4x20r2cqI+sTgGRZUimu8sFJa5zdUd833tws7MlxxIlGcg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTi2t-0000000058n-3vKj for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:58:06 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so9583675e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795017477; x=1795622277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tg64cEY/NcsybMqUUcD1/NhwluqLW+RdsljmaLZKyhA=;
 b=aVC3RHyx0KJ5PnJVhX+HWT0yVueD9O0NEgjrlFBhwIKtVSxDxoi65byEO0408p4WJx
 N16xWypbpO8JwRCDKOwp9YY5T8UEivCPiVCatYnLkdjVLpFtWsMeGP9wDXGyz/mATlit
 MfZSXt96JERQ8fU6XOss8b8D3mxv7XuSFalezstx2WtuvU+W1J+r7LrG1EvwA53x1kqN
 2TImysY/sdCmielIUfikGBt9VjYQYCBDn2vWDnit2axcnN4OobTxNJ+LdbTHMQiLO0YG
 awXpW0YSElnQR0qWVENFrExDvEUUC5Few3sK0QlNeK9gYGGPaXr4vUQ8SE7PRs5bzRnw
 rnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017477; x=1795622277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tg64cEY/NcsybMqUUcD1/NhwluqLW+RdsljmaLZKyhA=;
 b=oK38+9dvkab4fxJh/TnKqz0fnEZa9F7un8ZQ6+VuWLT7lCl/wjvJGq5sgWHo6bbGlD
 JoG5Wq8MzkncudJ7lL9Q0tsqdE2RwuwrdJA0W7FKJtKwv+gcGeisvIuql8dAJ4I02jMk
 cqoj+lIlgWvdCuy8zkk4UojYLxX3ATXR1KAiZAghyURvdz2suEZQgjXPgwfk4axgXugR
 tUEp+KYXcmvKIITOWkeHFR36xBlOKeAhh5T40zwc/FuS+CnVpIaWLDUDFnYhlOPsmgwB
 f2mzGkbUixlGVEiWyef57co0+t9697gc9qQuATROfT7F5zpUE9TrltmlrAdvlqAkdpxh
 BcMw==
X-Forwarded-Encrypted: i=1;
 AL+hErFfm9DbIQM8tov0yf1kRWA09zoiFhiP6zwkJZ1g9BS93KaFjcmLkUt7WFe3PvScZaGz6v7q4Ke0qP8YdE3x@lists.sourceforge.net
X-Gm-Message-State: APuU4Z900G9z5SXwLC3lhqT9KNffK7rL22kUVQ2hr/eviX1SCvU+Mp7x
 Zj3snulPL5/366OcvfFfr7zsRgWUOBrbM/g4/1oDrZBSeg8a1kPCjRQsod9jnmZHeZT7yDR/Odj
 gyOmcNCrye/uyCs9zUdKqreNdSRDII9U4tEK4Ok1Q/bZDbIB1BtWz3alpkMJPCnh1Jj5udepJNd
 YvQk8teQ==
X-Gm-Gg: AYBFou2hoZEl0CJaqFCiTIjL10dhao5MSe1a1aVdTxKkd49hvJJCHb3QgsKtLpXiAnD
 g3y1Uf9HWWbFKKt49lI0GDXmKndUEan5vENfwZNL0+tnlhhTSMiVh32IpcOaDwojlNcik+rMTQc
 u8NT34/WibnBwNpNCz+Onkbbm48yr9m3S9PQwO8TP5/BWutERXqOO8XjfawbfXqrYL3QQev97xQ
 G5HesH44skOCLM2xhbscumIoppCi9nTyBZRN34m6yXBnb3+5wjwEhc6+gTAb5UWqhWl+cLVjNnk
 HuRUTzmOE0HZRsIYoLvNMfLY5uz1IA239Fere1PGJ5xO1yMKGqLB6hTDiwMISkd936Xe7hKIloD
 7MueP+L+MRAFaWhgAa/lhwzm8NpKHca9MYWyoBXmrmPY8bvZhD3ejNLLGTpsRFd+eIYis+wHQa1
 CSQPN/sHToIDfEt60PoENfchidhGIerHKCjYN9OoM3eL3QlTqdsZmH0hGaut9Tryr+gEA0dL647
 XqSHmvdlS7fQBtKLaAUqaCJ4O1v1YtsSXV5Py9pINpTyqot5/nAptl+tgiab9+zvcol26vrGyvA
 +zHhqxJFS92Jlpti/a8C0zJAu7oYRyH7KRNOyoc1VlpMPloiZwm8omJtqFUv9/zpIgJYWdfPtCB
 viLoIa7Jh2m0ie1JuotoM4hIA/IRV6I77ms9DcFAgDtKeZrPl9MBLCjoo8lHUwGVOurY7DeffbD
 SArwPlaXLtlO5Q/j8=
X-Received: by 2002:a05:600c:1d26:b0:4bb:5d39:95fa with SMTP id
 5b1f17b1804b1-4bb7da1a877mr61056215e9.12.1795017476864; 
 Wed, 18 Nov 2026 07:57:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6575a5c28sm5655871f8f.59.2026.11.18.07.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:57:56 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:57:54 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: cb3188c1d4f5b0437c0b4af3b6003c3f662a6e87
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 15:57:54 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4eb04deae1d769a77ef4de80b585417f2d6ce0b5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTi2t-0000000058n-3vKj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7221697913320973959=="
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7221697913320973959==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h/ZgvYeTAnE="; charset=UTF-8

--h/ZgvYeTAnE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Ralf Lici has posted comments on this change by Gianmarco De Gregori=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail )

Change subj=
ect: dco: detect local kernel capabilities through netlink policies
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review-1

(11 comments)

Patchset:

PS2: 
The approach looks right to me an=
d the unit tests are well targeted (especially the "same attribute id in an=
other policy" one)=2E Aside from test_dco, I also ran the probe code from t=
his patch against real kernels:

    kernel                               b=
uilds  PEER_ID  TX_ID   absent container
    Fedora 7=2E3=2E3 (in-tree ovpn=
)          yes     SUP      SUP     UNKNOWN (*)
    Ubuntu 25=2E10 6=2E17 (=
stock, no TX_ID)  yes     SUP      UNSUP   UNKNOWN (*)
    RHEL 8=2E10 4=2E=
18 + ovpn-backports      yes     SUP      SUP     UNKNOWN (*)
    Ubuntu 20=
=2E04 5=2E4 + ovpn-backports    no (1)  UNKNOWN (EOPNOTSUPP on every query)=


    (*) should be UNSUPPORTED, see the inline comment on unclassified
   =
 (1) uapi headers too old, see the inline comment on the headers
    
@gert=
@greenie=2Emuc=2Ede: you won't be able to test this code on your good ol' 2=
0=2E04!

Something to keep in mind for future capability rows (which I've a=
lso mentioned in the inline review) is that before Linux 7=2E4 (which is ye=
t to be published) the policy dump silently omits NLA_BE16/NLA_BE32 attribu=
tes (fixed by net-next b785f5c56fb3 "netlink: policy: report the big endian=
 attributes")=2E On all currently available kernels REMOTE_IPV4/REMOTE_PORT=
/VPN_IPV4/LOCAL_IPV4 are missing from the PEER_NEW sub-policy dump=2E So a =
row targeting a BE attribute would be a silent false UNSUPPORTED there=2E T=
his doesn't affect us right now but might bite in the future=2E


File src/=
openvpn/dco_linux=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/com=
ment/0cd0a757_58070f5b?usp=3Demail :
PS2, Line 111:  */
CTRL_CMD_GETPOLICY,=
 CTRL_ATTR_POLICY, CTRL_ATTR_OP, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO/D=
UMP_MAX, NL_POLICY_TYPE_ATTR_* and NL_ATTR_TYPE_* need >=3D 5=2E10 uapi hea=
ders (https://github=2Ecom/torvalds/linux/commit/d07dcf9aadd6b2842b439e8668=
ff7ea2873f28d7 and https://github=2Ecom/torvalds/linux/commit/50a896cf2d6f3=
4e884a00139d6e6012c9833ace3)=2E

On Ubuntu 20=2E04 (5=2E4 headers) the buil=
d fails while RHEL 8's headers have them=2E Ubuntu 20=2E04 / Debian 10 are =
EOL, and on those kernels GETPOLICY doesn't exist anyway, so I'd simply com=
pile the probing out there: dco_probe_capabilities returns 0 and logs once =
at D_DCO_DEBUG that we were built without policy introspection, so a missin=
g feature can be explained from the logs=2E test_dco probably needs the sam=
e guard=2E

Note that these are enum members, so `#ifdef CTRL_ATTR_OP_POLIC=
Y` would always be false so it might need some configure check=2E


https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/f87e30da_4b82c73b?usp=3Dem=
ail :
PS2, Line 113: /* one row per capability; a row on a command of its o=
wn costs one more dump */
Might be misunderstanding this comment but it see=
ms like it suggests rows sharing a command share a dump=2E But they actuall=
y don't because each row gets its own socket and dump=2E

In this regard, r=
ather than one socket and one filtered dump per row, we could do a single u=
nfiltered dump of the whole family (~5 KB / 77 messages on linux 7=2E3) int=
o a small table, and resolve every row from that table afterwards:

```
str=
uct ovpn_pol_attr { uint16_t policy, attr; int type; int nested_idx; };
cmd=
_do[cmd]  -> policy index (from the CTRL_ATTR_OP_POLICY messages)
attrs[]  =
    -> one entry per CTRL_ATTR_POLICY message
```

The callback then only r=
ecords what arrives, and resolving is a lookup on complete data, so "not fo=
und" really means not found=2E If I'm not overlooking something, that remov=
es the ordering reasoning and `unclassified` altogether, uses one socket an=
d one round trip however many rows there are, and is easy to unit test (bui=
ld the table, check the answers)=2E WDYT?


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1981/comment/e94ca365_c84b55d7?usp=3Demail :
PS2, Line 114: str=
uct dco_capability_req
nit: The struct is internal to dco_linux=2Ec and eve=
rything around it is ovpn_cap_*, so ovpn_cap_req would be more consistent=
=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/a97a8711_546b=
0c0d?usp=3Demail :
PS2, Line 114: struct dco_capability_req
While looking t=
hrough the kernel netlink code, I noticed that big endian attributes were n=
ot reported in policy dumps until 7=2E4 (https://github=2Ecom/torvalds/linu=
x/commit/b785f5c56fb3dbe70635592b11547a2c828e95b3)=2E This is not currently=
 a problem for us but I would document which attribute types can be probed:=
 BE16/BE32 attributes missing from policy dumps before 7=2E4, and UNSPEC/RE=
JECT ones never appear=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981=
/comment/336b48e1_7b289ed5?usp=3Demail :
PS2, Line 164:     if (nla_parse(t=
b, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg_attrlen(ghdr, 0), NULL=
))
nit: no policy is passed, so nla_get_u32 later reads attributes whose le=
ngth was never checked=2E The data comes from the kernel, so the risk is lo=
w, but I think a minimal policy declaring the u32 fields would cost almost =
nothing=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/4efd2e=
ac_82e48a04?usp=3Demail :
PS2, Line 227:                 query->unclassifie=
d++;
If the requirement's container attribute doesn't exist in the command =
policy (imagine a future capability adds a new nested attribute to PEER_NEW=
 and we run on an older kernel), `sub_policy` never gets set, every later p=
olicy is counted here, and `ovpn_cap_resolve` returns UNKNOWN instead of UN=
SUPPORTED=2E I reproduced this on all kernels with GETPOLICY using nested=
=3DOVPN_A_KEYCONF on OVPN_CMD_PEER_NEW (unclassified=3D8/9/13 -> UNKNOWN)=
=2E With the follow-up patch that becomes a spurious M_WARN on every start=
=2E

Additionally the counter guards against an order the kernel never prod=
uces because policies are numbered breadth-first from the doit policy (inde=
x 0) and dumped in index order, so the command policy is complete before an=
y other policy arrives (https://elixir=2Ebootlin=2Ecom/linux/v7=2E4-rc1/sou=
rce/net/netlink/policy=2Ec#L126, https://elixir=2Ebootlin=2Ecom/linux/v7=2E=
4-rc1/source/net/netlink/genetlink=2Ec#L1711)=2E

I'd drop `unclassified` a=
nd cite those functions in the comment, or move to the single-dump table, w=
here the problem disappears=2E (nit: it counts messages, not policies)


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/f919a1fa_c35b313e?usp=
=3Demail :
PS2, Line 271: ovpn_cap_ask(const struct dco_capability_req *req=
, struct ovpn_cap_query *query, int *perr)
Nit: `req` is always `query->req=
`, so the parameter is redundant=2E


https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1981/comment/983deecf_471fe21c?usp=3Demail :
PS2, Line 299:          =
            NLM_F_ROOT | NLM_F_MATCH | NLM_F_REQUEST, CTRL_CMD_GETPOLICY, 0=
))
Nit: NLM_F_ROOT | NLM_F_MATCH is NLM_F_DUMP, and genlmsg_put already add=
s NLM_F_REQUEST=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/commen=
t/21f17eae_aaae11dd?usp=3Demail :
PS2, Line 299: CTRL_CMD_GETPOLICY
Nit: CT=
RL_CMD_GETPOLICY does not autoload the module (only CTRL_CMD_GETFAMILY call=
s request_module) and with ovpn not loaded the dump fails with ENOENT=2E Th=
is works because dco_available -> resolve_ovpn_netlink_id has already run, =
but I would state that dependency explicitly=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1981/comment/4565a3b6_802f6485?usp=3Demail :
PS2, Line 3=
47:  */
This comment reads as if there could be a retry but dco_caps_resolv=
ed is set unconditionally, so an UNKNOWN is cached for the lifetime of the =
process exactly like UNSUPPORTED (and the follow-up patch treats it as unsu=
pported effectively)=2E I would either leave the cache unresolved when any =
row is UNKNOWN so that a later call asks again, or drop the claim=2E As it =
stands the third state only changes the log message so its purpose is not c=
lear=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
81?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0051effe=
7f0636e30557d9ce92c50c458002f9e6
Gerrit-Change-Number: 1981
Gerrit-PatchSet=
: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Li=
ci <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Comment-Date: Wed, 18 Nov 2026 15:57:54 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--h/ZgvYeTAnE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Ralf Li=
ci has posted comments on this change by Gianmarco De Gregori=2E</p><p>Patc=
h set 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">Vie=
w Change</a></p><p>11 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1981?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The ap=
proach looks right to me and the unit tests are well targeted (especially t=
he &quot;same attribute id in another policy&quot; one)=2E Aside from test_=
dco, I also ran the probe code from this patch against real kernels:</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">    kernel                               builds  PEER_ID  TX_ID =
  absent container<br>    Fedora 7=2E3=2E3 (in-tree ovpn)          yes     =
SUP      SUP     UNKNOWN (*)<br>    Ubuntu 25=2E10 6=2E17 (stock, no TX_ID)=
  yes     SUP      UNSUP   UNKNOWN (*)<br>    RHEL 8=2E10 4=2E18 + ovpn-bac=
kports      yes     SUP      SUP     UNKNOWN (*)<br>    Ubuntu 20=2E04 5=2E=
4 + ovpn-backports    no (1)  UNKNOWN (EOPNOTSUPP on every query)</pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">    (*) should be UNSUPPORTED, see the inline comment on unclassi=
fied<br>    (1) uapi headers too old, see the inline comment on the headers=
<br>    <br>@gert@greenie=2Emuc=2Ede: you won&#39;t be able to test this co=
de on your good ol&#39; 20=2E04!</pre><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Something to keep in mind for future=
 capability rows (which I&#39;ve also mentioned in the inline review) is th=
at before Linux 7=2E4 (which is yet to be published) the policy dump silent=
ly omits NLA_BE16/NLA_BE32 attributes (fixed by net-next b785f5c56fb3 &quot=
;netlink: policy: report the big endian attributes&quot;)=2E On all current=
ly available kernels REMOTE_IPV4/REMOTE_PORT/VPN_IPV4/LOCAL_IPV4 are missin=
g from the PEER_NEW sub-policy dump=2E So a row targeting a BE attribute wo=
uld be a silent false UNSUPPORTED there=2E This doesn&#39;t affect us right=
 now but might bite in the future=2E</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1981/comment/0cd0a757_58070f5b?usp=3Demail">Patch Set #2, Line 111:<=
/a> <code style=3D"font-family:monospace,monospace"> */</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">CTRL_CM=
D_GETPOLICY, CTRL_ATTR_POLICY, CTRL_ATTR_OP, CTRL_ATTR_OP_POLICY, CTRL_ATTR=
_POLICY_DO/DUMP_MAX, NL_POLICY_TYPE_ATTR_* and NL_ATTR_TYPE_* need &gt;=3D =
5=2E10 uapi headers (https://github=2Ecom/torvalds/linux/commit/d07dcf9aadd=
6b2842b439e8668ff7ea2873f28d7 and https://github=2Ecom/torvalds/linux/commi=
t/50a896cf2d6f34e884a00139d6e6012c9833ace3)=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">On Ubuntu 20=2E04 (5=2E4=
 headers) the build fails while RHEL 8&#39;s headers have them=2E Ubuntu 20=
=2E04 / Debian 10 are EOL, and on those kernels GETPOLICY doesn&#39;t exist=
 anyway, so I&#39;d simply compile the probing out there: dco_probe_capabil=
ities returns 0 and logs once at D_DCO_DEBUG that we were built without pol=
icy introspection, so a missing feature can be explained from the logs=2E t=
est_dco probably needs the same guard=2E</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Note that these are enum membe=
rs, so `#ifdef CTRL_ATTR_OP_POLICY` would always be false so it might need =
some configure check=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1981/comment/f87e30da_4b82c73b?usp=3Demail">Patch Set #2, Li=
ne 113:</a> <code style=3D"font-family:monospace,monospace">/* one row per =
capability; a row on a command of its own costs one more dump */</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Might be misunderstanding this comment but it seems like it suggests rows =
sharing a command share a dump=2E But they actually don&#39;t because each =
row gets its own socket and dump=2E</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">In this regard, rather than one soc=
ket and one filtered dump per row, we could do a single unfiltered dump of =
the whole family (~5 KB / 77 messages on linux 7=2E3) into a small table, a=
nd resolve every row from that table afterwards:</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>struct ovpn_pol=
_attr { uint16_t policy, attr; int type; int nested_idx; };<br>cmd_do[cmd] =
 -&gt; policy index (from the CTRL_ATTR_OP_POLICY messages)<br>attrs[]     =
 -&gt; one entry per CTRL_ATTR_POLICY message<br>```</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">The callback then =
only records what arrives, and resolving is a lookup on complete data, so &=
quot;not found&quot; really means not found=2E If I&#39;m not overlooking s=
omething, that removes the ordering reasoning and `unclassified` altogether=
, uses one socket and one round trip however many rows there are, and is ea=
sy to unit test (build the table, check the answers)=2E WDYT?</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/e94ca365_=
c84b55d7?usp=3Demail">Patch Set #2, Line 114:</a> <code style=3D"font-famil=
y:monospace,monospace">struct dco_capability_req</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">nit: The struct=
 is internal to dco_linux=2Ec and everything around it is ovpn_cap_*, so ov=
pn_cap_req would be more consistent=2E</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/a97a8711_546b0c0d?usp=3Demail">P=
atch Set #2, Line 114:</a> <code style=3D"font-family:monospace,monospace">=
struct dco_capability_req</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">While looking through the kernel netli=
nk code, I noticed that big endian attributes were not reported in policy d=
umps until 7=2E4 (https://github=2Ecom/torvalds/linux/commit/b785f5c56fb3db=
e70635592b11547a2c828e95b3)=2E This is not currently a problem for us but I=
 would document which attribute types can be probed: BE16/BE32 attributes m=
issing from policy dumps before 7=2E4, and UNSPEC/REJECT ones never appear=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/=
comment/336b48e1_7b289ed5?usp=3Demail">Patch Set #2, Line 164:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (nla_parse(tb, CTRL_ATTR_MAX=
, genlmsg_attrdata(ghdr, 0), genlmsg_attrlen(ghdr, 0), NULL))</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">ni=
t: no policy is passed, so nla_get_u32 later reads attributes whose length =
was never checked=2E The data comes from the kernel, so the risk is low, bu=
t I think a minimal policy declaring the u32 fields would cost almost nothi=
ng=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
1/comment/4efd2eac_82e48a04?usp=3Demail">Patch Set #2, Line 227:</a> <code =
style=3D"font-family:monospace,monospace">                query-&gt;unclass=
ified++;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">If the requirement&#39;s container attribute doesn&#39;=
t exist in the command policy (imagine a future capability adds a new neste=
d attribute to PEER_NEW and we run on an older kernel), `sub_policy` never =
gets set, every later policy is counted here, and `ovpn_cap_resolve` return=
s UNKNOWN instead of UNSUPPORTED=2E I reproduced this on all kernels with G=
ETPOLICY using nested=3DOVPN_A_KEYCONF on OVPN_CMD_PEER_NEW (unclassified=
=3D8/9/13 -&gt; UNKNOWN)=2E With the follow-up patch that becomes a spuriou=
s M_WARN on every start=2E</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Additionally the counter guards against an o=
rder the kernel never produces because policies are numbered breadth-first =
from the doit policy (index 0) and dumped in index order, so the command po=
licy is complete before any other policy arrives (https://elixir=2Ebootlin=
=2Ecom/linux/v7=2E4-rc1/source/net/netlink/policy=2Ec#L126, https://elixir=
=2Ebootlin=2Ecom/linux/v7=2E4-rc1/source/net/netlink/genetlink=2Ec#L1711)=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">I&#39;d drop `unclassified` and cite those functions in the comment=
, or move to the single-dump table, where the problem disappears=2E (nit: i=
t counts messages, not policies)</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1981/comment/f919a1fa_c35b313e?usp=3Demail">Patch S=
et #2, Line 271:</a> <code style=3D"font-family:monospace,monospace">ovpn_c=
ap_ask(const struct dco_capability_req *req, struct ovpn_cap_query *query, =
int *perr)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Nit: `req` is always `query-&gt;req`, so the paramete=
r is redundant=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1981/comment/983deecf_471fe21c?usp=3Demail">Patch Set #2, Line 299=
:</a> <code style=3D"font-family:monospace,monospace">                     =
NLM_F_ROOT | NLM_F_MATCH | NLM_F_REQUEST, CTRL_CMD_GETPOLICY, 0))</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Nit: NLM_F_ROOT | NLM_F_MATCH is NLM_F_DUMP, and genlmsg_put already adds=
 NLM_F_REQUEST=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1981/comment/21f17eae_aaae11dd?usp=3Demail">Patch Set #2, Line 299=
:</a> <code style=3D"font-family:monospace,monospace">CTRL_CMD_GETPOLICY</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Nit: CTRL_CMD_GETPOLICY does not autoload the module (only CTRL_CM=
D_GETFAMILY calls request_module) and with ovpn not loaded the dump fails w=
ith ENOENT=2E This works because dco_available -&gt; resolve_ovpn_netlink_i=
d has already run, but I would state that dependency explicitly=2E</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/4565=
a3b6_802f6485?usp=3Demail">Patch Set #2, Line 347:</a> <code style=3D"font-=
family:monospace,monospace"> */</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">This comment reads as if there c=
ould be a retry but dco_caps_resolved is set unconditionally, so an UNKNOWN=
 is cached for the lifetime of the process exactly like UNSUPPORTED (and th=
e follow-up patch treats it as unsupported effectively)=2E I would either l=
eave the cache unresolved when any row is UNKNOWN so that a later call asks=
 again, or drop the claim=2E As it stands the third state only changes the =
log message so its purpose is not clear=2E</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3De=
mail">change 1981</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1981?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1981 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gianmar=
co De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 15:57:54 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--h/ZgvYeTAnE=--


--===============7221697913320973959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7221697913320973959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7221697913320973959==--

