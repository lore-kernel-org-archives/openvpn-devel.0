References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
Date: Tue, 28 Mar 2017 14:35:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170328122131.GV93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JLAFWBfhfONTlfBWNBeJbNr5uwcBTw9AT"
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JLAFWBfhfONTlfBWNBeJbNr5uwcBTw9AT
Content-Type: multipart/mixed; boundary="x8VIr5kQSHsQs7NMfVwVFELTcQMe417cm";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
	"crypto.c:823:32: error: invalid application of ???sizeof??? to
	incomplete type ???cipher_ctx_t"
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
In-Reply-To: <20170328122131.GV93896@...1296...>

--x8VIr5kQSHsQs7NMfVwVFELTcQMe417cm
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/03/17 14:21, Gert Doering wrote:
> Hi,
>=20
> On Tue, Mar 28, 2017 at 02:11:26PM +0200, David Sommerseth wrote:
>>> That's great!  This way, 2.4 does not have to change it's behaviour.
>>> Still, I think it makes sense to deprecate --ns-cert-type, and remove it
>>> in favour or --remote-cert-tls in openvpn 2.5.
>>
>> Based on the feedback and discussions in Fedora regarding to us removing
>> --tls-remote .... I actually think 2.5 is too early.=20=20
>=20
> Nobody suggested removing --remote-cert-tls.

I don't think I tried to say that :)  I mentioned --tls-remote in v2.4
as that caused quite some noise.  I actually had to add a patch in the
EPEL packages for EL6+EL7 bringing it back again, to ease these complaints.

> This is about --ns-cert-type.

Right :)

>> We need to have a
>> patch very soon complaining loudly in the log files=20
>=20
> Like, 57637d0f677d824dacdc83d858357ccc80723f45? :-)

Ahh!  I completely forgot about that patch.  Good!  It's even in v2.4.1
already :)

>> and get in touch
>> with at least NetworkManager guys to ensure they have time to implement
>> a solution when this goes away.  So I think 2.6 is more realistic.
>=20
> Shouldn't be so hard to do a string-substitution in NM...   with
> 60b23236329e6921729f51e7689042a29c794a6b, this is really straightforward

If the behaviour is really close by doing a substitution, this should be
good enough.  --tls-remote to --verify-x509-name is more complicated,
due to character remapping and such ugly details.

> (unless your certs are really, *really* weird, providing a proper=20
> nsCert extention, but no proper keyUsage/extKeyUsage extentions).

Well, despite weirdness occurring (Way too) often, I think we can live
with that noise if we have given enough time to adopt.  As long as we
have a real and solid argument they have been doing things wrong in the
beginning.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--x8VIr5kQSHsQs7NMfVwVFELTcQMe417cm--

--JLAFWBfhfONTlfBWNBeJbNr5uwcBTw9AT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2livAAoJEIbPlEyWcf3ywIcP/RMFZJKvEnzqEb44eX0bZ1Zf
9NMtrsEpviu1gnN9lBUUXF5+EzdurUPoZMWBQSoMXQrSI9c3yufRwNi2C87ziiyE
rqIRshA443IbNmLtawfE10BGVVt1Wy4EtYHvxJnLW4rK1OKKT5hiBK0NhYmrd6vd
vWOOLUN1pB4o5uWXMgu3I+uBGsh4a1Ys91lGIEGhenMZi2nDkg2QayFm9uQCoKey
3OdIqvuAWfjkmh526EXaZ3eN0f80XFeRlHTxJSdHhEmxEiy4r4+uJAUCKcLBMkv6
hmoBmORPSOTAFMA1ADoHBDaXXLLmtawzuUMp05txU05bzMpmzwvuGvgNmgHAMCGV
5ppntp92fblenMyCY9e1IzgsMIeEcI7bhanJmtYe6BjT3ol+srC1LF+sD5d5ESzw
LlLZw2WHYsCQAbVgTodYb8zTVphejW/VdiD0AXXfEzwR2BZWnW4eBJixuhRGehV0
YMPxJ2yN+Fia+8M5hWcrM5VaSHa+pXWlP2KsNRoG2gg1DUvHBRtPbtdqy9JXw/wc
zI0NSCB5lDOD1SZU+DIxJ9+9T+zuhf5LM7Nanbbxo6CNWxaC1FNgqOSQ/wI9ClgU
iW3ONOMBVuxPAMb5aVki3dxjaIGpQl0e5S494zz+ehHqKppjpCFInDrBtVQ6xgqN
NEEiBQth98dOoChdOCqg
=ivTW
-----END PGP SIGNATURE-----

--JLAFWBfhfONTlfBWNBeJbNr5uwcBTw9AT--

