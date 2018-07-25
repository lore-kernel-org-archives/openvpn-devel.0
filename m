Date: Wed, 25 Jul 2018 20:00:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180725180018.GA55859@...1296...>
References: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5OY1VMnxNaoJKAjw"
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
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
To: Kevin Kane <kkane@...2393...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5OY1VMnxNaoJKAjw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as a side note, your mail client massacres leading whitespace, so
the patch is all squeezed to the left side:

On Wed, Jul 25, 2018 at 05:01:39PM +0000, Kevin Kane via Openvpn-devel wrot=
e:
> diff --git a/Makefile.am b/Makefile.am
> index 8301087..d8435ed 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,6 +2,7 @@
> #
> #  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
> #                2010 Heiko Hund <heikoh@...1345...>
> +#  Portions Copyright (C) 2018 Microsoft Corporation
> #

... which makes it impossible to apply without manually adding the
leading space in non-changed lines.

Interesting enough...

>   *
>   *  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
>   *                2010 Heiko Hund <heikoh@...1345...>
> + *  Portions Copyright (C) 2018 Microsoft Corporation
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by

... the effect differs...


But anyway.  If possible, use "git send-email" (which is much better
at not massacring things than the standard clients) - and point it to
something which is not Exchange.  Unfortunately, we've seen that as
well, git-send-email sending via SMTP to Exchange, and Exchange hacking=20
and slaying at the patch...

thanks :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5OY1VMnxNaoJKAjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbWLqyAAoJEB2Cnv7KVigSFwUL/2GypX6E0Jk+MGYQ59kO9A4z
6KLDmpHLIxbiiAt4+7wUKZIZPKZRT7e7q2v66YjS8rUkBlBYZOrnk4EROp995p00
SW946X/LEpfH2Q49WKv579tDoMkAv3CwOCS355fMI3xbZ6LKQsGTRa05qm7JMa48
5TvwsElgxwETqJE1C13/5HvxyP10SLynxBrgUJzAkE+V8m9CrBOwKSl3Qx4jVAen
8l0mbMIVrfBXPslSiHYmcoRuyCLOtlIHLRnbc5ECR8Hp6cHrz1ysRCkHfC53JSyO
4+8bhkdkrJ217+dBp+z9xJIqG9voC6uB8fQyL8ofom16jlmmqZpRbhJJN4gsyGAY
T0r3AU3TFl0ZnOBDQPqnwVZu4BJLT6OQh+OIoN+aK6ELbnZOmJYUyOelCNg8vAI6
vX4804lHoWsu3OzGCzXBGcHT2EaaUrpT6URzMnENrMj/KJTMy8szdJHrlXfXIvq8
Y1HzAM1I7HmexsoYChaiAVQNskfuZ8cZL0QBJMUF2Q==
=AlL0
-----END PGP SIGNATURE-----

--5OY1VMnxNaoJKAjw--

