Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63027C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JmQwBRkk3ID1ykbj7Cy/+Tw6nQiQTiGPPlWShcHA+s=; b=OmajiG9sXIhOOlJIhoIsNvayVp
	lxX+Af07yQU0qxUr44kirIYEUewyxEWH9ee2gW+mzREmVSOCIrAzWaXqxhEQGS8fHOc68ViZwjfd6
	uS8++9L6oCYX/5Kkz+PdbPY235vpy5qgPXHakaJWpiW5WPZkbRSAcP74oU2XsMBoPUjY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgQF-00021q-MF;
	Wed, 19 Aug 2026 13:33:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgQE-00021e-Fo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UugSc4hYtZ2PiNBYMlOraIcKuxDijNZvpJVp9vnEZ7c=; b=N5eyrvqukqZDLMubR198ZAr4vW
 +BwrJ5jlp8s8lN3QIhxeK2TR9peYpTKlS28Jcv2N2cGaNM/F2VnHk/2v0nLzEsxd7a76cukl1HsYD
 tswqckWTu16KHhrBKodArrb0xMSDfunJ+UzoB96yxtI9tSuL2zRTrErV91722A3YdX8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UugSc4hYtZ2PiNBYMlOraIcKuxDijNZvpJVp9vnEZ7c=; b=m
 PemCaF75APKAhxrTa9kmFP47QfaObPqD9ME9XJc1oavoB1NOpot8iLFeor3Pm3YZu26vRNCo1rrwu
 vkzwH2agTxTdnjDgH3k6ZEwRh6Ia3IATwGTmZGTL2lKi1582Dz/NukI1FcJvJXkfTipZ6+I4QVm08
 ORjhyqaQ88uWLx2k=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgQH-0003ku-Sz for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:33:39 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso1452326f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787146412; x=1787751212; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UugSc4hYtZ2PiNBYMlOraIcKuxDijNZvpJVp9vnEZ7c=;
 b=EsFY6GFRhBLBPJT6D8y1tUq2UFKgqiAZX6e+yUMag47l9HSCuN9JQpRCN/gSlOKZNA
 gqH6BdjztnGiASBVSSWuSy4XzMfYkop7GAF/0E79yy/Py0HotvkEBftPPZX+P++roc+v
 4Y+1Ahs3Udr8PI3LUo8zHqM6PNWK0kDLaNu6xnq6uaCIITFXqgpxSLomeW1L1CyOCFZV
 qYwJLal+OgB6y82FqlXlRUXITg91uu440IdX+4IGZxhCXMBa+Hdr9C2vwUzizd1Rt4Di
 CyXJ2FalI897rRix5gAkqPhIA+DaVuZGmtBLJyAbarzqEQdmRLsAACnQE4hlIH8wO866
 qypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787146412; x=1787751212;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UugSc4hYtZ2PiNBYMlOraIcKuxDijNZvpJVp9vnEZ7c=;
 b=GMgq3y0yFE2UvQcOMFzSc6JsoI1EFSHBmoULF+MZy+v2D3xZAI7XEEEa/Eey+WxyeD
 6dpqQVccC2wv2xhj11Ci25y34GgmbQ77fXjKK7Xjp7dRcJCrc5NkGJv90nQw6i2OVnbZ
 bHoCEWkW89tTJqs95c0vSYUyKItKBxAGfNylVU1zbuvCwt0+sJMVHKg843DSq5oVY486
 yYbnIOMX3VuegpWlyr+Ga3iH7cB1oQN598+fbFE56f33nf+D5Gh4aCQWb0LBhAoCN7Og
 SUtR/hN2M2QZXvPiQqfdoNTl7NhQud1z3fELDG6LImzxeoD6k75AYpGDa7nhwo6Wnss1
 Txzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIzyCO5kekCLjk0sg9DAYb76SAGeroT/DIr8PzXaNsJNprogZVXUFbYwqrSFjnKLrDUFkDjjxMdShSZhsa@lists.sourceforge.net
X-Gm-Message-State: AFuF++k7v4SUXNbotmHbeZgsSJ7v53Djk6jompq6jmoH9ygIpff7jwJi
 y6exav5b4JghpGKRYFShzZhSzmY4uiIRP4xyLVYwCGAmcC3eEe8NUOmVI3NzMjsPubQ3l/n5y4o
 PhwKc2L1FSSJ8pZ3Qw0bzWGffnFjjpU34u/yaRs0b8Jcue1oRH3juITVrCkUY/Db+phu2
X-Gm-Gg: AR+sD11gWgegS3DfY7nPQ+ufTmkzBhVS9khMzW+L0mJ2fzLOtaVo36xqpt3uoAL0G5y
 J09HSDuuQHK6yp7425HzKi9HU0o8o4WDf437gH2ixCO7GX9Q0s6W+dKFLXa8PD9cA5LIJwFR+w2
 tjbJUDZNAMymDMZw+P/vBchhNirYXcgpyhFANcf93NUWoxmDaKuKWPnrR14WI6RRySG5E4RJ8hp
 rC5FHnbSVF5E/yk61gjHVlBIwuTNJYcY3zD3UhDEKabGiWgQy+2Mmx+cQdhFlJ+9elDhvOOOLDa
 GENTi2XrbP6YT+fkcMxjftQKVcdP74+TQLAiGR9I0zINBYErkMSdhVzaAYmBGxbLdPOJl7leLnT
 3Y1odTyWg/+DjmzSudTg5Hnqgz6qdDeIww4mrwePLppl/HPFRxFM3cHrB/w22KeWo/e8bV+4bmJ
 pQf4mw/Dqj5Xgt4LFTdn1lPL/J+wO9hLy5mNVZDyty74YGD0l9BI+OAfFzKFtYHlVJ5/OEqEDgh
 EZzJDobC6e8y11dJW3etgWajQ/q84FBbj3Tnu+gPu2T/uo0DQVP/OtcT+EfhkF6poRwlEvYOCWw
 6g8CkcSLOT7vh3m7MmIrtb2tY8MrIb1m1R2gIw/PPl8sa9yMjgk=
X-Received: by 2002:a05:6000:3c1:b0:47f:9158:5924 with SMTP id
 ffacd0b85a97d-482b1066a59mr9691862f8f.9.1787146411545; 
 Wed, 19 Aug 2026 06:33:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8050sm5865002f8f.19.2026.08.19.06.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:33:27 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:33:26 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 1fb0b5f4ecbdacdf2ccf0596d57363adc405c1d7
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 13:33:26 +0000
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <898862b5301cad4f02b5e2d5029df40cf7b03a08-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgQH-0003ku-Sz
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 gen-release-tarballs.sh: Remove
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3634181125875499786=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3634181125875499786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ImePe77qooA="; charset=UTF-8

--ImePe77qooA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1847?usp=3Demail )

Change subject: gen-release-tarba=
lls=2Esh: Remove
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1847?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Change-Number=
: 1847
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 19 Aug 202=
6 13:33:26 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ImePe77qooA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">change 1847=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10b9=
12bad3bb0b97e2b47eae20d2dd7ffb0c6879 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1847 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 1=
9 Aug 2026 13:33:26 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--ImePe77qooA=--


--===============3634181125875499786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3634181125875499786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3634181125875499786==--

