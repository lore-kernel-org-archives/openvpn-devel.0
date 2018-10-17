Date: Wed, 17 Oct 2018 14:07:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181017120745.GB962@...1296...>
References: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
 <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
 <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CYvw4a70jcGnzNfi"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix
 length when configuring address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CYvw4a70jcGnzNfi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 16, 2018 at 05:48:29PM -0400, Selva Nair wrote:
> Going through patchworks noticed this.
>=20
> Thankfully this never got committed so here goes a retraction.
>=20
> On Sun, Jan 21, 2018 at 1:45 PM Selva Nair <selva.nair@...277...> wrote:
>=20
> > Hi,
> >
> > I'm on a reviewing spree (doing my penance), so here goes..
> >
> > Thanks for the patch
> >
> > On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger <eyal.birger@...277...> wro=
te:
> > > Address prefix length defaults to /64 on Windows. This change allows
> > using
> > > Windows clients in setups that use a different prefix length.

I had this on "I need to do more testing with this", which is why it
never proceeded - there might be unintended side effects, so I wanted
to do more detailed testing with "netsh" and with "iservice" backends,
and different prefix lengths etc.

Also, I had the suspicion that if we actually set a prefix length, it
will lead to local ND traffic which the tap driver won't answer (it
will only answer fe80::8) thus causing a "black hole route" for the
tap subnet...


[..]
> Though this works in my tests I want to retract this ACK.
>=20
> Apart from possible issues due to the appearance of the onlink route in
> some cases, I think the correct approach going forward is to stop using
> netsh and use the IP helper API for such tasks. And do it in the same way
> as done using the service.
>=20
> Un-Acked-by: Selva Nair <selva.nair@...277...> :)

Thanks :-)

We'll definitely need to look into this more closely.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CYvw4a70jcGnzNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbxyYRAAoJEB2Cnv7KVigSYGcL/RNEtchkExIqm3DnhX+HzHVZ
f1gfVvyctsrYHtcROancTX00JePh/OWSBQ4Sh4DLM+sjFr/UK3LVMk9KA6Y8KZGw
PY6VDB4S9IeAxokpdmFlO41+hZYH3+eJ2PJJSpnlCJCmYKpj/mKOTlm8/X2sDTk5
FIwBsfCsukjnYkreBwHt8QYkRkmT+y8LxL+dF1rG3qQHCVzDMsDkhn1y5xXZvEDv
czL8f/v4mKF//71fFUE1Rp/vwf9PJcwNv5m4wcEIeskJ01QUj+blXO1L8L1n4GBF
uLCljcIauR6qCMO0g0YDGHtoGsLzS5HLx3XFB8JwBuyIvRgsi5omLBIceNl2CCX5
g+QNpWgXOfkleggQZ4smjnh+cTKbe8ckybNiZ+xeEeGvm1fFOHib4otYbB9hbdM+
YbRmVXEiuCsZez3C0+ADT3mW/1uN5Bzg3zsAWSuOCR/ScTeUAqWBnYNVuDrslDss
3ZJqXrl1Zi0PdoT45kjpyZMkoZq5UNSHU41GItAatg==
=nS5Q
-----END PGP SIGNATURE-----

--CYvw4a70jcGnzNfi--

