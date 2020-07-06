Date: Mon, 6 Jul 2020 18:15:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200706161532.GH1431@...1296...>
References: <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="G7SfBfHzTWG0aRm3"
Content-Disposition: inline
In-Reply-To: <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--G7SfBfHzTWG0aRm3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 30, 2020 at 04:15:58PM +0200, Jan Just Keijser wrote:
> On 30/06/20 16:11, Gert Doering wrote:
> > On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
> >> @@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, c=
onst struct tuntap_options *o)
> >>       write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &e=
rror);
> >>       write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, =
&error);
> >>=20=20=20
> >> +    for (int i=3D0; i < o->domain_search_list_len; i++)
> >> +    {
> >> +        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &er=
ror);
> >> +    }
> > I assume that this won't work.  In the DHCP answer, it must be a single
> > option with the concatenated list, not multiple answers with a single
> > domain name each.
>
> see https://tools.ietf.org/html/rfc3397
>=20
> "
>=20
>     In the above diagram, Searchstring is a string specifying the
>     searchlist.  If the length of the searchlist exceeds the maximum
>     permissible within a single option (255 octets), then multiple
>     options MAY be used, as described in "Encoding Long Options in the
>     Dynamic Host Configuration Protocol (DHCPv4)" [RFC3396 <https://tools=
.ietf.org/html/rfc3396>].
>=20
> "
> so you MAY use this option multiple times - and wireshark groks it fine. =
I don't have a Windows 10
> client to test it against, however, so I am hoping that someone (Selva?) =
can do that for me.

I did test, and my initial suspicion was correct - Windows accepts the
option, but only one of them.

I am pushing

  dhcp-option DOMAIN-SEARCH v6.de,dhcp-option DOMAIN-SEARCH leo.org,dhcp-op=
tion DOMAIN-SEARCH ov.greenie.net,dhcp-option DOMAIN-SEARCH nekosoft.de

(because these are domains that have more interesting hostnames in than
just "www" and "mail", so I can see if "v4only.v6.de" is found, or=20
"dict.leo.org")

and "ipconfig /all" only shows the "nekosoft.de" one.

This one works(!), so generally, Win10 accepts this DHCP option - but
it seems to want "all domains in one".


Can you send a v3?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--G7SfBfHzTWG0aRm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfA04jAAoJEB2Cnv7KVigSOZEL/3G7NU7mmb5slk5XlnyQVW9d
Ai3voPVgoII9EAyBarPhrHLniiTpXiQJeUilwX8WsqcBlhJD03UOfkr939Dg0e0W
TyyGO/sARWdv+A8rY8MPZQoFRuIFd4bz4a4fBjKcCFjlov9VAJouPd720+hBzHaZ
hA5GGywQ3CItS/7SZ5mnOsmR1lZDm5G1XFs5ceuYLqSvtfhiH2sm/ZmvmWwvfQmm
+WD1A4FdTiWnuTkMOBe3s6q8XHIp37xsRBRpq4YbfkK0APiOpCFGo5o+f+3xubNJ
y1n4sbs5FxyhewcTRWgAtTyAbt7QRelxf0yoIDcRsH8p+xLrQQzIh5aFU1v/vx7k
o4wJCz5Qg4p/gEOcAg/KDB3JwAMoKXFPgtPFx5ArTnp7fYGLadHFnLaJ6wPioYzS
Ah8J2Msy+pWBn0UN7l0fD4cNkCAQ9GXr4lVu/H3+pH3vhIWLSbeTo77wIxUG+C2z
DL4YOTtkzJYaEmuxig4+dpElMIpq39vd1d3+innrKg==
=m9FB
-----END PGP SIGNATURE-----

--G7SfBfHzTWG0aRm3--

