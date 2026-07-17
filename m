Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54398C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54RBaVnd2DXDkaGRcK3LH5OUu5WBxB6XVU4/suBqGJM=; b=Ac/EkEuy5uFgrnIMzrhBZw8LPz
	4yOgPL5mxh7IoCz/yjCgXzwKPWSC/WhaxchW/wT5dSnpDqxAG90TWxFHHrA7sbD4+eXueDvR5seyp
	7ff0vueDYAcrSuvGOMUwVYL3ZI3Nq+eBlfjl+ATbD36HyLald1R5Sn2mbtSwOUuONo1Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjNM-0001Lm-Bx;
	Fri, 17 Jul 2026 14:17:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjNK-0001LY-Sj
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JOjma6VOZx7SZ/JPtwamVYsBNIcli2h10kkaxob1rIQ=; b=EjbIRtwvgUKm8x+TUmKdXqGKBF
 Ph+BlDr2ysozFANp4wC8bsqh4ucLjh7ZK84w1k+fgG9k/GWb7dGWwtWkO/8vRjXBe4vNrXcQAdxXs
 SrzxLbsxaov+FjE6OqC/fOM80/mshlnHKdYiJFeIMa/33mCc6x1kHb/ORYiUI8BYo6Y8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JOjma6VOZx7SZ/JPtwamVYsBNIcli2h10kkaxob1rIQ=; b=F
 +igu7ISXowYifrRRqOZujdGwVc1v/26pnJDeK5OSBc1zY45KKK6kQ/NJl0hcdtoObaF7EMNfxv6Jl
 BAzvVt9v3R1BRDbcCgntYqhsg9HhCnJ3C03MNBbLSLc7cFasOetxsXaU+5Nwlt5orDy1lF88kZBZE
 ExEkjEPOl8HpFd4o=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjNK-0004Wj-9p for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:17:15 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so108915e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784297828; x=1784902628; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JOjma6VOZx7SZ/JPtwamVYsBNIcli2h10kkaxob1rIQ=;
 b=IvN69Vzjn+bRfidaqHp4/Q84sRwKwmgLzx99N6eOtZt/zutEwHQqJR8xOwwyGPQTek
 J5xt620Z0ox2BBi3eLv1B9tUGzDiZ/6BJMupP5UAl19tlnEtCrGvFcAuC+e3/jjQr0Jw
 rgtqMvgndMf682j6grMs38X4R4I6PlfEkjZN/WCGukSvlVuNjMsUeN8zv9DQjQkuBhyA
 tem+WprA2YgWDTmxi2nIraGRZJuTScj3F+vhJ+IKwXiLqZ5VzMqqoSUuFNslcGgXAME3
 gbY493zLldDc5cKGlLFN9uQMUTO2V3kD6EYF92Rz2xPjVEVQB8ShvY6GbOZmeg8UJ9G1
 6b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784297828; x=1784902628;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JOjma6VOZx7SZ/JPtwamVYsBNIcli2h10kkaxob1rIQ=;
 b=nJ6fi1uLw9l3XIu1NeLAro0viBYg2i8FGxEck+/vEaqbgPqF3zb3IRyfhAEWEtMXCA
 c4AUof+Rw1Q563MCkFz4Qpm4KxM5eTlKRTMg4w6CLPiCZigwKEH59IIuq2cRCJy0Nq5R
 ZO94xoY26CrzCXACCMnFfoBcfgAUhavBRKJYFwnqnkhX46f5pQ9Bo4MliQnqFbqcR070
 CEcyNh5OnlvJmMR+mf17fI29SD20Rb0AQQOneBuQfxZSqA06HOA5s84URfC/PyrC2C6v
 JtFDGhsESoHwmI90Hozk+N0JTdmV0Bv+8va9DubV84gTwVrBxDd19U7ohrf1fwxWNvDq
 KHJQ==
X-Gm-Message-State: AOJu0YxfAGg/gLg1KA95WwPn9xUhQ2SkkkA09yJCHO6wKx03RQ2tC8vP
 9U3MCrf018Zw4hRURVSLAoZ8VF9twrWor0bNJiN9W5M3KZ3+pDzzcgYqHof0nvbeGKw1/OUPdWz
 Ee0UsDhxHBqSbWuD3WEeEkNUAKkF36ZYJ9juKdDSgssultBVSsZhygThJhhyjXWIyzQCa
X-Gm-Gg: AfdE7clP9WW+rNRGPJfsCToSflqwC+Gep0DgLKHsW2CLDKZO+QX+ThtdPd15KgSPsjB
 PACM5Cx7HtP12VnpQmaluBanbxKn1kKiOOWCQJLBIzoYaaUGGEFexa0NmsjU6SEvL1ZFsdLG6pM
 EefYd/lJPg+7vIn4uXRcjy+3lHoPBX9eoAaAV5J0OQ9rB6EgrAsn5nfUYNSnnsvKU1FFl/8y5Y/
 DoAHdhQyalnFtbnL4ugE+LxoqwyMD3SrN7aGJgSN//LxIyjprTx8A2VYX8HLQCcyOvfN5SxhqnT
 hSJZdrX1zg5En5m9YjeoGaxezH7KubM+PWenQzoGqmuMCAGniwZDotoHFuQg6geNkOOYDpnJOk+
 7hCWJFPmjjKtpYOGuqDMpyaN2uNG2FLb3+1JIs2CigrBALy/IvMpEruylhBOu7BXub5FNQsljs1
 O0WaMusqFmXPVsqffDqZ72W90Mlvfp3Fibl9W1jXyuaJEbqaMgG4gevWSX1gMUM+PHmHGTvXfhF
 Qc+xGnkptAird9iRRJL7anMC03tJs1A7qku/lhy01wOROax7969u0jsW6TzGZgf0qLN
X-Received: by 2002:a05:600c:5882:b0:495:441a:39d2 with SMTP id
 5b1f17b1804b1-4954a402f2amr25237835e9.21.1784297827131; 
 Fri, 17 Jul 2026 07:17:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3e56fsm51583965e9.5.2026.07.17.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:17:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:17:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: d501861ad4ca12f7c402c999e914430ee48fc480
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:17:05 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e43ffb2e2bc67bcb07851b73199f1e76b449a674-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjNK-0004Wj-9p
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8951861147111844947=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8951861147111844947==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+u6ixDAmrfo="; charset=UTF-8

--+u6ixDAmrfo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1726?usp=3Demail )

Change subject: Split multi_get_create_instan=
ce_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2

(1 comment)

File src/o=
penvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/comment/a9=
148345_aeae6f6c?usp=3Demail :
PS5, Line 295:     if (mroute_extract_openvpn=
_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2El=
en > 0)
This looks weird since it repeats `mroute_extract_openvpn_sockaddr`=
 that was already done in the caller=2E But it will make sense in #1727=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b77f184c7=
d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 5
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 14:17:05 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--+u6ixDAmrfo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/c=
omment/a9148345_aeae6f6c?usp=3Demail">Patch Set #5, Line 295:</a> <code sty=
le=3D"font-family:monospace,monospace">    if (mroute_extract_openvpn_socka=
ddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;to=
p=2Ec2=2Ebuf=2Elen &gt; 0)</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">This looks weird since it repeats `mr=
oute_extract_openvpn_sockaddr` that was already done in the caller=2E But i=
t will make sense in #1727=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 1=
726</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
8e9923b51b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1726 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Fri, 17 Jul 2026 14:17:05 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--+u6ixDAmrfo=--


--===============8951861147111844947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8951861147111844947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8951861147111844947==--

