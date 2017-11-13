Reply-To: openvpn-devel@lists.sourceforge.net
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <02ca5729-0e53-40a2-6c1a-a3fa7ce12743@...2080...>
Date: Mon, 13 Nov 2017 21:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MiDbll7tNHkOmjO8jpR28dswQ5r5n9sn4"
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
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MiDbll7tNHkOmjO8jpR28dswQ5r5n9sn4
Content-Type: multipart/mixed; boundary="qfh2oaWrmhVHJ4nEX54W7MOQpohiTOx51";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <02ca5729-0e53-40a2-6c1a-a3fa7ce12743@...2080...>
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
 <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>
In-Reply-To: <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>

--qfh2oaWrmhVHJ4nEX54W7MOQpohiTOx51
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/11/17 14:44, Fran=E7ois Kooman wrote:
> On 11/13/2017 01:16 PM, David Sommerseth wrote:
[...snip...]
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
> Another very good point. I do have some experience with json-c [1],
> would it be acceptable to add this as a project dependency? That is the
> main reason I started out by just outputting a string and conveniently
> forgot escaping issues...

Yes, I think that should be fine.  I see it is available in RHEL6 (the
oldest Linux distribution we support, json-c-0.11-13.el6), so this
should work out just fine.  So keep in mind to not use a bleeding fresh
version only available in the latest faster-moving Linux distros.

What would be needed though is to enable/disable this via ./configure
(tackled in configure.ac).  We basically can have three approaches here:

 a)  If json-c is found, enable --status 4 by default. If not found,
     this feature is unavailable.

 b)  Require json-c to be installed, which enables --status 4.  To build
     without json-c dependency, --disable-json must be used with
     ./configure

 c) Do not require json-c by default, but if adding --enable-json
    to ./configure then json-c must be present.

I don't have any strong opinion either way, but I believe alternative c)
is the one which will give the least fuzz in the community - thus
overall be more acceptable.


> So for now my plan is:
>=20
> 1. use json-c to generate (human readable) JSON;
> 2. also support --status (command line) in addition to "status" in
> management interface
> 3. do not print "END" marker any longer

Sounds like a good plan!

> This is an excellent way for me to gain some more experience with
> writing C (and OpenVPN), even if in the end the patch is not accepted. I
> do think, like Steffan said, we need a good reason to support JSON,
> especially if it adds an additional external dependency. The
> future-proof-ness of the JSON format could be a good selling point,
> maybe new fields would only be added to the JSON format and not to the
> other status formats to promote adoption of the JSON format and slowly
> phasing out the CSV format(s).

That's a good attitude :)  I for one is not hard to get sold on the JSON
format though, even though I don't have any particular use right now.
But I can easily see this being preferred for others outside the core
project.  And this can simplify some ideas I do have pondered on in my
own infrastructure.

Again the alternative c) approach will fit nicely into this too.  I am
definitely willing to enable a JSON feature in the Fedora builds when
patches hits an upstream release.  And if that works out nice, I'll
consider to add that even in the EPEL builds too - I'll most likely
mention that on the Fedora devel mailing list to get some thoughts on
the EPEL side before enabling it.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--qfh2oaWrmhVHJ4nEX54W7MOQpohiTOx51--

--MiDbll7tNHkOmjO8jpR28dswQ5r5n9sn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaCgNGAAoJEIbPlEyWcf3yBrYP/R/5KZJzS0fqxnct5spNDW7W
hAahnD3rCQ4ZooAgCB0C65Ccc370z1a1pBFpp9i+o3ea1DuVB8A2EcH2+Jk39uz0
j/guCzV4d99M6I7qc+mmL91Akg8XAlL2TqxHHPSZ2SSHvqcdkkks2QceOVve91T+
GoVChME6T/fJzAnZvKdjFNEfU2USBnvlXz+JBTsfd/fZYm2bj0sNHOea698fPdMX
XazcFJBW2clZ41cKRlV3hOUwxVxRRQfR/5IIh6td9npgoTlKVlSPgJlnkpePHz0a
YTytVxblrUlOVJ18PoSP52dwZTQqznZqCAMNQU2laAfwxNet8gwi9O2x+ltt4o8A
JUPBMr1DnoKouc9Itse6hODH5jPdq46HBccwL6L51ak5QtRaGTR9YHmsQijfOJKB
n2aPLvAZKfG4YZ2S0GhgOwf5mE43rpKtgp5gWFc73czpxo6f9DB7VZfQ/Ec+jfJo
XPhlG5H+rGTO1PuxG8VsGksieRMLtYFdkN10TBPBXUotRwvzZSmEoY3hbainvCyl
0NUsZ2bGBHtyl57xVvZmrc1MjWluNzHoRx69lHJvBclDMsAjU36VT2pf8p78Tp16
xFdCT+nV8Xuv4zABLNHxvPBfznga7owF1UEm8SUxnCSc531TeUaATuBukTCqMnja
MLUYcyfn24D3hrm93CIm
=nPlQ
-----END PGP SIGNATURE-----

--MiDbll7tNHkOmjO8jpR28dswQ5r5n9sn4--

