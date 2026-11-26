Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22E606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=STqPuHng;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b2InFI7c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ly7jJuUB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XRHXnVoP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WB/TpPR/W38i3EobFXrcaTrd0RVMGjpBlV/3aRDjPto=; b=STqPuHnghUi983bs1GQtfWtynm
	dVFHsaKl7IDIRQnWo1YARwIqF3xJOZ7FN62ChQOkNsi3pDgiEs5wAlw22Nig+xR4t6lTT9e/KriZv
	JWTRsDfLBehr1XGmyuLzmwngiMDW8zKqnDkNxCk19ScEJBJ/YIh8fHoGbtrivQyBMFyM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTtr-0000000058P-1spu;
	Thu, 26 Nov 2026 07:28:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTtp-0000000058G-3euO
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BEkHzLjW1Bk0NN4Uo/iZZuXIh2EJFbQQyhbzQbqDRsI=; b=b2InFI7cwoenuNzhUh9RxZm4h5
 aYcHL0B4fC8KyCHyuyyL9lgwGSRUQIBU53g7k8dnhe7vl1I155sKe6dkBO2Ym/PN2H6f81yTBjW+k
 MLOpNVfLvTiZRAJ0EtMiSfALYI7iMMa+opZXrHah6s4e4pzKiSn7OfmfKf5m5+3hlMOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BEkHzLjW1Bk0NN4Uo/iZZuXIh2EJFbQQyhbzQbqDRsI=; b=Ly7jJuUBXgyr1YQ8d65gkL596p
 3bUqAaK8cQ4alRMeTLFXtmUTfe7+S/pu+bAkZuRo4qFIsbXPTtUdp7tyMDQ1WjVG2g+iMcqRx1bWX
 1Sbu+E480mBXvD09rYswq6+RzL8vA2A8gWunxK8Zz67WcewfvPQodtkP53lwIly4okD8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTto-000000008CJ-29JN for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:28:09 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so41319405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795678082; x=1796282882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BEkHzLjW1Bk0NN4Uo/iZZuXIh2EJFbQQyhbzQbqDRsI=;
 b=XRHXnVoP4Fm/TjSb/cujdFVS8HOEfF7FXcBBaPqKgOLxqrpa3a6ipVNuQlbLF2oEqU
 BK6ShbN9T/8XGClPS1wNOi5yCqpEkC0tAZjJCRLGpTIIAQ8soqZHMZVgbUnCCnTF10uv
 XZ16rnekGoWNmirb0XVse1HTjjni3Gi7kRZWkFxbWYSyJXfF0g1Rs1KXeWXWRv9Ww4tq
 GwYcaHF5lDWGpmWR2SXfHPKKH4QCJ9omd90ZKVOFApCbKcMqRN31V3npD7DKbqmLxD5W
 9PttTf045Ef0gUH2pzHiGoYgzBprhnMr+oSTOKNjB24duQaMz4Mr4lMfgFvOpOmtBTsU
 NI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795678082; x=1796282882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BEkHzLjW1Bk0NN4Uo/iZZuXIh2EJFbQQyhbzQbqDRsI=;
 b=pFa9N7Zlv8HOvU1qxOSysYu0EkubMAIxE1jnwQ/e9HKk+3A6bUR6etTJDbw+Ybe5Sq
 x26/Oe7a9lbW0KUWS7AVYc2HHGgHoghJ76RFN/96FgLmYSdPdRbau+TghWiyz9QEtO2i
 9NOR3/z5E7gisv9ADLWGi2MyBRdgpraPIH3y/1kJkDSnJ8clI8PPS8bf4oyZqAf3PsCG
 qMMHudIE5oNqlsZTFycyHKBYAP+VvmpbbvRMGtwzXDRkYBI2HjjjMW2W44/BCxTkc/p0
 C/soH8jpOlWtZgKJaXy9jvAdGGH8hSjr/JTZ7YThk3cW5Df0vBYoCgJQwtphrFGkY7KK
 MsKA==
X-Forwarded-Encrypted: i=1;
 AL+hErEO36yefIazmurQX0/lrS5lnUkaaiTlovN3RT0/wXx2Jg3UdGlhGe8PLYxA7/iH/BUFc8fPeeqLRPZUuhxf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+XtgbPlhit7E78UiBTr74RVJUZ1mhQiKIgTDdyq+cr0Hv0YlyW
 GmmbQOgm1qo0BSlHPRAQhWG8L/gJz5IuzzXcrAARcAD4jNgKdEJIHqsGz0+Plfnh/PfsORQUGJH
 x+l/IPZJmaJvcOENCMBnjKjyn5Lk99ni7HiZd5bV+6lum1Z1K+z8+nkQ6o7xsWPXDBukO
X-Gm-Gg: AZFdTZcM/0bCxcq7JtjPq10p9uWjLB1GXWPul762v6k16oe4WI3Lww5T8R09RTuWjlL
 7sdyZhntiCgIBknibObQQ6Pre4oxnxQo7peCUpRcyY8DhBgxT7q9U/inhMoGMoDp5PXXgK8VMdx
 zQsfya457Mwr0yKf0Vc4XqOu0z38y+edFqJCdfuoaCzjFBPVUs24sMvT/gCb4zsMygp2Xsrkyj1
 RraS3moubSxX4jIgq07pm4RjGI3Dwb1/Y0wK+F7ljZ/B2ot/LGapPUdofBOFmkr4JENRLMa+xtg
 GWuClNR3HIrmEtuytmIOKSnHpmcLITL+a4U+SOKQKBRGINEHq06L+7b8pX94/f6RZfFZUCrxUdB
 7tmh2KTGhQqvQz+EazIj0vG/OfUMAcGd8ggGnygzXbpoq+q6FC00Q+rMldCcfiC074qmxqz/4s1
 8pzKYYCxQPWpCwVV1CBeaXD7/PcDIIbgr0wdujpd+gP+irO4+UY9G2wkGLwNzidvXMv9jy1g8iD
 +q1nuUwYrlES5U+O5iRnwDiTV8spLixWko4j974lKT2TT/06UzKxQzy6AMjjOiuwVKxB2JV7MPq
 a8Mv7FkCwCb8wVumEQnARm0N5fc146tAsDItUzNKQZ3ThfnXVpNoOxnLpZknnkf0I60s9uAPUgb
 OBZWQIWeP2ub4/Xnxp0MnaCsjKaPmMZU2rWQw4JFtDjlWewCui5IFqZeysdMkIGFYqodN5jwX5L
 x20Om3ACfqH3SsFbo=
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb887c3428mr405592595e9.1.1795678081808; 
 Wed, 25 Nov 2026 23:28:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bbab390cf5sm52381775e9.7.2026.11.25.23.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 23:28:01 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 07:28:00 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: b1a80291769a90ec1763a5b2b2120adba051e3ba
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 07:28:00 +0000
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10398c30418ee26721ede525eee348d68dbc45d1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWTto-000000008CJ-29JN
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2199128639968806992=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2199128639968806992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/2YWsJGIdMY="; charset=UTF-8

--/2YWsJGIdMY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Heiko Hund has poste=
d comments on this change by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2348?usp=3Demail )

Change subject: dns: pass dns vars to the =
updown runner via pipe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/dns=2Ec:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348/comment/009c2634_56834595?usp=3Dema=
il :
PS2, Line 606: dns_vars_setenv(char *vars, size_t size, struct env_set=
 *es)
> Done
You would need to be in control of the unprivileged openvpn pr=
ocess to inject these, but yeah=2E Why not prevent it, it could happen and =
then we have an additional layer of defense=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2348/comment/cbededc9_8042d984?usp=3Demail :
PS2, Line 6=
26:         setenv_str(es, var, eq + 1);
> Done
Same as above, this needs a=
 misconfigured and broken openvpn to happen, but not unthinkable=2E



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5=
729915ed77c438441
Gerrit-Change-Number: 2348
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Thu, 26 Nov 2026 07:28:00 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>

--/2YWsJGIdMY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund has posted comment=
s on this change by Heiko Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2348?usp=3Demail">View Change</a></p><p>2 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/dns=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348/commen=
t/009c2634_56834595?usp=3Demail">Patch Set #2, Line 606:</a> <code style=3D=
"font-family:monospace,monospace">dns_vars_setenv(char *vars, size_t size, =
struct env_set *es)</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Done</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">You would n=
eed to be in control of the unprivileged openvpn process to inject these, b=
ut yeah=2E Why not prevent it, it could happen and then we have an addition=
al layer of defense=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2348/comment/cbededc9_8042d984?usp=3Demail">Patch Set #2, Lin=
e 626:</a> <code style=3D"font-family:monospace,monospace">        setenv_s=
tr(es, var, eq + 1);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">Done</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Same as ab=
ove, this needs a misconfigured and broken openvpn to happen, but not unthi=
nkable=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">change 2348</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0d772af38b66799=
499b1b5729915ed77c438441 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2348 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigen=
tlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 2026 07:28:00 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--/2YWsJGIdMY=--


--===============2199128639968806992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2199128639968806992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2199128639968806992==--

