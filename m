References: <1539016554-23503-1-git-send-email-lstipakov@...277...>
 <20181008173150.GR962@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <87114b11-9f50-338f-ba6b-521f4f13ce73@...2181...>
Date: Tue, 9 Oct 2018 01:42:13 +0800
MIME-Version: 1.0
In-Reply-To: <20181008173150.GR962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YpruAllSAFwgvy0kKj4t0XZcUSyaOgGzj"
Subject: Re: [Openvpn-devel] [PATCH] interactive.c: fix usage of potentially
 uninitialized variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YpruAllSAFwgvy0kKj4t0XZcUSyaOgGzj
Content-Type: multipart/mixed; boundary="cDtaTJujpjvkYP973MxMi5GNYAKRczwaM";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <87114b11-9f50-338f-ba6b-521f4f13ce73@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] interactive.c: fix usage of potentially
 uninitialized variable
References: <1539016554-23503-1-git-send-email-lstipakov@...277...>
 <20181008173150.GR962@...1296...>
In-Reply-To: <20181008173150.GR962@...1296...>

--cDtaTJujpjvkYP973MxMi5GNYAKRczwaM
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/10/18 01:31, Gert Doering wrote:
> Hi,
>=20
> On Mon, Oct 08, 2018 at 07:35:54PM +0300, Lev Stipakov wrote:
>>  out:
>> -    free(cmdline);
>> +    if (cmdline)
>> +    {
>> +        free(cmdline);
>> +    }
>=20
> Do we have something in our styleguides related to these constructs?
>=20
> Since free(NULL) is well-defined and valid(!), the if() check is not
> needed at all and just adding extra lines on screen.
>=20
> I'm sure we had this discussion before, but couldn't find something
> where we wrote down how and why we do things.  We do have parts of=20
> the code that *does* "if(ptr) { free(ptr); }" checks, and others that
> don't...  for example, AsyncPipeOp() on failure to malloc() "handles".
>=20

I don't think we have any guideline, but I agree we should just remove
the surrounding check, because, as you said, it is well defined behaviour.

Maybe somebody could make this consistent across the codebase.


Regards,

--=20
Antonio Quartulli


--cDtaTJujpjvkYP973MxMi5GNYAKRczwaM--

--YpruAllSAFwgvy0kKj4t0XZcUSyaOgGzj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu7lvUACgkQ9FVsWUWD
Dm1AFg/9EWFYTEfA+ThtBQPPOiB1wz6ZBgyXh1VxLbpbn2TgNuPI6jf0XsK2Vwba
B6MbjNNBOO5VRKIzSXrS86wlWfUoon+xih/Snf27NGU/nxCDBolreNr0gJmXACe8
SCxsGwmR3xfAh/ZbB1oEHaMb58V+seglP43yxK0fhnQGBKjsmX49hsbMZuoYRqTP
0xet06uy5rkQw/KJYAPSPkhRVT64q8VU4taNY12Td9GpUB6MYguWoIc4TeQy2FJW
IX3y9rRV9cqYocYXZC/KblDxYAiKqj1juLe+ozPL9jbP4a4bG30ItfYJFbaD0yan
/b3cqKPdkazgHXmO7rSvIWIE2lLv/gYGRoY5i9oL/Apt/2jDDZrrzhuPclj0vHSa
r3HPNTDSbadKODj1XJurVQo6N51qUEHcHESfP9wBlWY49yvcUnmGVy9+Szew0e4O
7sT/XXW/Hl15WtxflPjHV+xnMDcVcwxBP2TcwIlE+NaX3G0mX1qeo883OBXjYW/b
jHktyoFII+DG749A69UQwWspjRTVhAlqG7tgkaRkRGJadXLWFflpSIDchtdz6dyi
uHjEEi4JUh5tjKRIA7TfU+XzrbV5bDt60hZ46iMSzQYdh3A/kTHvmNrks5ezjigp
4V8HkNxRZYzkyudGXjtL+wVty9j/Rw5eNJgYvo9X1D1S/OnWhcY=
=1xXC
-----END PGP SIGNATURE-----

--YpruAllSAFwgvy0kKj4t0XZcUSyaOgGzj--

