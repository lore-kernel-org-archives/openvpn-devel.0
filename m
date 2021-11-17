Date: Wed, 17 Nov 2021 19:48:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZVOeK0S7+TOLfyN@...1296...>
References: <20211117175424.17195-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2JAFpU0S+Wa28Duk"
Content-Disposition: inline
In-Reply-To: <20211117175424.17195-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH] Don't "undo" ifconfig when given
 --ifconfig-noexec
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--2JAFpU0S+Wa28Duk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 17, 2021 at 06:54:24PM +0100, Max Fillinger wrote:
> When running with --ifconfig-noexec on Linux, OpenVPN may still delete
> the ip address from the tun interface on exit, because it tries to undo
> the ifconfig that did not actually happen.
>=20
> This commit reintroduces the did_ifconfig member to struct tuntap so
> that we can check if ifconfig was actually done before trying to undo
> it. It's behind an #ifdef because it's only used on Linux, and that was
> the reason why it was removed before.
>=20
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

I'm sure that this will work, but I wonder why we need to do this
in such a complicated way - the code here is

close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
...
        if (tt->did_ifconfig_setup)
        {
            undo_ifconfig_ipv4(tt, ctx);
        }
=20
        if (tt->did_ifconfig_ipv6_setup)
        {
            undo_ifconfig_ipv6(tt, ctx);
        }

... so why is "did_ifconfig_setup" true, if ifconfig wasn't done?

Or, phrased differently, what is did_ifconfig_setup used for, across
the code, and can we just "not set it to true" if ifconfig-noexec
is in effect?  Or does it have nasty side effects?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2JAFpU0S+Wa28Duk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhlU54AAoJEB2Cnv7KVigS5gUL/Rrdbc/vU4nVPqLmdDbM8bud
HgCoWdU8IoXXvhK6K9dyySp2Z2HgqycZFW9ezh47OzTJbTiU5uZ4z9OwlF/IPG3A
cYZzuxowgM2SJaEYm8IJQCCs2+LbqHD10B3wl6iarw76emnAPKxRkVHaWq2XH2jw
8i2pNdZnueMuJLXnS75Sc/4YRg2w/Sy8/buLm0lDI6pAG2x/uZ2No4k8vCA6H4zk
okgXoRAnrgGdijfpJ1ScS3z9Z2DOE9pVohHBX0H2npEFFhOj12joXDh4dihEApyv
KC1tEIFp6kuVGLvILdJ33WGNp5UCw5v400KqjmSUgQMjruYgrgfD6sdgTU6tk85t
ToN8To6CQSQ3zeyHWdUu9fOBtvVMH5aOwl0E/Zpuyv5Jqi40d/oCH0gtOfTV/bjP
STFchFoZOxgoAy/hx7cauEUkelipqw8D6GPnocAS4U2HbptMyVBFN798YcjUDN2H
FgtTB/q0tilGQu4kxWJR+LLe9gbkRLix7dPMsKUztg==
=M48k
-----END PGP SIGNATURE-----

--2JAFpU0S+Wa28Duk--

