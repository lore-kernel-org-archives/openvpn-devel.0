Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B99606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y16g97gB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VT6DrCiE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aKbZK/sw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GTowoREv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mHMEffABLYAO2AUyyJUKqu7ILHemL2rTkC8wbIK9dl0=; b=Y16g97gBA6VXyMlkAk8eHG4xtF
	3F/IzxhrnZF/aU96O0/bqgGYrzs8zRVjZGsXXl8SHOeP66frkpz+IPx8VtO1WfbBDQtMxagtA3Y3L
	9N4Soz8XOZpLzAMEipo+EcgYPZgOMADzlL3G3gnKzEf2dhfaxv7qd1mkEOicUgLAXQuo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOqSc-000000001vS-0F8X;
	Thu, 05 Nov 2026 05:56:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOqSa-000000001vM-33Aa
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/FWqZ6q0AzYGPCtZ2oMpq4Sp+0/lYRAiSDPF7EB8P1k=; b=VT6DrCiEqrcTFkn0L0E78G1SWe
 EADZt2yj39V516zML4VUF8So6IgMLY+s14ZF2k56Aut8T3EXUohEZw9Zp/+pOPvMdHvzbsafNUGg1
 mVnim1B8OWFDMlMr2TY7/cerwBL3YTUF6vv3ahxXvuSf7RC0fHxXLetSLd5Y4Ec4oHuI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/FWqZ6q0AzYGPCtZ2oMpq4Sp+0/lYRAiSDPF7EB8P1k=; b=aKbZK/swrPI35hZbLgbrO3qbIV
 PmoGolrDdY0rWmQ10bhcEpMcr4OQWU/ytq8icFAHyUBJs77QLSKlY8KG/iK5oSaGcK3ORDyoChW1G
 V0ztUqXWUHgg3tBb9m3u0GCT9cFKclOE702xfxBoXSgt1Yy0CngBzD5hDZx/ai3TZ2Qc=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOqSa-0000000067k-0Mxa for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:56:28 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso122911f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 21:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793858181; x=1794462981; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/FWqZ6q0AzYGPCtZ2oMpq4Sp+0/lYRAiSDPF7EB8P1k=;
 b=GTowoREvQFhRXn2jUwgzS/m3idiM7IODCgX7eyANl4nR35Ct+oMZqHtlWK5C+4SYyY
 Sb2dZW3P+O4fkN8GO5oXJCFWl8GXiaVJZKfy4z1DqIUfP9dweyxZLa0GTR/Mjw8CO46G
 Lk7yrmlaaihrkVtLQERqiyaDny5DSObBqi8X25PrYV9/33GlRJIDLQUigMKk79xuenVY
 R1jGfE26Dh9YQI/x65qlApFzRL3S5DnwuT71JIpewkfnwI6uaBKfd5oZAc13Ak5GVGl1
 wwci/jvnrlL9FB4yJE9m0/v7DRP/itsS9d7PrHj/9MPWA3UgDOy26tU2YgMJTkoeQ/ES
 Qa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793858181; x=1794462981;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/FWqZ6q0AzYGPCtZ2oMpq4Sp+0/lYRAiSDPF7EB8P1k=;
 b=rfwMZe7Sz+Pf3XdTw7vwrQW5F1HsjDTdblHesg0VU7cJraX8b7Jp5gq0RW90cLdS2y
 2YMqrvafBZ1JJhCyP3RYj8mdR7IdJwSMYgCrwh6ZuIR2BqjlTVlUNhipQ25EeyIaWuro
 y6HLNaz/MOFxfSn+C2wNc27Qm5hRbVwpib6w7GzakIMLAaRSHTa02oKA7nbDQqGImL23
 fOCpiBEp77wQnngqKPf7qyHCQlkjNwOUBylt7afAYeLJm4KA8Lm7DQedb3wnn5Og5bqp
 /fPqF3v+cIbIsRQkkjB51NLJXHurXjwVMKK2LdtkI2zJ0i7T+z86ba2b6QBTG/GWwW/X
 KuTA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfzDEqgnGdcIqfMiYw3sUMb8F+zxKfvoOxhcDArAz5+LNzTDLvxAXPo+EvG5J+Kgdr+01+hAwqW9nEdDe3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+IMkuRUP6F3PB3wz769v20pdGuvvY+HWqjFdY5AhxWbKd0ulfr
 QWlBZyQj3Q16LNuXD1bI48/QPoLo88Nzp6G/X54rWjbrevetRBucjhUltBKJP26NiINrxuO2Shl
 KSYk2kh0z3LwgX/MltPFsCthf293ZEew4WlLuUpNZvKwXqCVA+l6WE7ACqt6lliSO2eKO
X-Gm-Gg: AYBFou1K5cAcDmfuZjjmG67SCHOeWN/qEXHX7hzVl3qpzCw+JU2cjZVsFAiERnXdgwA
 9v5yDpWMFvdnuCecQQ5R+Y2r0pmfN6ex4dKT8pqt3ysVRnTvJ16EOo3cJswELHt/WpwDNDyQYIk
 sEXdbQZ09BquitPXbDQGPWUW2B9omzSQat0ontGk82KYic4RbfsHXJpj/8PCN/KoQFyOrwjr6zK
 GhIQypq0LnxPMK7prxFflPpZgOC4hliXd5TlPc5nyDXsKljHP/iebgfCBzKE4UpB5rD2ZbADVY1
 ECl9oRFSDxSh5gAyeXvPT42YaSSt/drrJkldhq4i378jcvYQqwq8oqAcNDLS8X8o598M+ObMU/U
 pL1fmmLj35jat4nReGqxn1YUr2CmdoPGON0jWcg1ITagVv3NFbD9H8hIraHKIzQkt1Ubu+1E353
 B6d1Ux6F/KtgphE1B1qOyWvh94QvHAUwyUEycshSTIL3yg8JCUJtc3TfSlgxK0iKZG1qrupHckz
 NvI3RjuEjktv1PBI92j/apw7bmEqfezOD8CbOWf1IxxxPvp4xM3ileW3f+x0Pljxc4TERN8vIyi
 klGqy0TVQBqhcRNVWA+MxHuBdWi517LOPqxqWRcU71GLRGxNc7NSIHmP0j9Mq/wz7PQ9OevctaV
 AQfrAOI1eWuPWnAdzrhe1pcVypQXO18PPbiHw7rhE5RAd63x0ugSZ/55yXqleOZMfV683+AeAGM
 P7Bkksc5uMg0TE7A==
X-Received: by 2002:a05:6000:993:b0:48e:76ab:78f3 with SMTP id
 ffacd0b85a97d-49116537314mr2608873f8f.15.1793858181253; 
 Wed, 04 Nov 2026 21:56:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feea5d4e4sm7604937f8f.57.2026.11.04.21.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 21:56:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 05:56:18 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
X-Gerrit-Change-Number: 2060
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2060?usp=email>
X-Gerrit-Commit: d05b45d95c175c9b892c157f6c4e3fa6283a7ba6
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 05:56:18 +0000
In-Reply-To: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
References: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkk3NWJhNzdmY2JiMTE3OTBjN2NjODZjYzQzNmZjNzVmZjk5YmQxYzllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cada127abb46cf2093a66af35ebeb08ce7fcda6b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOqSa-0000000067k-0Mxa
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE:
 centralize virtual address changes in update_vaddr
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2212971483179043683=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2212971483179043683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4zU25v2EnIU="; charset=UTF-8

--4zU25v2EnIU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail )

Change subject: PU=
SH_UPDATE: centralize virtual address changes in update_vaddr
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I75ba77fcbb1179=
0c7cc86cc436fc75ff99bd1c9e
Gerrit-Change-Number: 2060
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu,=
 05 Nov 2026 05:56:18 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--4zU25v2EnIU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 2=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">ch=
ange 2060</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2060 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Thu, 05 Nov 2026 05:56:18 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--4zU25v2EnIU=--


--===============2212971483179043683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2212971483179043683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2212971483179043683==--

