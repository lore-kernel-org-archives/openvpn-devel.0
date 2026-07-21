Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73FC4452D
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=unKnGGv6xx3hpeKEg0ASIqS7dh0u03QTuXF789rBdEw=; b=m6Axd3UEU3nJ6qDc6G9nbrW+x3
	0zHm+xt0Gz0lMHWvBggjxR8MEVgPSsmm0PbPRvmO7fGi7rOE1VnQVsKYCX7UCur4F46B5nJaJWcRr
	l6EtF/eWS0CVOThRbiEnCATpKd3KgF624mZ2Le5Vy7mfpRn7xLUjiUScvlnXp0zy6KoA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmJQA-0007Zq-AC;
	Tue, 21 Jul 2026 22:58:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmJQ9-0007Zk-Ca
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:58:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Dq6r85dEd9HRyqKJulbN+W62cEIwA4CtVQwzYmbtCE0=; b=YllBCjpl5K+Zj65SfiBnyfgCwd
 i6esNj1GDMrD8oM2bBr7onhzbEHFVfwjNLMr2uQToEwNjMmQZQ/CKVhfuasOzFQCeCdgnZiM3N2Ga
 OVEZQYYKj7iE5Ln3JjavN3M0FH0y145Efvprmw9hblbQYtISY6NTZ0EnNaCwTr+ApRjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dq6r85dEd9HRyqKJulbN+W62cEIwA4CtVQwzYmbtCE0=; b=P
 ymlcx5hmu4xh+WuUwsx67Vs0tStlxnRmweyvvB/3bO9iy98TwnqsX27xGDuZvQUTFfvWFH0lfVXVA
 PK1g9ggkFuY3XQp6w+o5o6ebNFkzecfAZYgXGm6s7z/gEORRC4DNF8HfMi9ljJLaa9kKVBT5/zBph
 MqQNzsPqfXh0Wn3E=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmJQ8-0004X2-Mc for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:58:41 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso21017885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784674714; x=1785279514; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dq6r85dEd9HRyqKJulbN+W62cEIwA4CtVQwzYmbtCE0=;
 b=ITS3gGbXQM5zqZYuiJc+aQEtnQMNNa+LDiMPR4kqf9jzJBHCrcwlV29MTV8n7sAK7d
 /TMm3fe/UJxHUmi62fk/u1E+inZ+IZiE98HW79mLWmivsg9epw+DuWw/pvAm0ik3FwzD
 ll975dvBIlYuWMuOOZcZsZ/KYz2nIcRnrlEh7bUp/Wx7r9f3FV5/PlTPJkH4WQR/kPKg
 1Q7F5/601VT1m7LlH6FqEucxmaTNiQ7UEVT5lhm5HYgUil9Hh0/MswUXZ6A2WE/rbcIy
 N6x2N1OOnwed3S+Qkpk9DgH9lFm+JPwyZcIBHrOz6LLP2UtOMeLUW34p/a9CHeXY1l6q
 4SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784674714; x=1785279514;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dq6r85dEd9HRyqKJulbN+W62cEIwA4CtVQwzYmbtCE0=;
 b=pBATpHWip4hItlsWW4FBwCd7Auje5rMsRycCATcHvynpBOEB8CsByEqZyPDWT8udAD
 t9WFgf5E/d2+qz0ELxHuk8NhQXtXWGdvJXzAgjIgiGGEIvXwX1R9+SDAh0cCCGGF19fJ
 2VW+wORpPv/VYWyOoLsTjI8+ou4ryf5CmrP/4t9cuCNMFoaI4jO3iTCKaFR8GZJVmAet
 fkGhVmNkFwdipFDk3ieiatxKMp15D8/RfxumyEP0GmRks3O/V+tc37ebERfnEQJdIiWN
 hEPr2+1mevbW9W5kd/FD3M0YjCXtwkHLKhFkD7xxAna62yhTZAMsMklkIQPi/8vlYq5C
 KwZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgKgoCb7smbXjIMYGu2Ua9X64mOqtyFyLXh3EEcMaANQAxZL4LCeihqa5l24hS45L41bO5jfyphX79JeI6@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxbyHhl95HQDhPx4P1Fsiv9YW1LYioLkMeea5uK39kY58+eviJq
 DYil/+tdZDY1vyUa+rFeczaaR4hYLfapu1e1BdsmY6XX9/sF4t2pBzQzubeSUUFTt7hfLZmmFuR
 UGAV4bBKTMLfyIf0CIxMMBrFTNJui7dRC8EPaQCQE4A19HI2u/b+tkQrXVErkleenn9RJGfw+dm
 B8H2789Q==
X-Gm-Gg: AfdE7cmdb+iimdKCCgu0be1bd+oZR7cO2heywJFjGKbL7ETLXBmG3CHlelnXqm47u9e
 nFpPIcq56cE3XTS7v3v1NfRwRRQL+4/vAZktkj4ObUPtQS4X0Sc8lcJ3v4ATxoXJ/LaFqI70yFv
 MxaE6C0MvJxBLH6NSxgA82F3Qe0NJUXyycG5Ea0fRLHwRVs5qg9IFIreIg/qPSbD2SKp7nKRp9L
 DDPaw7YfJZITRJk1TaXvEAwkl/oMCxXdj7fLE9aOKDbfEFpTdWOBu6ipUVikLyW1JWg9yHQ1+xC
 xuXaJOpJbGieDkwMWlNuGyoPPsS5vqv1zkMJw/3GmS3GOQAmC7OErAScWbnKUk7JIdHhfsLMszT
 04kxnCZK4EXS1EMzxBO5uy4iNyawo6vp+1uUvSa4Q/rq6x407YET47TB5rJvczkTmR94+tlbKFg
 j46+h7lkx+SYMJ4f0zeAw9XDQJFSQLtThlh6T1oXEpWaEH/Eq+E0Fwm1o7e7ESUyzpq9KL4FjX0
 3YFrWEv2V3aITydaBsjywGSip3/j/2YgsgLJB9HZVjVPQqA6Ek6lfRiBpneCJn12VGs
X-Received: by 2002:a05:600c:4515:b0:495:4689:7147 with SMTP id
 5b1f17b1804b1-4954a3f4a34mr274300655e9.12.1784674714027; 
 Tue, 21 Jul 2026 15:58:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565304aefsm92953845e9.0.2026.07.21.15.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 15:58:33 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 22:58:31 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 5738669616b166a39c7b91d031672c8e7fabb5c8
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 22:58:31 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1b044b6c957982c3ee3e5bcac3b5d5163384716c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmJQ8-0004X2-Mc
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3699676572122261522=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3699676572122261522==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hYsHrkRLBYQ="; charset=UTF-8

--hYsHrkRLBYQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, plais=
thos=2E

ordex has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 19:

(1 comment)

File src/openvpn/push=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/f86a6636_fa82=
5513?usp=3Demail :
PS19, Line 664:     if (!tls_multi->use_asymmetric_peer_=
id)
this is not equivalent to what was used before (use_peer_id)=2E
what ab=
out a peer going with DATA_V1 (i=2Ee=2E use_peer_id=3D=3Dfalse) and also no=
t using symmetric peer id?

it now gets pushed the peer_id although DATA_V1=
 implies it should not get any=2E

makes sense?



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerr=
it-Change-Number: 1089
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmar=
co@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan=
 <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2E=
de>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Tue, 21 Jul 2026 22:58:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No

--hYsHrkRLBYQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, plaisthos=2E </p>
<p>=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1089/comment/f86a6636_fa825513?usp=3Demail">Patch Set=
 #19, Line 664:</a> <code style=3D"font-family:monospace,monospace">    if =
(!tls_multi-&gt;use_asymmetric_peer_id)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">this is not equivalent t=
o what was used before (use_peer_id)=2E<br>what about a peer going with DAT=
A_V1 (i=2Ee=2E use_peer_id=3D=3Dfalse) and also not using symmetric peer id=
?</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">it now gets pushed the peer_id although DATA_V1 implies it should not=
 get any=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">makes sense?</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 10=
89</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;g=
ianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan =
&lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 21 Jul 2026 2=
2:58:31 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></h=
tml>
--hYsHrkRLBYQ=--


--===============3699676572122261522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3699676572122261522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3699676572122261522==--

