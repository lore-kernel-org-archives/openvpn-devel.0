Date: Tue, 6 Dec 2016 21:33:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161206203324.GM78624@...1296...>
References: <1480707729-19578-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aQ0PHH3iiKbaMI5N"
Content-Disposition: inline
In-Reply-To: <1480707729-19578-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Correctly state the default dhcp server
 address in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--aQ0PHH3iiKbaMI5N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Fri, Dec 02, 2016 at 02:42:09PM -0500, Selva Nair wrote:
> Also correct the default ifconfig-pool end in docs and comments
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  doc/openvpn.8        | 4 ++--
>  src/openvpn/helper.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

"why oh why"...


options.c:
  o->tuntap_options.dhcp_masq_offset =3D 0;       /* use network address as=
 intern

tun.c:
      /* At what IP address should the DHCP server masquerade at? */
      if (tt->type =3D=3D DEV_TYPE_TUN)
        {
          if (tt->topology =3D=3D TOP_SUBNET)
            {
              if (tt->options.dhcp_masq_custom_offset)
                ep[2] =3D dhcp_masq_addr (tt->local, tt->remote_netmask, tt=
->optio
ns.dhcp_masq_offset);
              else
                ep[2] =3D dhcp_masq_addr (tt->local, tt->remote_netmask, -1=
);
            }

"if no offset was specified, do not use the default setting of the variable,
as the code suggest, but use -1 instead, which conflicts with both man
page and code documentation"

But it goes on...

      else
        {
          ASSERT (tt->type =3D=3D DEV_TYPE_TAP);
          ep[2] =3D dhcp_masq_addr (tt->local, tt->adapter_netmask, tt->opt=
ions.dh
cp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
        }

"except if it's a TAP device, in which case we actually *do* use the
same value that this was initialized to, namely, 0".


I'm going to merge your documentation patch now, for 2.4.0 and 2.3.14,
but for git master we should revisit this piece of <deleted>, get rid of=20
"dhcp_masq_custom_offset" *and* make it default to 0 for both tun=20
and tap...  (since there is no difference that the windows side of things
can see, if .0 works in tap mode, I can't see a reason why it would not
work in windows' "tun" mode).

... or why we can't just use route-gateway for this...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aQ0PHH3iiKbaMI5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYRyCTAAoJEB2Cnv7KVigSvNwL/RSEBN7VAtBSFM5FlEQqYRP2
nEQbTMaEnqbLIiFKYjkIeVxbSLaiLm9/bCblU1IdJmZZpfnmhmzpsabY6GVAeE12
31IT0wZk2dniiiwC6nqYjWaKqdjU3IcOqPCjhsaD3dp5caqcBPc0EsN2Mu38BIp0
5gL2zJL1Z5qKgbx694Tjh5BAHnIZNtX+7egqjVEWSAkEewE9zXESJIr4dLPB07nu
4BEU2Wac4NP4rZ/Zi2ltZqNENA3GAE+d6+mB699muBM1A1vGpo6cxzNSTVRDk8+G
ykrEMos9hasUhOqvf+cjcivnttKopEp9hdTBzCWT1wMOlz5/vUZN2iWN+efnvMew
mJd7ikstTufyhcQrnsrVk7kgBd45hwkimpaJ0z9N/MVS/qADb1qTK9qnAKoNj+rm
yOia3SmBHOhEeRq9fbjq0Y7/gZfloSa7zflLQ/usyRp55UKTujhRSIPUvwCmHrVu
P7xLwoiXtosT6rUBNGQDGEDNml7uj4YDrSVhH1TQmg==
=khb2
-----END PGP SIGNATURE-----

--aQ0PHH3iiKbaMI5N--

