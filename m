Message-ID: <4CDD77B9.8050606@...1114...>
Date: Fri, 12 Nov 2010 18:22:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...> <4CDD7559.5000604@...515...>
In-Reply-To: <4CDD7559.5000604@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool dependency
 from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/10 18:11, Samuli Sepp=E4nen wrote:
>=20
>> On 12/11/10 17:55, Peter Stuge wrote:
>>> David Sommerseth wrote:
>>>>>> Modified win/build_all.py so that build does not fail even if
>>>>>> the optional signtool python class is not available.
>>>>> What is it needed for? Is it really *always* optional?
>>>> If I've understood it correctly, this is related to signing the Windows
>>>> TUN/TAP driver.
>>> Right.
>>
>>
>>>> So if you don't have a signing key/tool available, it is still
>>>> possible to build the rest of OpenVPN.
>>> Fine, but this is not really acceptable when James&co builds OpenVPN,
>>> so I am requesting a solution that allows them to specify to the
>>> build process that they want a fatal error if signing is not
>>> possible.
>>
>> That's a good point!  I didn't think about this one.
>>
>> What about that the build script stops up and asks if it should continue
>> without signing?  And in addition having a command line argument
>> accepting building without signing?  This latter one is more useful for
>> automated community builds of the allmerged branch from
>> openvpn-testing.git.
>>
>>
>> kind regards,
>>
>> David Sommerseth
> What if build_all.py did this:
>=20
> - Check if SIGNTOOL is enabled in settings.in:
>   - Yes: fail if can't import "sign" module
>   - No: don't fail if can't import "sign" module
>=20
> I think existence of the SIGNTOOL variable gives a good clue of user's
> intentions. Note that the build will also fail if SIGNTOOL is defined
> and signtool.exe is not copied to the correct place
> (../signtool/signtool.exe).
>=20

That's fine ... but what Peter raises as a concern, which I do agree to,
is that if James' build system is changed and the driver is not signed,
earlier this would cause to a halt in the building process.  With your
patch, OpenVPN + the driver will be built and not signed.

So it's just to catch that "yes, we want to do a build without signing
the driver" and to really sign-off that explicitly when doing the build.
 As James' should never do a release build without signing the driver.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzdd7gACgkQDC186MBRfrpmGwCfXbMtUuoDmuWXTn5wOeAYy9s9
+BAAoKqWatGOoLIonfuV30UrRCczrKQn
=3DbSuy
-----END PGP SIGNATURE-----

