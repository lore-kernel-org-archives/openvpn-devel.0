Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066E606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PdFinJRd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GPunC2XS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G+EAVak5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZJP7fbIQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j4XnQHuR4U0yLI6JcI2dt9D+BTuhxcaUs9ryiPMn4h4=; b=PdFinJRddqBi+Gj+JxYyyd9VS4
	Jrkpe5j8knThNC9rxu6uCZLEoOIk9sCIWw+yURvY/+lUxbSctt234jRiz4/wqnUwCFgaPJzXm4+a5
	YIvpkBliOcMXfFlN7ipZXGc96t8o56IWs8C+4RE5FNIO7Zzpq3t0KcQ1/7sROK0iP204=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW8dK-000000001WJ-3KTU;
	Wed, 25 Nov 2026 08:45:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xW8d1-000000001Vz-2M3r
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 08:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZu58+2t2moLt/J5Po4ZHbhhC6z2RHyov3o2s4wLTR4=; b=GPunC2XSfFoIiDfyEeJRYq2lGt
 6iwv1spj7Ca2BRzqCn2V1FYBUQaf4SY7hSOJu9AcgzGiWuYCMXJQQzNbM4chE9UzV1MJaaiIZ3tRf
 SIaYSC8KYnlN+Vi0P8XYMRzsAvn546INSpyJ+BPDN4rXhlxQNRtHOEJqnvfKgeW+347k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZu58+2t2moLt/J5Po4ZHbhhC6z2RHyov3o2s4wLTR4=; b=G+EAVak5VSD5AaYd87cqQXJbyq
 s1/4Uv8Lrywkdgf5X3mCwhgOZ4qcAAwraXIW5dPV8Y84AZzTHzxx+gC1BeKpiicAQywd9gjpoKp6f
 4v34ebvX+n4GfEB96SWSGg+SdSB/4rzxD3+M55DAKu9DwS2koYIXnnpxqHP+cnN05W0k=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xW8cu-0000000011P-1uxN for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 08:45:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so34509495e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 00:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795596310; x=1796201110; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LZu58+2t2moLt/J5Po4ZHbhhC6z2RHyov3o2s4wLTR4=;
 b=ZJP7fbIQ0r2W5iAj5KcB6hUwNWy6W67CwBDLNN5h0nFMY4AkG0uQJjdv7aRpw0IlkA
 SWmisFqiMC9x+0Zq+x1GgUrCeIRYATHRApMDq9XV/bTv0Jygsjum5hyPu1wRkn7ak9Vw
 mzeKDPrcIRhBo2TvZ+BnE5MQBo8FKS8JnUqLhO75tZIw0r5WICS1LUTaBPRGTYcfs1aV
 +yrdHayy+j8WRLagMuGhuYzYMqkQO9E8/dwx2ukdL03Tb/NLYIKO8R48MnV/hS48zW9k
 yLBknQ4rApEJ1y34yFDrff64sVwluFjEu2L8oK+Muk6Ab+GzPTxJfSq+n7X22OXlN08d
 MwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596310; x=1796201110;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LZu58+2t2moLt/J5Po4ZHbhhC6z2RHyov3o2s4wLTR4=;
 b=y1X03iDUpz2rvcgVfcm4ExqizZcQeGZJ3frXtBpR3JPGlvSYyoAFVWGVXKcf0CRZb1
 0B2I23vrm8Xd86Vo8QREILgtg+2mmmf3w6PhaReTytVseMXDgK1t0eKH5c72pK3KJYoJ
 bVNfBppmus3HROSFFAVkyOBjJHYEq2SJxWj4KDdY7pwB2P9uROmooH+ZehNSpojQRoQP
 t/YwVzFVNbyZJI+W41PIH+ZIIyeGfl5k9oNesNWCC9bbv19oIuXDsedqVM4a4WpszEvq
 2QHco9VwoQyQJADqVsX3FuSNUnQRiDVbQ2PgNs/riJaBnBYaVk9xPUhE6RIL1e6f6rJO
 u85g==
X-Forwarded-Encrypted: i=1;
 AL+hErHsqX3bSoqkaat0NWpA58tWjdx3JEgy8qf9pgBo6xrX51Jqg7f1nDNPnMGGxt6QXjZbi5ndH8+UcwPooPW8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/jzmn6DbNttJopSSVex7x4SqbBzpiDjHnz33buvip07h50MrMi
 lIJMIPc3MAJq/mn98cwvMf+OEyaqn71P/MzBkN0N5ScxL30bAd06xN2SrGZPFelto6+O51GU1sP
 7fMQ/fCZ33MV6WiTzq+r9HAijz+fN6TCg0ZnOMwRonkljtKV8f/5nRCa7okai1a8XPtCtOYTM/8
 4YIx4vvA==
X-Gm-Gg: AZFdTZf552BumW3EF1R0upz01iX7C0YfJL6bDCibayP9PDDhnA2PEYBWSrzWXAi54Ex
 VY8f4LClBPAmJjNtYuhBhnDShrJKXA1Icg91WttxRKZZB8WXlj6Vp44SYPFTp7bZmmUoWRh7rge
 BUBdKS3g02zL2zbad+UQ+rmnzHxm8EbZe7dMO0uhHJ5qZZakPlr8+EJMYjY2dhexFtuMiUTZA8C
 OkZRBVI+mj/NxF3O/zK3HTjugxobBAA89sGaUFlEWhb5vuJhGD+SvuhEEZlMPkqgH5cYNzZ5Ur6
 NgBDQd1Mgm73XAY073m8rv8vAIRg2YCQmRNWpiXIA/4OMkcAj9fNHRPAawaUos9zeXyw1qY2EvL
 rl1eg1jbh9wPtGTpiGZSdGguYFQy/HfxJ7Mzndrd0FC1tGZhPdWx08i90lBl8HxiNvnUvKXDM6T
 bvCdFntBPCyo0IHyxIfIJzFs1OlX3r3qLdm6+5wq6yCx5aYvzpWypNl9vUXHNdBiam5YZPsBFE3
 NaoUxm5/5J/TpngCglB+TWVwCH92mvIvb1T7WFwlb1WtXpU8I470PnzviCbREYlwo6q1rGLmiZc
 qtXPbifdUW6EBlrfSVb0HRHjLY3KcOULijpfLWBYYu6Wc3fxN66A01uv/tKfXf45N+LbjvzMzXP
 9dJRDofYxkp1kNKnjl1WIYiwtbykjRxVa1GzepFS+Wk+8mtY/S7JQRSB1offKQSXQvpb6kBeuVY
 RmdctH23pXqkIlOtg=
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr332471105e9.12.1795596309659; 
 Wed, 25 Nov 2026 00:45:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm489316905e9.10.2026.11.25.00.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:45:09 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 08:45:07 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: 01aa79f87f54bdbecb8f7a160c6ea0f8965ed29c
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 08:45:07 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0017f201a0a0d81b17b80f1b6afd9420d84047c1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xW8cu-0000000011P-1uxN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4330964649498206529=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4330964649498206529==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x9NsE/cMhIM="; charset=UTF-8

--x9NsE/cMhIM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Deri Haerudi=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject=
: dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew-1

(2 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2341/comment/e24922b6_7a7ef5b0?usp=3Demail :
PS1, Line 19: the unpriv=
ileged process controls a file root will execute=2E
(b) is not really achie=
ved=2E

`dev` passes the allow-list with no check on its value, then the sc=
ripts paste it into a `sed` script, so a vars file still gets code run as r=
oot=2E

We could either check `dev` in the reader and say in the message th=
at the C side still trusts the path, or just drop claim (b) from the messag=
e=2E


File distro/dns-scripts/haikuos_file-dns-updown=2Esh:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/adfaffaf_f7b4b711?usp=3Demail :
=
PS1, Line 53:     [ -r "$_f" ] || return 0
This should be `|| exit 1` - oth=
erwise we are letting the script carry on with `script_type` unset=2E



--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d7628=
58e754adc82f42d4371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Deri Haerudi <abcderyscreenprinting@gmai=
l=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Comment-Date: Wed, 25 Nov 2026 08:45:07 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: Yes

--x9NsE/cMhIM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Deri Haerudi=2E</p><p>Patch set=
 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Cha=
nge</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2341/comment/e24922b6_7a7ef5b0?usp=3Demail">Patch Set #1, Line 19:=
</a> <code style=3D"font-family:monospace,monospace">the unprivileged proce=
ss controls a file root will execute=2E</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">(b) is not really achiev=
ed=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">`dev` passes the allow-list with no check on its value, then the =
scripts paste it into a `sed` script, so a vars file still gets code run as=
 root=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">We could either check `dev` in the reader and say in the messa=
ge that the C side still trusts the path, or just drop claim (b) from the m=
essage=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File di=
stro/dns-scripts/haikuos_file-dns-updown=2Esh:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2341/comment/adfaffaf_f7b4b711?usp=3Demail">Patch Set #1, Line 53:</a> =
<code style=3D"font-family:monospace,monospace">    [ -r &quot;$_f&quot; ] =
|| return 0</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">This should be `|| exit 1` - otherwise we are lettin=
g the script carry on with `script_type` unset=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?=
usp=3Demail">change 2341</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2341 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Deri Haerudi &lt;abcd=
eryscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 08:45:07 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--x9NsE/cMhIM=--


--===============4330964649498206529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4330964649498206529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4330964649498206529==--

