References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <1505501175-9016-1-git-send-email-selva.nair@...277...>
 <CAKuzo_iN6kzukk7ZETjwb6A8pXTkAgXUuQs3E1cf_enYbh-uCA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5cd04f5c-fb34-5586-f60d-ea65c8dea445@...2181...>
Date: Fri, 22 Sep 2017 00:58:31 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iN6kzukk7ZETjwb6A8pXTkAgXUuQs3E1cf_enYbh-uCA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nsohts6mXJxHIm8oMQoo8RqUMcIadJvBI"
Subject: Re: [Openvpn-devel] [PATCH v2] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nsohts6mXJxHIm8oMQoo8RqUMcIadJvBI
Content-Type: multipart/mixed; boundary="KGRlGo1qHkCjuRmcJsiu9U9GWuAxgPiIw";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>
Message-ID: <5cd04f5c-fb34-5586-f60d-ea65c8dea445@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Check whether in pull_mode before
 warning about previous connection blocks
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <1505501175-9016-1-git-send-email-selva.nair@...277...>
 <CAKuzo_iN6kzukk7ZETjwb6A8pXTkAgXUuQs3E1cf_enYbh-uCA@...278...>
In-Reply-To: <CAKuzo_iN6kzukk7ZETjwb6A8pXTkAgXUuQs3E1cf_enYbh-uCA@...278...>

--KGRlGo1qHkCjuRmcJsiu9U9GWuAxgPiIw
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 20/09/17 23:34, Selva wrote:
> Hi,
>=20
> On Fri, Sep 15, 2017 at 2:46 PM, <selva.nair@...277...> wrote:
>=20
>> From: Selva Nair <selva.nair@...277...>
>>
>> In particular, this eliminates the message that says "explicit-exit-noti=
fy
>> is ignored by previous <connection> blocks" when the option is pushed.
>>
>> Note: pull_mode is identified as "allowed & OPT_P_PULL_MODE" matching wi=
th
>> the
>> definition in add_options().
>>
>> Reported by: Eike Lohmann e.lohmann@...1294...
>> https://www.mail-archive.com/openvpn-users@...1199...
>> sourceforge.net/msg04052.html
>>
>> v2: move the check to verify_permissions() as suggested by
>> Gert <gert@...1296...>
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>> ---
>>  src/openvpn/options.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>=20
>=20
> Does this look good now?

pull_mode is already computed in add_options() and could just be passed
to verify_permission(). However, adding another parameter to the
function call is probably not worth the gain.

Personally, I think this patch looks good now.


Cheers,

--=20
Antonio Quartulli


--KGRlGo1qHkCjuRmcJsiu9U9GWuAxgPiIw--

--Nsohts6mXJxHIm8oMQoo8RqUMcIadJvBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnD77oACgkQB6U8WA7y
zXQl/g//Z+b+ya5b+9JMRORNqH+nvNOC5+mxuprXfRN3CEIlxXjK6IY6aJP5SUhQ
9MFuwqfMaKnhStgcG9Spav4CkqpB5WFF4YM83LeGRwBmLa0lL1ACnuGO+k/VOh/s
kHpWPemsjplSsAfhR9XrB4MEICcs2P7uVboCQBHyZCquLfzyH6mbUxOIamTsnlGA
45JYuU9GvDXs58/y04hE30HM9Gu3X8AuAM5AmXRTu3Dl+U6hHs8pWi3w833xgIpc
L+7WPrx7zLI3PZ9TPD8XHHzUM/r8cza1fedVBVt4r5rftyCDwRv/DO9HyP+bnz5w
2BJrKMAq1pBncFb58dGrv27LFGNRuqwfdTS4bay9/ZAdnRnd0pijA1rWNT1MmWCI
EfNXrduLlzEZoB9lkqe9WUvFFTM8lsOoSTzsIGnNn/l/C6FAWWJQuZGcQ/0/xNtm
PIJtj/qspqHiLsgsE4PBg/8RHxIMr2TcJ0wJO+yD5b4W0P7J6z/1fAxdN3gH2s/M
uQBqETQWL6xEsln6buq8TZwNbFOj0uH2zbjb18JSoPyzUP/nF5DKY5vscDF147IP
1aT86Vjvdzudt5rQKKwgJ62Vs4Plh6UJ3z94GswtL2tJFT5A1hdUKxQdChyl/zsU
Mk294/JPlEbQvUdZWYof5GT3wAGCnYuSbQ1HefTMzE4hc85v1ek=
=ZdvT
-----END PGP SIGNATURE-----

--Nsohts6mXJxHIm8oMQoo8RqUMcIadJvBI--

