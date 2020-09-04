References: <5f81e5b6-7500-7754-0296-0665c85fdc3e@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2fb10cd6-296d-5aa7-c078-cd7b04f4fc6c@...2080...>
Date: Fri, 4 Sep 2020 15:36:07 +0200
MIME-Version: 1.0
In-Reply-To: <5f81e5b6-7500-7754-0296-0665c85fdc3e@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="U182Idvg1t27CpyCiuhzXq3txD6IY5cxR"
Subject: Re: [Openvpn-devel] New man-section pages format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U182Idvg1t27CpyCiuhzXq3txD6IY5cxR
Content-Type: multipart/mixed; boundary="ZgbdxJxefAQL4lukLkRdAMfC8kwqs2P5t";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <2fb10cd6-296d-5aa7-c078-cd7b04f4fc6c@...2080...>
Subject: Re: [Openvpn-devel] New man-section pages format
References: <5f81e5b6-7500-7754-0296-0665c85fdc3e@...277...>
In-Reply-To: <5f81e5b6-7500-7754-0296-0665c85fdc3e@...277...>

--ZgbdxJxefAQL4lukLkRdAMfC8kwqs2P5t
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/09/2020 15:21, tincanteksup wrote:
> Hi,
>=20
> this is just something to chew-over..
>=20
> See:
> https://github.com/OpenVPN/openvpn/blob/master/doc/man-sections/generic-o=
ptions.rst
>=20
>=20
> I noticed that generally the option names, eg: --auth-nocache, wrap and t=
he
> result is unpleasant.
>=20
> However, further down that same page --daemon progname does not wrap and =
looks
> much nicer.
>=20
> I know which format I prefer, perhaps this can be changed..

Do you mean the wrapping in the HTML rendering on GitHub?  That can only be
changed by changing the number of characters in the option.  It's not
something we control, it's the GitHub .rst rendering.

$ echo -n "--daemon progname" | wc -c
17
$ echo -n "--auth-nocache" | wc -c
14

IIRC, the limit is more than 16 characters, and the option gets a cell on a
single line.

Now, if you find a setting we can tweak (even a .. notation in the .rst fil=
es)
where we can reduce this limit to 2 character (which means all options gets
its own line - which will be consistent all over), I'm open to consider tha=
t.
 I haven't had time to dig into it.

But I agree, the wrapping is not nice at all.  That said, we have had more
focus on ensuring the man/*roff rendering looks nice and reasonable more th=
an
the HTML rendering on GitHub - in addition files which are more easy to edit
in a text editor.  After all, the HTML rendering was just a bonus over the =
.8
rendering [1] on GitHub before the .rst conversion.

[1] <https://github.com/OpenVPN/openvpn/blob/release/2.4/doc/openvpn.8>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--ZgbdxJxefAQL4lukLkRdAMfC8kwqs2P5t--

--U182Idvg1t27CpyCiuhzXq3txD6IY5cxR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfUkLRAAoJEIbPlEyWcf3yI0MP/0Tp6h59PiFdHPddMRYhccNb
K2i0QyKx4wHuok4GG6yjZaT4bhwru0P+j9dyU4u4E8vJMllvoqsSvsxIHb51dGMF
wsYxMZx6ykIUY7wlr1rSOXftcPAsN0rrm/FKklgRIXbxoe7FJZUIpgIQe7uxSOMu
iCAYO6fx5eiiqzJSdCoSYwf2x61fzSH9licdrpKDoatLFHLhbfi2PUFTGElASwqS
bqZz1zMHZ8+jg2v4YEbQlu04rGVJjr451l68Q9/Ky1mJACRoqJBqYsHRnK/q61VQ
UVzOG/CP3lMFKIQMw2GH92gKxpuMnJ+rzYY+J/nNnDSZgoBOuta1ui88OSqwBc9M
Eb546uh5vZvw6iTl8nbRZYzT0S63LWXfQ3k7Prw67/KxZ1Suf7Opu/8RfzfPPib4
tiM4VqDZUB0iHeK53yxx0GtwWYlFwpiRVK/svFeYEbxb85qVYi7CsCjP3tXLMalB
W1ONPEJPh21Jf1wUT6sIHV8rKWLfuZyFVSm/eKXvl5VrAwlGjiuCt8KLDAUW0ZyX
rS7Gsl3w+AOqx8+kGlyOpCU8oxXCtCPb/ELB4mVIeJ9OGudz+NOdTmY+wza9sIwz
GqbCci5/MiREBXDL1L977t0+wT+MsoD3txBY46Hu6YNbbg57MGTwyoguSYPDZRX/
ht1Tt5i+CoJ1McPvrcOT
=/OXW
-----END PGP SIGNATURE-----

--U182Idvg1t27CpyCiuhzXq3txD6IY5cxR--

