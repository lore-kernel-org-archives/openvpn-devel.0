Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729DC4453A
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmHxiV2THcQcWU1R/qg/3LUD6zS5C5wjoM5ms4Ke7Lo=; b=MdZhb6+5UbH9nkl+QjyddI7OPQ
	jMVrrBLFibM7XIRNA9W/VoBVtNYWMeZVI6k6erO3U3Aws3Vy4Fm3AfduZMLEV+7pD3RPHBXeEdIdD
	lnBzojMcKDVrYJznRLXZuZXErcS/BwZ9nhPU56kccvaC9rw16nkRRRfTCZEuczLUQeOo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmb82-0004w0-Ud;
	Wed, 22 Jul 2026 17:53:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmb82-0004vu-47
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6d9JBgW6dOQjPddmdidL5TQ5LHiGQa1JkM/XhDJVEio=; b=CXXHSld5eMAZZMel3TfiHS/ZsG
 3qOBqnTXh/SPjSk21M9fshGi1YcurdxQcQD0dV27TUmFYme073AGnvuYUc9iF0qilKYH3/sVmxxvP
 e9ymoSyaDhUb0Tk7aZ+05ZdjuKntOjAYLdT8HwITywf6M64F8kgQUVBX8Lz/MN/uXPSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6d9JBgW6dOQjPddmdidL5TQ5LHiGQa1JkM/XhDJVEio=; b=P
 vB8hAVbIodclOntXsl8ZUpf0E01sINBPW4Bn/50bgu2QnwB5hOMW9rPWdf5p0M2Ai5X5Amhzqmd2T
 gYeOR4p2a021LZXpSHsZoAp57jhr5uVbOeuxBj5Degwd/huX7PeyUo+mDaWYYzcFzAO2toN9BeEw2
 7WFZDA2uivtMYWm0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmb7y-0006fr-G7 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 17:53:07 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49557167508so44384015e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784742775; x=1785347575; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6d9JBgW6dOQjPddmdidL5TQ5LHiGQa1JkM/XhDJVEio=;
 b=ARHOe85szPQFvZtFiJkjniwUnwLFP8gLmi61gz+LDHnZMTpsmL/UgJUUoaAFMC0seh
 khaqG6jcIc1BbH3QM7bE08dzpkhBCo4CKpdr/5wjFkv1wng1U/Qs5wis/JkIDHSLyPnP
 OltU9SUYnDTjDA/aJVtEVME8ZVMAoDSgTcv+nF4+nyOuyfjEdUGNqx5zqRTFxLlqO2g1
 VDjVjHYyIqtNJyICI8nh3A1P6YU+O0Gb4OBao8laJwfMWsge/IQRJVwOmSSGgtHFVEpD
 iyiY1CF86QHJNJhTZqkwjDQy8ChFtFgmAgYlusWOdlL0LOu9ByCL2qNNs1tJoyUj0+Bm
 th+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784742775; x=1785347575;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6d9JBgW6dOQjPddmdidL5TQ5LHiGQa1JkM/XhDJVEio=;
 b=dMhM02RifsnGp+mezBvavCofqMzBGnmfZ6xpnRqV3+9zGvjmrgNZicQZV2PE/+UBla
 /O85l5LtpLzYu3uH4bpbekGqOHsMiDrdhpbs1SyzJegITBBZ3kU3XqeYDiDuFMQsfe7J
 kKW5JQ0ki/B9Q8ysawoVKOTlYE6g28P9+mu5iCgg7EVxQZ9bEv1+wEFAm5STxTPTT4Wq
 9dyKRTuscBi8VStXKTEq8KYynOOoO8MTUM0RC2ILxRI55g845uuzj2N/sa//eTgPG60q
 5GS1jMBMLVzuBN7amnEFfX/jLoORUQAVQreb0XN478sCJiTuGu1CNj8IiMz9wl81Cgk9
 8rLQ==
X-Gm-Message-State: AOJu0YzEWyjsKiBBcxM9m7ViwRRlPVfNH5vffl4f/nfVvA5nnOl+E4Oi
 ka9wNRoWe7/ayFwWcAPNj1y5zdi7eOsr3u+2KTBJf1FUycunl5kzxpYQUTP942xuB9sTFID81AN
 YXyaXEFvuIYtWdcvmVFitQ1qST0mBmSSavqn/IS6EWUEzJlfkR6QZ33figbTDBngkuCX0yBXpNn
 boHBFhHg==
X-Gm-Gg: AR+sD10l39et2+03OKOEewatcgRzuPvLyrkTHvUeEUJuyNsvYPRjE/YHHmMREyxeMHt
 1h/C34uxj7i6tV+Vt7LvzhcBYct+wzMcfJRAcTKtqY0yFy9SsDyC51QE2gQIM62zz9qFuBNSTu4
 zaCdoE+UMGV9bTxv/EaBONOTFUadr3DVEXUZA2lTdR533fvvG3iZJsKLGlFUdsO1n+UDbm0UuiY
 I09KlkfMKtjKF7Lu/O1e4PTG+UhhtjU47hQ7tqnW3q44RLVZWpsyv4LKLgJEnGKwz1VblrJ+vOQ
 KtE4ohU8+VYdDxIQU8IL3eqW8EcVbjcYigVVlvQdfUOSu5OlIr5K4WQiOy3tG4ij2nPg8pS25xF
 M5Lsv4ydetqk76hhB+3KX3jW6Nciid3yvtMtxCc7p20zBm8KCt06bFPwU16lSDvmIXfcCNaTsBk
 VyS1TU/ub5t+YXKAgoWPMyae04XlICJte+jge67EZZ+x+2ZWPQlQV1YPHlstrV6Un1LdlcEZOiA
 Ex/QELet0zSv9iA75wftmSWegjy9nvaBdCOwspG/sFSh/3xGnlLNGCZFKs8Q3rZtNGbFjxarEsr
 HaU=
X-Received: by 2002:a05:600c:a05:b0:495:67b8:d97e with SMTP id
 5b1f17b1804b1-49567b8dbc5mr97196065e9.30.1784742774803; 
 Wed, 22 Jul 2026 10:52:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a634cf9sm94634965e9.9.2026.07.22.10.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:52:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 17:52:53 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 28c867778a91a651e3eed9974a09922536b958d1
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 17:52:53 +0000
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ef80beb2e694152d8e1c2c45acedff8b94c41b4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmb7y-0006fr-G7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 from --help output for Mbed TLS
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 max@max-fillinger.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7049262359611354221=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7049262359611354221==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6MIWWRrUSiw="; charset=UTF-8

--6MIWWRrUSiw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

plaisthos has posted comment=
s on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
9?usp=3Demail )

Change subject: Remove --providers from --help output for =
Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1799?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
Gerrit-Change-Number: 1799
Ge=
rrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Review=
er: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Da=
te: Wed, 22 Jul 2026 17:52:53 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--6MIWWRrUSiw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>Patch set 2:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1799?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca376eb9=
eae064a893c8768188e </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillin=
ger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 22 Jul 2026 17:52:53 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--6MIWWRrUSiw=--


--===============7049262359611354221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7049262359611354221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7049262359611354221==--

