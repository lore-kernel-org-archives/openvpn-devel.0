Date: Tue, 23 Nov 2021 07:52:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZyPoyofdC4M1CqU@...1296...>
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ED1yeTBXu8l2QlxZ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ED1yeTBXu8l2QlxZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 22, 2021 at 04:55:40PM -0500, Selva Nair wrote:
> > (Also, the PR isn't exactly proceeding smoothly... no idea why the
> > vcpkg maintainer does not want to see why Lev's PR is an improvement
> > of the situation)
>=20
> I didn't realize there is a pushback for the patch..May be he needs to see
> https://github.com/openssl/openssl/issues/9520,
> CVE-2019-5443 <https://nvd.nist.gov/vuln/detail/CVE-2019-5443> and our own
> CVE?

Not sure why.  Maybe it helps if you add another "pro" voice, with these
references?

But on the other hand, he's right about "what if a user installs $program
to a different location?" - thus:

> I have a patch setting OPENSSL_CONF etc using SetEnvironmentVariableW() b=
ut
> it needs more testing especially for OPENSSL_ENGINES and OPENSSL_MODULES =
in
> 3.0.
> Is _putenv preferred?

... this one sounds like a better way forward.

I have no opinion on _putenv() vs. SetEnvironmentVariableW() - this is
Windows API stuff, so whatever MS thinks we should be using...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ED1yeTBXu8l2QlxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnI+jAAoJEB2Cnv7KVigSoH0MAI9jSDwEhNR4KD8SZ78CDRKE
vdQvWPNzXJRezt7R6AQAZm3IcTr+osoFGVBAcxF8j1+H6Cc2ABzmKV37+Ilwccyx
Myr52YExUTcMlgoXWdxAZox8Mg00qOM8YHjAeslqcpWSsmnxdovrbPha+agfgmrm
RcqVbFoN6m3srBH9UtVzoRsjTQQII66zoNQcH+QTPuvLA6vGOpXOk0t9/ubaHA1B
HbayabCZhV9WzoEDT2HBZ2pyEcojwRx0U9Njl+wMXLa5K9zgGylKXs2xIfqToC3h
15lfy9rpsj+XQhxPBGaVni/QsLNc807R0oYajLzOM9+xyz1oTtsRE1eEDNF5Luh4
rIwv6r8l8BesnzrRRE94r0NxE+V70zNxd5lEOAMDDt5168oAL9n6ZLwLw5iZsmW9
8q+cZCgt4MzMUKD+rLiK1laqfCc881WTihJslktDyK3cKLyPyBCtyQJ2wGdbouOe
YNNZok3fKNmlBWbZ5ljJy3WJ9F5tqswG8FmheLNxUA==
=kP+N
-----END PGP SIGNATURE-----

--ED1yeTBXu8l2QlxZ--

