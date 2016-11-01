References: <1477922488-26941-1-git-send-email-davids@...515...>
	<20161101112812.GJ28918@...1296...>
	<ab1e4dae-c231-d48f-4347-a9e7b8c60339@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <cf6bc711-6691-b411-59d5-c5e9348a2ce2@...1435...>
Date: Tue, 1 Nov 2016 13:28:16 +0100
MIME-Version: 1.0
In-Reply-To: <ab1e4dae-c231-d48f-4347-a9e7b8c60339@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vivliv1lhuv7GBxLc7lOpfmVSldWGTfk2"
Subject: Re: [Openvpn-devel] [PATCH] man: Improve the --keepalive section
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--vivliv1lhuv7GBxLc7lOpfmVSldWGTfk2
Content-Type: multipart/mixed; boundary="2f0sd21Ef2tutNpv2KWgepRJLagiaaFev";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <cf6bc711-6691-b411-59d5-c5e9348a2ce2@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] man: Improve the --keepalive section
References: <1477922488-26941-1-git-send-email-davids@...515...>
	<20161101112812.GJ28918@...1296...>
	<ab1e4dae-c231-d48f-4347-a9e7b8c60339@...2080...>
In-Reply-To: <ab1e4dae-c231-d48f-4347-a9e7b8c60339@...2080...>

--2f0sd21Ef2tutNpv2KWgepRJLagiaaFev
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01-11-16 13:19, David Sommerseth wrote:
> On 01/11/16 12:28, Gert Doering wrote:
>> On Mon, Oct 31, 2016 at 03:01:28PM +0100, David Sommerseth wrote:
>>> -.B \-\-keepalive n m
>>> +.B \-\-keepalive ps pto
>>
>> What does "ps" stand for?  I find this not much clearer than "n"...
>=20
>> "pto" sounds like "ping time out", which I find halfway understandable.
>>
>> Maybe make the first argument "t" for "time"?=20=20
>>
>> Or "i" and "to" for "interval" and "timeout"?
>>
>> Lots of options for bikeshedding here...
>=20
> I have no strong opinions here.  I thought pi (ping interval), but
> considered to close to 3.1415.... ps wasn't goo either, but that's meant
> to be "ping seconds" (poor interval alternative, I agree).  I thought of
> pt and pti as well, but thought that could be somewhat confusing with pto.
>=20
> pto is as you decoded, Ping Time-Out.  I chose 'pto' as just 'to' could
> be confusing in the text below ("... timeout is the to argument...").
>=20
> I also though of 'pin', but that could also be confusing.  Even
> considered a proper word, but then the man page needs to be rendered in
> a way that these keywords are emphasized (like bold/white). Maybe change
> ps to int - as in interval]?  Or pis (ping interval seconds).
>=20
> The reasoning for changing n and m to something else was in a hope to it
> easier to grasp what each of these arguments really meant - and easier
> see them in a bigger context.
>=20
> But I'm very open for other suggestions; I don't care about the bikeshed
> colour as long as it is at least a slight improvement of what we have tod=
ay.

"Thou shell never waste an opportunity to bikeshed."

So, we don't have a shortage of characters here, right?  Why not simply
'interval' and 'timeout'?

-Steffan



--2f0sd21Ef2tutNpv2KWgepRJLagiaaFev--

--vivliv1lhuv7GBxLc7lOpfmVSldWGTfk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYGIpgAAoJEEEwndWOY1w5DPMH/RjCmKpm5EbIktt00wgafCqK
TWdPzvxHcckU1XwA5E3k4bXlhnX8fJaDxaN4beWcVG+ZZsl8uN7iFsUSgZYEadxl
GPOileBTMZlCswpo8xDgctI+pEIdejHjN+h1ki1KJ/M5HGFpF5B/+wy96sN7m63a
Th19EWRFdvNxey/DK4aiVsBXKLl/kMWzqMUFNsy9nIf3HVAMJHszONDWftN1WL1Q
BLJwf0EjvdYKaDECFrMxnqlk1qdadkvBVCRLX2IDO8buh1oNE3ff0nswAVtH4ZN9
cLKBWrTG6c2sT1dxubbu4vnQAiq2wIk2JelbyYMRklnbTWsM7yBkBjRZD4YMlgI=
=xbbG
-----END PGP SIGNATURE-----

--vivliv1lhuv7GBxLc7lOpfmVSldWGTfk2--

