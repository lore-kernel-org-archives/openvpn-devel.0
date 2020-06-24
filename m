Date: Wed, 24 Jun 2020 12:28:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200624102804.GM1431@...1296...>
References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QAweyt527+VBegUZ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--QAweyt527+VBegUZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 03:53:52PM -0400, Selva Nair wrote:
> > So what option do we want?
> >
> > --dhcp-option SEARCH
> > --dhcp-option DOMAIN-SEARCH
> > --dhcp-option SEARCH-DOMAIN
>=20
> RFC 3397 calls it "Domain Search" so it has to be DOMAIN-SEARCH, in my
> view.  Platform scripts accepting other forms in foreign_option is up
> to them. We don't have to officially support that.

I like that argument.

(I do not care too much which string it is, in the end, but if we have
an RFC which has a name for it, and that name maps directly to one of
the candidates, this is a strong argument :-) )


On the "shall it be a single occurrance with multiple domains in it" or
"shall it be multiple occurances that are concatenated into a single DHCP
option which then has multiple domains in it", I do not have a truly
strong opinion.  So I'd go with "what Tunnelblick has", which is
"multiple occurances, a single string each".

He who goes first wins :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QAweyt527+VBegUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8yqzAAoJEB2Cnv7KVigSWQkL/RdnHN+9sHC5a0CUareUmjcn
Pke4i2IlAKO0KUCwyizmvqX/JjZeN1LICzK2UbbXkDpKTPcQl2ujBoHV3YzTFH/l
UljTcJJK86yMgL1J2OZ1yeOe7iBJd3KylltKcH/2BeTTfPkm0wqwKmV/7B3BnDhP
gHOrGQwdCk8LPH8CQQ2HyigW2ylnW96BooL4Kryn3XxLE19j60EciBtK9Fikjtcl
i8ogDp+F395QGOzX4wGP/Q9qKkokmxiw9lEVc0j1LZk+TdYQA57lWIl+qoQ+mb0N
w7S4KTn236EvtPXFSFDScqU5IBXc6ZO+KNKLRAugtJC75GYa32t7cay3uC7VpwKI
3A7OtcyJEFXEyFH3hIT2WcAA1BPNG6QFSPytlGX2vs/blhbkon20ljDbj4900bSk
vmjwNZ6tDvWPY/31WJsJvHctSKjkNCnB+H0Xg5OYMIAXyarAvXnUlDZfL3voIVxH
W+kaDnISnAk3qYyMfQ61bh81z7X51RodSSezlQFxtg==
=o8aR
-----END PGP SIGNATURE-----

--QAweyt527+VBegUZ--

