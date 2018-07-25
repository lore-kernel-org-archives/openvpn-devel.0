From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 18:08:19 +0000
Message-ID: <BL0PR2101MB1058707381F501AFB7FFA9AAAB540@...2440...>
References: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
 <20180725180018.GA55859@...1296...>
In-Reply-To: <20180725180018.GA55859@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Ugh. Thanks, Outlook. I'd have to use a personal e-mail account to use some=
thing other than Exchange.

The other option is for me to add the files to the e-mail as attachments. I=
s that acceptable, or do you really need the patch text to be in the messag=
e body?

-----Original Message-----
From: Gert Doering <gert@...1296...>=20
Sent: Wednesday, July 25, 2018 11:00 AM
To: Kevin Kane <kkane@...2393...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to po=
pulate Windows VPN flyout

Hi,

as a side note, your mail client massacres leading whitespace, so the patch=
 is all squeezed to the left side:

On Wed, Jul 25, 2018 at 05:01:39PM +0000, Kevin Kane via Openvpn-devel wrot=
e:
> diff --git a/Makefile.am b/Makefile.am index 8301087..d8435ed 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,6 +2,7 @@
> #
> #  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
> #                2010 Heiko Hund <heikoh@...1345...>
> +#  Portions Copyright (C) 2018 Microsoft Corporation
> #

... which makes it impossible to apply without manually adding the leading =
space in non-changed lines.

Interesting enough...

>   *
>   *  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
>   *                2010 Heiko Hund <heikoh@...1345...>
> + *  Portions Copyright (C) 2018 Microsoft Corporation
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published=20
> by

... the effect differs...


But anyway.  If possible, use "git send-email" (which is much better at not=
 massacring things than the standard clients) - and point it to something w=
hich is not Exchange.  Unfortunately, we've seen that as well, git-send-ema=
il sending via SMTP to Exchange, and Exchange hacking and slaying at the pa=
tch...

thanks :)

gert
--
"If was one thing all people took for granted, was conviction that if you  =
feed honest figures into a computer, honest figures come out. Never doubted=
  it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

