Date: Wed, 25 Apr 2018 15:03:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180425130347.GB69387@...1296...>
References: <20180423092813.24844-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tPd0sWeG03BgIodG"
Content-Disposition: inline
In-Reply-To: <20180423092813.24844-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>, Christian Hesse <mail@...1798...>

--tPd0sWeG03BgIodG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 23, 2018 at 11:28:13AM +0200, Christian Hesse wrote:
> @@ -1151,6 +1151,14 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
>          /* set user and/or group if we want to setuid/setgid */
>          if (c0->uid_gid_specified)
>          {
> +#ifdef ENABLE_SYSTEMD
> +            if (sd_notify(0, "READY=3D0") > 0 && getuid() !=3D 0)
> +            {
> +                msg(M_INFO, "NOTE: Running from systemd with non-root ui=
d, skipping downgrade");
> +                return;
> +            }
> +#endif
> +
>              if (no_delay)

This is not a good approach.=20=20

If you run with a limited capability model, then just do not set "setuid"=20
in your config files, and document clearly that this is incompatible.  But
do not litter general-purpose code with #ifdef SYSTEMD bits that will rando=
mly
ignore user-specified options.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tPd0sWeG03BgIodG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa4HyzAAoJEB2Cnv7KVigSqqsMAJfDzszHyDw86A/Ei+XXwFyL
uS7fEZFvOijH7hwD783qWsN2IQVgMKhDt8nHoRSNPO6TFjJY716KPigclqmjeA4F
QhwW0ERLIJDc9w64jIQyhjneqSZy3SJgHR+c/2EliKQuLccjOk0kn3aokZuNRadg
51FAmjKASIfPjgvALnsYp5dpUvmiG3lmMElsKRxh5pH0TBRtyt1zt6fWjt5PE5K9
tZazhOpHSD/IdknRpPP6bF3QpSmaVDZhmH573S/YljoNPgxOsOZjZyJK3z7w10+3
//CMydFWX6XnJiP8x5ICBkA4GJLG4DNmYNBraqhwFUwRpsVUb5bc3p/c42ZrG7aR
oAEARDAkECZgJypkFHtg93lUuWIpq4ZwDgFzXx/HBEcIWG8aNn8JKeTq1Q5mT+t8
BrBDOSQHhjZU4vCtXKtfrx7qNEWV6E1GDZgQu4ESC7knsfA11vRG9KyjbeePF5p2
pZrHi4re1nX5K0cMr3yjDsBlvYTsec2fwwTssHk8PQ==
=KZ5n
-----END PGP SIGNATURE-----

--tPd0sWeG03BgIodG--

