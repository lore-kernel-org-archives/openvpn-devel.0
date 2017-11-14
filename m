References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d21db9fb-ca8f-8a76-80bc-c7362d0c8135@...2181...>
Date: Tue, 14 Nov 2017 16:35:12 +0800
MIME-Version: 1.0
In-Reply-To: <20171114083134.GV958@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jdjsNL2aVdsBwMNDOuxhqPXebbMV17msj"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jdjsNL2aVdsBwMNDOuxhqPXebbMV17msj
Content-Type: multipart/mixed; boundary="38tJlqKTfbXk7R9veg7SoqgHTAV2fDOql";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d21db9fb-ca8f-8a76-80bc-c7362d0c8135@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...>
In-Reply-To: <20171114083134.GV958@...1296...>

--38tJlqKTfbXk7R9veg7SoqgHTAV2fDOql
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/11/17 16:31, Gert Doering wrote:
> Hi,
>=20
> On Mon, Nov 13, 2017 at 01:16:46PM +0100, David Sommerseth wrote:
>> But we should consider if we want to make use of a JSON library
>> producing the JSON streams.  The reason is to ensure the output is
>> according to the specification and that escaping if contents is
>> consistent and proper.  Imagine if someone puts a double-quote into the
>> CN field of a certificate?
>>
>>  CN=3D"} Lets explode things, O=3DHacktivist0
>>
>> Or other characters which needs escaping.
>=20
> I'm not convinced we want to import a new library dependency and a heap
> of #ifdef for this.
>=20
> Escaping on *output* is pretty trivial ("characters from <this set>=20
> need to be encoded <like this>") - and as long as we do not need to parse=
=20
> *incoming* JSON, a full-blown new library is mainly adding complications
> (like, configure flags, #ifdefs, library version dependencies, ...).
>=20
> But you knew that this response would be coming :-)

+1

if we want to do output only, we should not need another library.
Especially if we are not going to do complex stuff.


Cheers,


--=20
Antonio Quartulli


--38tJlqKTfbXk7R9veg7SoqgHTAV2fDOql--

--jdjsNL2aVdsBwMNDOuxhqPXebbMV17msj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloKqsQACgkQB6U8WA7y
zXQr8hAAkHDT7p3ciknG5uzsRSr/LclIV8WJDHtxhxGSsmw0yfIq8ONhda3fBXjY
D5tQvg7/8dye7Mho43hNy4pocAtuvOAJ6QlMNf9j90zZXG0eTBvVU+AL22UfULyW
OK0KJlpbo2NmYRz0uLIQcdaPjL5jsjbSCBxufbGMXhTPRIVEoMwjpm3eVZrkCana
Ca0kOvht9NmCu0uM4N1VH9T7nBh2Ayv9yM4CqAOf3MMeRlXdVwdEGr7iLKqQ8u46
VptNwb0jghZLERMNCU85YpYkKkyW7f65KHAiiTgxfZ2Bkqpi0qJjCgnZypDEfPhC
EaVkFEie5yymDaCSws9CDncQm5ytxE7dc5tL4juMNzm7SGkrz0lobqRPzQWrXNOD
e3ce6jvQRiuThfXxNoDSZ+Igv8riNBO6GY7elPl5FFrw+6V7rynAwJBPshMLJt0r
h1s3qikbjaR7r1O4eWlFY5ibzhD8N0tfnWayWDPSwR+NIFoXKl/0NR0SGYZryHm+
GqCLL+aZP5CertMIz9Cfjc5Ggq2GAUuq6hJBeTbakVr66R0UQenHnnDAfL0QgN88
L6IdbJ4eS7vnPrkmckCJ0I8kUyRSnNet+spt70Lbrqg1xwWthEa4ZUOaWLnKUsFT
Hnio+V1/g6aj7uZj8zqROfHypGaYfmhaFzZrKws2ed7uWS+laq0=
=L33i
-----END PGP SIGNATURE-----

--jdjsNL2aVdsBwMNDOuxhqPXebbMV17msj--

