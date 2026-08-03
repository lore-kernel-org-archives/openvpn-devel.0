Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA13BC55182
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDTyTPQcg2N4dEdlYIx2shEsfQgZACl5LJmauHxykiQ=; b=iyFv33H6FGAu6lC+vzdDr6ah9n
	sG+4wNnusrvpxI9vTsMC6yx84TEdC03v2wHO4MqhdjjDwuSzuDPop2vI4sxf7HrkYsb1fRiIuIlcP
	RSlJLMx+qaKaY+qpkYCmcRSEs38uJU9n9AvwpKjKzIPs8m8454POOXapZUhSiR+Tp4t0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqsdu-0001yj-Md;
	Mon, 03 Aug 2026 13:23:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqsdt-0001yc-Dy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=R5cQCiQsj9pvTuatn/OuPls70+aY9vLVsjrSnLRaOTY=; b=XjtWC/WJydH9hhc8quMORbvjh3
 ba/uLKnC3VOKME9c4tcRc0m6N6WzE0FS4JVh1ex4t+sf2OsxEqdoIPuAp0nO+t+eldUT3GgCS+Gu1
 exc6fhJVWQM6sFCcY8/nCK03Ckhv+wOxjMoIJgD50iHPGkGbCCcWzs7+YVV5i/TxxZWA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R5cQCiQsj9pvTuatn/OuPls70+aY9vLVsjrSnLRaOTY=; b=K
 nvqLTx5fLEKkJiSlxqsHSC5sUkgW4JFsxHRIG2YNkpZd32MjCeqvh0y/aMh9PM4FJqys/M7kGBVDQ
 juiOiIIKKoGDOgLLt22ek8j68HF8LozWxiz0GQFur70D5+nIikAQDYUsRSklXQtDKy33A8EDxvcWI
 0hyKqfDqGaOgZ3X8=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqsdt-0003MJ-Qh for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:23:42 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47db714766aso2567108f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785763416; x=1786368216; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R5cQCiQsj9pvTuatn/OuPls70+aY9vLVsjrSnLRaOTY=;
 b=I9NzYiu9PEMHTGZEnejbrcx2vhelas3ozcaN+4mkupPKwpL+p57xvSQS5YXp7l2grk
 4B9X9786rbH5ebr3gJkB4XdLIj0fz5AXDBFKdujVnHxjCTMXLAaMw69G/h4fa6eH4bP/
 8OENYU7bp2jDS8eEJ8yFx3ox+SNfxzfbnnZc6HwYGDGkDDj9QWgQHzZHEZ/+iCE5YLVe
 Ey3bFIxmBXk8qpKGF0YovNl7VOmrLcCfJKoLHEnpOSqn80QBXEg3jwndRE6OS6+zOH7S
 Rt73yLftSuKKwead7nZiDUBi/sd7kNMuLMAu+cIQ717F4N/IygCMH3zLDwr5Ed4f2UoU
 TiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763416; x=1786368216;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R5cQCiQsj9pvTuatn/OuPls70+aY9vLVsjrSnLRaOTY=;
 b=B/KCFA6QOk/zdMFNg7lwvP1Nib52Ji2MgER7m3zELDMDg5dDGD+0PqM0Sh2d6fsoF0
 U4LDgXQaE9mAjhSkgRifZZZNBDdrLaob1TXRAFgmy+eNDv8pgSbWAmVVe8kTSfhIHrBi
 hO6y5djgUOoQJSeaKxO9TJDYLQYio8Lr1/oqCCPS89Tz9hp5fFUhhaHd7g0elMTjEplg
 FkCN2JXIyBXYTRjpYBGPgc+pUonKa2GEb724gHYyjepA+4D3CZHell7/gQZiwsRyJYGP
 YSVOKqegqgOPaIh/TuVESYFtM1n+RzwdkAoMnKIoDNAVSiviGuxVZS1I4S3Xzf8x4jAt
 gACA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+ilg5Kcy/RnGkcWhs5RjeHyCuepi2dgpYfktjxF0S3VhpylrPUYQMmW2t/ySyGBI/9cxtCdKxqkSk0iah@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwOJ0Cp2VudzzY19WmbJc4Xkrk1eNrdNTDZieNmA3kLaZtQ7LJt
 oMgEtP9ljoBkHFRAbjxL+ZIK28e19hb1unbj5aiQWniZH4oMCIzmoT5Q8rrJeRbWv3b3Ds6Dw+h
 YRlZIAoAdE+i0nBxSZjo4dm5ylHllTlVTZMjL5yhJ4wUpMK1+cH459L9z038zdIMG2Z8SW066xG
 4NEIgIXA==
X-Gm-Gg: AR+sD12ny4sl6mRDJVfkH/34sx8tbJ5Np0U75QXGSZkRmp9v54P1p7JmlEk/hc4JUVT
 yShmTUN5A+KznCP9hrh+pGNdUEQ8G8t/jNYjDbC8D7DZ033W8VjLnSspVkLa3wvTeAw1P0uKhgG
 geuN+va/Ne5pKrxBykKZYNblq+ulV8fpMT80H8gqNf37H4qf57e6PDpUPCVZcWmjN3wu2rDID2O
 GAHBpPDyg/9Z/TE32aFTybBFJEz00uyLGeCA+9NUw3mQPPAdDq+M4kPBg/8796lOQaEOued6xK6
 +7JHpQOOgLSfD8kTtclUvMqpPXJjugL2GjS7UIBqkRTZI7blp97WYX+saBrVhvvxubZj/r4aDn3
 ZKZWg30Cj0NuwqvDMNoRjwr95aChOc81nKuFncmFgkcMfFVHZn+KgL1voOiCI0ApRm+wetf3olY
 XmnDB4sOvRPlIQF4eLfslxw6rt7fA2fMSSJIFPblb9xPnYHuyZSQdYyhGw880uBUNDPmkkuYbuc
 OEjUX21UhNUPeGGb7QIoiMTDGAXx3stzLW0nWhyf9DJQ59jJRYUVbl2cFcaL4mOo3bXZtq+3xLt
 PYVlDk7J8qQiNohTOqKlTZNEhrcvxkQnXv6e5Pj7XV7mM0Wvdjg=
X-Received: by 2002:a5d:5f49:0:b0:47f:853c:ad7b with SMTP id
 ffacd0b85a97d-47fd32b96b6mr32280318f8f.9.1785763415512; 
 Mon, 03 Aug 2026 06:23:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm34214825f8f.11.2026.08.03.06.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 13:23:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: be6c6a3d90fa90273df9a7097609ffd08b0298b5
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 13:23:33 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36ca0a5b72b623ea70cb9572d635b6a4a3becc27-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqsdt-0003MJ-Qh
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6565909632840485726=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6565909632840485726==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rXD7cWSkk98="; charset=UTF-8

--rXD7cWSkk98=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 21:

(2 comments)

File src/openvpn/multi=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573/comment/be42e2ba_be812043?usp=3Demail :
PS21, Li=
ne 26: #include "siphash=2Eh"
> Unused?
Done


File src/openvpn/siphash=2Ec=
:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/comment/06d9fa63_c211fa46=
?usp=3Demail :
PS21, Line 23:  *  51 Franklin Street, Fifth Floor, Boston, =
MA 02110-1301 USA=2E
> old header
Done



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Chang=
e-Number: 1573
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 03 Aug=
 2026 13:23:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-=
In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--rXD7cWSkk98=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573/=
comment/be42e2ba_be812043?usp=3Demail">Patch Set #21, Line 26:</a> <code st=
yle=3D"font-family:monospace,monospace">#include &quot;siphash=2Eh&quot;</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Unused?</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1573/comment/06d9fa63_c211fa46?usp=3Demail">Patch Set #2=
1, Line 23:</a> <code style=3D"font-family:monospace,monospace"> *  51 Fran=
klin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">old header</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">cha=
nge 1573</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 03 Aug 2026 13:23:33 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--rXD7cWSkk98=--


--===============6565909632840485726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6565909632840485726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6565909632840485726==--

