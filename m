References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
	<0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
	<a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
	<20170323031127.GB24725@...2182...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <59bf8d07-476f-bdb7-611d-154bdc4a1bbf@...515...>
Date: Thu, 23 Mar 2017 09:52:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170323031127.GB24725@...2182...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VsubCwcpiNvNrSUVNQ8xWbx2xcmmxXJC9"
Subject: Re: [Openvpn-devel] Consider git tags for I60x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VsubCwcpiNvNrSUVNQ8xWbx2xcmmxXJC9
Content-Type: multipart/mixed; boundary="------------9403268F4276A0AFA6EF3E8C"

This is a multi-part message in MIME format.
--------------9403268F4276A0AFA6EF3E8C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/03/2017 05:11, Antonio Quartulli wrote:
> On Wed, Mar 22, 2017 at 02:11:56PM +0100, David Sommerseth wrote:
>> On 22/03/17 10:07, Samuli Sepp=E4nen wrote:
>>> On 20/03/2017 17:13, debbie10t wrote:
>>>> Hi
>>>>
>>>> just so this does not get forgotten about:
>>>>
>>>>   @dazo | slypknot: https://github.com/OpenVPN/openvpn-build
>>>>   @dazo | I see that there are no tags with the I60x indicator ...
>>>>           that could probably be something mattock should consider to =
add
>>>> @cron2 | true
>>>>
>>>> Regards
>>>>
>>>
>>> For openvpn-build I have not added release tags, as the commit message
>>> usually contains the necessary information. For example:
>>>
>>> ---
>>>
>>> commit 23d42200f282d2fcdc57bd4262d1fffc0832c7ff
>>> Author: Samuli Sepp=E4nen <samuli@...515...>
>>> Date:   Tue Dec 27 12:31:39 2016 +0000
>>>
>>>     Update build parameters to match openvpn-install-2.4.0
>>>
>>>     Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
>>>
>>> ---
>>>
>>> Adding a tag per installer release is not a big deal, though, if we have
>>> a use-case for it.
>>
>> Currently we do not have anything providing a guaranteed match between
>> openvpn-install-2.x.y-I60z and a particular git commit.  This helps
>> understanding what a release really contains, especially if you have
>> more commits in a release.  Then you just do:
>>
>>    $ git shortlog v2.4.0-I601..v2.4.0-I602
>=20
> I like this too - makes it really easy to revise what was changed between=
 two
> releases/tarballs. It's basically one little step more to perform when cr=
eating
> the tarball.

The git shortlog command will show us how openvpn-build's parameters in
"generic/build.vars" and "windows-nsis/build-complete.vars" have
changed. That is generally enough to know what openvpn-build has
downloaded and from where.

One shortcoming is the tarball version numbering scheme in openvpn-gui:

  openvpn-gui-11.tar.gz

So just the major number, not the full version number (e.g. 11.5.0.0).
It would be good to have the full version in the tarball name, so that
all the components combined by openvpn-build would be identifiable
exactly from git diff. Another concrete benefit would be that old minor
version tarballs would remain available on the download servers; right
now they get overwritten on every openvpn-gui release.

>>
>> Another aspect is when you do signed commits (git tag -s), then the tag
>> is "cryptographically bound" to a particular git commit.  That is
>> incredibly hard to manipulate.  If the branch itself is modified the
>> committish will change, thus there will be a mismatch between the branch
>> committis and the commit the tag points at.  In fact, if you do a git
>> checkout using the tag name, you will most likely get the correct commit
>> checked out and not the manipulated one.
>>
>=20
> +1 on signing the tags - this increases the confidence in the code somebo=
dy is
> downloading. Manipulations are found immediately (unless done voluntarily=
 by
> the committer).

With the current build setup I can easily do signed tags for openvpn-gui.

Openvpn-build would require some additional work, as the build computer
is a shared EC2 VM which other OpenVPN Tech people can access. I don't
want to have my private GPG key lying around on such a VM. That said,
nobody else is using the EC2 VM, so I can fairly easily switch to using
something in my own intranet.

>=20
> All in all, I think it would be worth adding these small steps, as git ma=
kes
> them really easy to be performed.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------9403268F4276A0AFA6EF3E8C
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------9403268F4276A0AFA6EF3E8C--

--VsubCwcpiNvNrSUVNQ8xWbx2xcmmxXJC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY0367AAoJEClYTZ9AhkV4RBoH/ii2aTSTI+L+6kd322d+JxGe
oEwfCjdux2m+FJY7Fnnt4lhwsbZyxsfWKqBgsoCZv+9tL9iWn8rv1tUPU3oFb2j5
PFHwFg6dcy1HqsnjpRafe+8RfmZFJGKmXLlKs4TE3K9AlMPQOd+zHOIKu9QvNO3u
eMrNoigPAgz3FY/TawzNtk/JMxcPHxSPhL5gpN469h62INkLCEnOBcQVd9R6UJQF
VK617fV9/DRkduxVf7D+k0NOEGBpUHflfH4bkwj3R6/XsZXPfZDzRVq8muu/BAUU
QpZyQJq4AgGTmhGbXj9QaqdLTuA8UPAhFMIcZ6PlPe3I1OVtnl9z++33sMm7qw8=
=9Jwi
-----END PGP SIGNATURE-----

--VsubCwcpiNvNrSUVNQ8xWbx2xcmmxXJC9--

