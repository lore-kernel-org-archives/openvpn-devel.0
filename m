Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5F8C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:From:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:
	MIME-Version:Date:Message-ID:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=leBn38eydzSd2ky6/9dauDAQ/FujJnGTZhRADsxStY0=; b=OuYsM5Kzt0gc3fNvN7TX8dbeO3
	BDDmvvS3ic7Ccd6SEa1NrAmEu/g+sNRiru4LBHqvQ829LOdbVWRtRGLADsQrNa+gNIOs08IXtTCP0
	uh/YAnijZ55xsGwRmwTb6/v1rldTg08uWFAEv3RexRa2X+ad1hKwnLnxTeqS85yKDxxc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrd3G-0003ja-VZ;
	Wed, 05 Aug 2026 14:57:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <johan@openvpn.com>) id 1wrd3F-0003jJ-Ag
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Subject:From:MIME-Version:Date:Message-ID:
 Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0rzW6RUf1opFrJuUjD8bUI7sJ7UoT87rVkDWirxkRUg=; b=JkZwfBwR2LyHrfyNqTRzdsX5gI
 R3sGh2oT9n32eisB1JFB+oJTTbnS1H9bvpet2UXm/i/XTWf4DCnO3MyZjc62Jc+22cF+25/RNk3d5
 ++qGRzEDyLPidhz2jHE7A774On2wcDesPu6/jRmaYxP6AJfQVzTYOmpePJNE3qCTKkpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Subject:From:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0rzW6RUf1opFrJuUjD8bUI7sJ7UoT87rVkDWirxkRUg=; b=W
 YrGqIC2gR0e23Sozq84GXjGUk+zuDk0v4TDZuWJy8u8dedTP4Bd2Y09G6nMNC31eqvfg08X476DIJ
 PQD58c9z0MisSDB18gb/VL17/Gr5uBuS5kgJJgxcgKx9NJTbrD/eAHGpqyCqgeV++XDDCaWmm1VDz
 BsGcVnwluX1WcfTk=;
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrd3H-0001ht-ED for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:57:01 +0000
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1669642b3a.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.com; s=google; t=1785941814; x=1786546614; darn=lists.sourceforge.net;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0rzW6RUf1opFrJuUjD8bUI7sJ7UoT87rVkDWirxkRUg=;
 b=jMwHb17xKnyet6ik5h/Hwu4iMTPBjvXs96IsuJvWWOjcP8RorOvgydV8WndgczEHxe
 XvPyB5RdbmijTfZpYMu/L4V8ix5sKkkH6jIkzf/bIwrTP9cLDgnD+Vi/nxTs4CZQZwSw
 CGhevOfZvFI6exZDDdGJT1QGCZE87s55QQRMy8s+IlcZOwflHKJS5tPM3rpYd9AgEmSq
 ZLRk1VJlhzi07wCK8OU41EctYHl211lI49TV+q9TUAi6YrN+sOb/fZodMS/ALo/WGowa
 LxES3MlC+mwB/9bX6nB4Y1ipkTYRyFnQEAPEPKGekf/nWQW8DamzvwvvDzHNQ0vJQJM7
 8H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785941814; x=1786546614;
 h=content-language:to:subject:from:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0rzW6RUf1opFrJuUjD8bUI7sJ7UoT87rVkDWirxkRUg=;
 b=eo8OplPB7sCEFZikmchApqLqFSDvP79TtyclfiRnd7EMUzzTn+VCfL7AUlY15VP/cn
 AFttLGY9/rjnn+CrwRjXHJcjUEpRe4Nr+FM87ZJN+lnzyDZPFzWERP+Cu/Gc3eVLcRrd
 q/j97RuoizMFurQJondN98IU1XYXqC1XHXccmPPruHvE/ESH80oNL7dxGOfk9nn/CzXO
 CO8+gxdBXfTJrpiP7r8W3mJcy1NOwaJoQqTedLnrRzE1HLYJRzG1bXHO4aF63F0yUjv0
 P+2ygDKSaZ0pMGKgvYSu/LEKbPAO8Q76c5Q0xkgLTlFCiHvCGkCT9LlgHfjnyK+CRVwc
 Ts9g==
X-Gm-Message-State: AOJu0YzJjW1LE9vz1PWgcyEgsPEqmBO2FWrfKcraRudmApHc/lX/AgtM
 qR+o2ddhsHIhGmK1BoYbWDyTglzSF/98nN9ONgLlur01Jemd3vQqaZjX35z0O6JWvC0VnSGrFRx
 rgyaKyqB315+LUe3YQ/vh1D8md3nCSg2p/xPk7g5SXzNCbQ9pPPh/JJrBkoVsUcKNs/+O4MD9BT
 D+zmBoZnXV
X-Gm-Gg: AR+sD11qxDdmtixOi4/fhs1moOBW+XLIaq9g7Jpl1SRufStO/66TY/tUAYbS+4R/Lag
 oNFpPj9o17hSrSdTqaVFFVkvw6/MwRuIj408NucPGM0Ck7y15AoepXnuy6Sxxot4dLvtdExjx0B
 sL0zJhIeffWztVdbdakCFcsztn+PzuxufgTe/lrlnKzM6dMckXIIumytkxOXwOmUUAyTzcCVc54
 o1/hZdx2Yg4dpZzySIrPhGw8XZXnBn4Ju/pPVxbRvL/SK7FYuNBAnxOl9OBkOLwSqMmqPC/Aoy7
 pFPyNZ2V8J/5USl6wCfpC6+RPU5eRJg/E3RFGjSfbD1fS5SjBHChldevMgVxF6O79ef+d1YYswk
 +7dFH1FkPPspMH6TWoJO95NLfwpldAUo6O2DpDOf5UPHM9jA4kSyuh3BQcQ0trperkPSjP2QTgs
 tjYI18wvyZQ06WYxrgtbK/cryipOedzTt0b5iJQ3L4a1bzdylEdBcbuzQGMTIzSEtPxCz8+WEzZ
 c4DDvRCWkvdEruchwhBJzXjwpyERbDN5A==
X-Received: by 2002:a05:6a00:440c:b0:848:487c:ce05 with SMTP id
 d2e1a72fcca58-84f2dfb4e7emr8854094b3a.7.1785941813996; 
 Wed, 05 Aug 2026 07:56:53 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f83:3c70:7318:2779:d76d:8419?
 ([2001:ee0:4f83:3c70:7318:2779:d76d:8419])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f2e2c2421sm1026473b3a.1.2026.08.05.07.56.52
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 07:56:53 -0700 (PDT)
Message-ID: <4579e6f6-0d3d-433b-a74f-6e1c8ab629aa@openvpn.com>
Date: Wed, 5 Aug 2026 21:56:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: openvpn-devel@lists.sourceforge.net
Content-Language: en-US
X-Headers-End: 1wrd3H-0001ht-ED
Subject: [Openvpn-devel]  IRC community meeting summary
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
From: Johan Draaisma via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Johan Draaisma <johan@openvpn.com>
Content-Type: multipart/mixed; boundary="===============4274406675068866665=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4274406675068866665==
Content-Type: multipart/alternative;
 boundary="------------Tlx3cU14tdm1p5CMMgwunwff"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------Tlx3cU14tdm1p5CMMgwunwff
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 5 August 2026:

  *

    *Updated: 2.7.6 and 2.6.22 release*
    We're doing a 2.7.6 and 2.6.22 release today with some security fixes.
    There are also some security fixes backported to 2.5 but that branch
    does not have official releases anymore (out of support).

  *

    *New: publish also on codeberg*
    Suggestion was made by cron2 to also publish openvpn2 on codeberg.
    OpenVPN3 Linux is already there at this time.
    It would not replace github but just serve as another place to
    publish the code.
    No clear decision made as yet. Concerns raised about new avenues of
    opening tickets/PRs.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------Tlx3cU14tdm1p5CMMgwunwff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 5 August 2026:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            2.7.6 and 2.6.22 release</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We're doing a 2.7.6 and 2.6.22 release today with some
          security fixes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There are also some security fixes backported to 2.5 but that
          branch does not have official releases anymore (out of
          support).</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            publish also on codeberg</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Suggestion was made by cron2 to also publish openvpn2 on
          codeberg. OpenVPN3 Linux is already there at this time.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It would not replace github but just serve as another place to
          publish the code.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          No clear decision made as yet. Concerns raised about new
          avenues of opening tickets/PRs.</p>
      </li>
    </ul>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------Tlx3cU14tdm1p5CMMgwunwff--


--===============4274406675068866665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4274406675068866665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4274406675068866665==--

