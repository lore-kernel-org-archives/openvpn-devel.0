Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170803160304.35518-1-debbie10t@...277...>
 <df6d3edb-3f2d-6a83-68f0-0899f58bf785@...2080...>
 <db3fbd7b-3fac-6bc2-b99f-9188fe553cfc@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <35baffeb-acf1-3a43-0b6e-bd6c8a2e7253@...2080...>
Date: Thu, 3 Aug 2017 22:49:49 +0200
MIME-Version: 1.0
In-Reply-To: <db3fbd7b-3fac-6bc2-b99f-9188fe553cfc@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rTAKMw7xbtLXWx0rVU0DLp7Igi3x6TwFN"
Subject: Re: [Openvpn-devel] [PATCH] doc/openvpn.8: Correct
 --verify-x509-name *type* example
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rTAKMw7xbtLXWx0rVU0DLp7Igi3x6TwFN
Content-Type: multipart/mixed; boundary="jFu0xrJiUtPE3HSUDv0LsNHstgghDra1H";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Richard Bonhomme <fragmentux@...277...>
Message-ID: <35baffeb-acf1-3a43-0b6e-bd6c8a2e7253@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] doc/openvpn.8: Correct --verify-x509-name
 *type* example
References: <20170803160304.35518-1-debbie10t@...277...>
 <df6d3edb-3f2d-6a83-68f0-0899f58bf785@...2080...>
 <db3fbd7b-3fac-6bc2-b99f-9188fe553cfc@...277...>
In-Reply-To: <db3fbd7b-3fac-6bc2-b99f-9188fe553cfc@...277...>

--jFu0xrJiUtPE3HSUDv0LsNHstgghDra1H
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/08/17 19:07, debbie10t wrote:
>=20
>=20
> On 03/08/17 17:46, David Sommerseth wrote:
>> On 03/08/17 18:03, debbie10t@...277... wrote:
>>> From: Richard Bonhomme <fragmentux@...277...>
>>>
>>> Signed-off-by: Richard Bonhomme <fragmentux@...277...>
>>> ---
>>>   doc/openvpn.8 | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>>> index 20bdd91..fdd5dde 100644
>>> --- a/doc/openvpn.8
>>> +++ b/doc/openvpn.8
>>> @@ -5340,7 +5340,7 @@ subject DN "C=3DKG, ST=3DNA, L=3DBishkek,
>>> CN=3DServer-1" would be matched by:
>>>   and
>>>   .B \-\-verify\-x509\-name Server\-1 name
>>>   or you could use
>>> -.B \-\-verify\-x509\-name Server -name-prefix
>>> +.B \-\-verify\-x509\-name Server\- name\-prefix
>>>   if you want a client to only accept connections to "Server-1",
>>> "Server-2", etc.
>>
>> Just wondering ... Shouldn't the "Server-1" and "Server-2" be escaped
>> too?
>>
>>
>=20
> Yes of course but I only wanted to correct the example at this time
> and, as this is my first submission, I just wanted to get that right.
> I will start a project to format the man page more thoroughly in time.

Ahh, right.  Well, I think we can fix at least the surrounding escape
issues at the same time too.  I do like small commits, but we can afford
a bit bigger change sets on the man page on the surrounding issues.  We
seldom need to bisect man page issues ;-)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--jFu0xrJiUtPE3HSUDv0LsNHstgghDra1H--

--rTAKMw7xbtLXWx0rVU0DLp7Igi3x6TwFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZg4xuAAoJEIbPlEyWcf3yEtsQAIu3SxFdCG6soS91N6BWN36o
T9EB3KoMZei0bSADZtfkiH6Gug39rEdjf2EcYzZw0YwhkF3yqkoPGTIYA72fWeUb
ZuN7tExCLD1VkYJH/Ll6cmcQORFMaGcAZqbVjXFI69v2LcsVJW7Jk3BM5wgfATda
OU8bi0rhUC32Iq+uaKWLe70YbbU+H6qN+iVT0GPUi5JhbVN5itDJHqJ0OA498iEh
zJZJ6E7VIEv7l0w2fqc8j4C0waCdYwrZOEQvm2i+lBSZYVFwaF7nxT6IoBHWiOSh
XFyaLpePoMHrsMgyLh2iLk2R3e94ffpRA6BCvmytL+tbVBFW38CThoOL6zCynTCR
T+xGTmQzfLZv6vbIq7akVO/gs/KFVY0rUPBkGCVO4iEmIwXK6lTN4q6AMZM6dRxD
iP7inoHbBVZTcFL+1/51sMeamEK0D7Jqul/N8RniOyGRc9TTihi+fidD2MAjo36r
qhhFhyg2l6qKqPdlz6l4saxk87ZMuCeMBBaPUVKp+ChdWYTZTyXYfN8e8RHCivWg
GonZcXCrDxKbgMdS107/VEt4hqSB64Qf6HcQByxyOve8sBjDtwudR2KymuaRLeGY
nN9AoofwvvozZBBsOBbyrA4sWhrvcrwCpZLyGx3ekXZ0SRvBp3x0fE9gRV73caG2
aabcmWvy0AfAjvMCN/ru
=LcyP
-----END PGP SIGNATURE-----

--rTAKMw7xbtLXWx0rVU0DLp7Igi3x6TwFN--

