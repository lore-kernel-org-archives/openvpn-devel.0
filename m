Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF301C61DD6
	for <openvpn-devel@archiver.kernel.org>; Sat, 29 Aug 2026 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbJ08sU3CrnNzRk2NCE59XgQX9yMGALdr8n4G1AFIxs=; b=XeMlDa7lpKpbEswbPvcIk4EWu2
	YZJ0nCkgKXa12QqaN/t+vddAAnkgBuTRiOy+HxMJYzmk1hBzr8/AlqWys7ejKjA9Ve+lzUBU4sGWz
	KfthwNHvPUJ23chH5LfD2cl4EwlsWaZbl/pw3bWiDd6QqlI0Ex1Bs2L9D+NCs5MNN9n0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0M47-0001Jt-LA;
	Sat, 29 Aug 2026 16:37:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0M46-0001Jn-SM
 for openvpn-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 16:37:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Sff1mp4XadRpFQqLzsv8ySAsKT6hrgLP5YSBZX//b6Q=; b=fEnt/Ni4WnsFJJQXaUGrelLrlw
 fM6oeXv3xRyEx3j+QhQEHxJUUvOH91Ey+IP9G5+pjsxdDJKHzVBxC1sjM/oGoh4wJ+4Mz/uo+F8Ps
 jj1X75c1Q8SksVG5z01A4M+FbAyOM77QCz0MtTgfvo3Eh3sBPgfRtjNM+bqc7zRE+nrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Sff1mp4XadRpFQqLzsv8ySAsKT6hrgLP5YSBZX//b6Q=; b=U
 +8PeCgUWBZKwqE0pDKwke/O0aje+nNCSaUckZTTSuuFV4sNi9gW/joQNxG/qJVM193qe6mtp4vchZ
 YuFC7OnqUXTNZmMuSOwU6H9rxUnt29Uf+ttCqlHSDPv66RcirZbCNRYiy+ScNC6+95nEGeOg6/BGu
 WoGx7AJEB2/O+hTg=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0M45-0003lX-Jz for openvpn-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 16:37:58 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4956869750eso13046385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788021471; x=1788626271; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sff1mp4XadRpFQqLzsv8ySAsKT6hrgLP5YSBZX//b6Q=;
 b=aezKiCpExaxVbodi6ZDD+71Ml8OjKDwOaIWTA4RP5ygzQzPyvk5vouRtHhUMdX43ac
 1cY3lU8+3DfKrw79hSUhfX2oWx+jeeQeUsoAuU2mUfEtsqDbg/+yDltqaIRt3tigfeMW
 2siao8F33AWbIv4mOKvx2lXkF2i6CT5Q4l0ijW/1tluDOKdQ7H/sZGRK/IbE8wBH0f/O
 aL0NJJ+r1ThhxHqRoj6gpPPBS5jSxReeFCSXsI4IMtOSAarm/Io0At/W+E0XEu2yxo8N
 K6tNo8VI0BI7mcoki/1W7cyOYN5HfSq9XXoOgL7cEps3zCTuSNYxW65N6yGZmugEysns
 C1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788021471; x=1788626271;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sff1mp4XadRpFQqLzsv8ySAsKT6hrgLP5YSBZX//b6Q=;
 b=AMmY7lZW+u/F5+AeoNFbEQ0d8ku3gC7yJeznudvrEU/57Qz9/6q39EXRsD/48YaX2j
 5tYVSGNA3vh2hPbesOyl0OqsyMUcZPPIAOf2ecJGtgXFP+ETyabokq3DD8CYrURNxm1x
 68zFThputJJzx5oS1qEEHNvTqxBG+q4+CxFKGFpqqlb5Y0Q0feXMjjQ487zu/mb2/Hbt
 3G+GLD6R7s6EuMG69XbmCenY43S3BSyIyQyVkJGoqYiWYgByo9gZuV7qowTfxnzwv8fu
 iafkjg0PfEBT0d33ChgKGUTfjqW43Bw7fhZ4VGkBqQYZuH+bM5VzRvWxXkgJK7jGpE4j
 2Ctw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcQBY3WebxqLHf5RIS7WpnIodV/o4+/M7bXtkZR5mbODXJmfM8/MUpPZUm7PAIfn+rXZSWc+cZpZxFLT3W@lists.sourceforge.net
X-Gm-Message-State: AFuF++nR+UkSakjcm5VElCRsS1mqc3sceOyhOzkIL2lGAezEf7SDd/eH
 7Or8YyCBvuBrsDv07Z5dDMvLhIP3ocw9y4WGTZv3nkPxRNEYqqCjEjM32H252Xnbb9AcvDP7mxp
 y2OXl3XiiERmzELX3Qonxlrmx5ekWH0ZmFRMsTSuI9WRYomNfU9F+IsZo+w78PbKGAPe0
X-Gm-Gg: AR+sD139jS8GvMD99LnY9MRNgBveAQR8cRvDM+Vj2UGeIy7jVZtoPQUc998r/OuelrP
 VcgZWZNmoq41PoQW/2mz23/5/P46KdvhNNQ7KzKeKaoU/FOlMU5+biEVOZ5s4UD3WkgIl+VQZkC
 RuOiNDVp1JKBik9CIQ89GdyUXMTeZNmkh+jN10QRKdS7ESaNxCgxLrL51pRGTurEmPB8u4ko5xt
 C8yLtldF7rNZ6+dCUclGCp8Hi0XsNVF6KAAbxGkyXjMLSqmLj5Ds8relb8/y6vGe14NyNvasMDC
 lkiArmezt4aa8ZwBZsXZuPC+pSoGWuiKWrWUiSC3mcSszKjCH0Jf+ngsc1bHKgIU5U1nmaHJ8/B
 pCF8Q1VVayD7TZWYkCPvoPOHn3ZkTNZZbNwMiFC0VfRM33sBrgF7Qekj8jzydigXhLbcRQ7LoEZ
 Z5aNSv1ZfF2lsxdyUTdF2LPMo8u9KN5i3m0ZpuLjCn0wXBuMuPMv5ZAPt0cTiYsoHCoX4gzEjk5
 VrNPz5ub0cW51P71p61K+Rk1P1K1lZgCSQPLGBLTKTF/WTpCaNk3sIOZa2V6MtZG6xmhTDGD2Gi
 wXYRsUgBqibPuT+G0urfqKTSlZNCWTfV7PeAqrDZwoREvcemfb4=
X-Received: by 2002:a05:600c:3546:b0:499:bdf1:7578 with SMTP id
 5b1f17b1804b1-49b91c19d68mr195817665e9.3.1788021470957; 
 Sat, 29 Aug 2026 09:37:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b963c3c0asm221101015e9.10.2026.08.29.09.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 09:37:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 29 Aug 2026 16:37:49 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: af724b68aea7ad161492da8aad1cd8a5ff456bd5
X-Gerrit-Comment-Date: Sat, 29 Aug 2026 16:37:49 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d33cb8c17c852510e48e6a6cb83492f06716c0fb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0M45-0003lX-Jz
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, david@srkyn.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4833796332802236636=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4833796332802236636==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KPUvcOQosS4="; charset=UTF-8

--KPUvcOQosS4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, srkyn=2E

cron2 has posted=
 comments on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1881?usp=3Demail )

Change subject: compat: close all unrelated fds i=
n forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(2 comments)

File src/compat/close-fds=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/7bc3ef82_ca4ebbb3?usp=3Demail=
 :
PS2, Line 42:         const int lower_closed =3D keep =3D=3D 3 || close_=
range(3, (unsigned int)keep - 1, 0) =3D=3D 0;
> This should probably be `bo=
ol` instead=2E
=2E=2E=2E and please avoid complex conditional operator cons=
tructs with side effects in assignments=2E  I only had two coffees today an=
d I find this line beyond my C parsing skills right now=2E

This looks like=
 we're calling `close_range()` way too often anyway - figure out the lower =
boundary in an understandable `if()` clause (or a conditional assignment), =
then call `close_range( first, last, 0 )`=2E


http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1881/comment/bb033b37_333e2356?usp=3Demail :
PS2, Line 63:   =
          close((int)i);
if we cast the to-be-closed file descriptor to `(i=
nt)` here, using `long` as a loop index is not the right thing to do=2E



=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b=
2b364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 2
Gerrit-Ow=
ner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: srkyn <david@srkyn=2Ecom>
Gerrit-Comment-Date: Sat, 2=
9 Aug 2026 16:37:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Com=
ment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--KPUvcOQosS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, srkyn=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/compat/close-fds=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1881/comment/7bc3ef82_ca4ebbb3?usp=3Demail">Patch Set #2, Line 42:</a> <=
code style=3D"font-family:monospace,monospace">        const int lower_clos=
ed =3D keep =3D=3D 3 || close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">This should probably be `bool` instead=2E</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">=2E=2E=2E and please avoid complex conditional operator constructs w=
ith side effects in assignments=2E  I only had two coffees today and I find=
 this line beyond my C parsing skills right now=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">This looks like we&#=
39;re calling `close_range()` way too often anyway - figure out the lower b=
oundary in an understandable `if()` clause (or a conditional assignment), t=
hen call `close_range( first, last, 0 )`=2E</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/bb033b37_333e2356?usp=3Demai=
l">Patch Set #2, Line 63:</a> <code style=3D"font-family:monospace,monospac=
e">            close((int)i);</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">if we cast the to-be-closed file d=
escriptor to `(int)` here, using `long` as a loop index is not the right th=
ing to do=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1881</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacd56d245e9ab30cf=
b25b2b364ca661fa289dc55 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Sat, 29 Aug 2026 16:37:49 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--KPUvcOQosS4=--


--===============4833796332802236636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4833796332802236636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4833796332802236636==--

