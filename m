References: <20170125205302.23069-1-davids@...515...>
	<20170220130341.GB93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d2dc71de-47f6-45f6-96b7-103d39725ea9@...2080...>
Date: Mon, 20 Feb 2017 14:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170220130341.GB93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WJ9G8sOe8fQl0XQMArwRxftrGF57wHDFr"
Subject: Re: [Openvpn-devel] [PATCH] dev-tools: Simple tool wihch automates
 rebasing LZ4 compat library
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WJ9G8sOe8fQl0XQMArwRxftrGF57wHDFr
Content-Type: multipart/mixed; boundary="QoJ65RX9rPMGokpr6CoqUE2HUqe9N0fS3";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <d2dc71de-47f6-45f6-96b7-103d39725ea9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] dev-tools: Simple tool wihch automates
	rebasing LZ4 compat library
References: <20170125205302.23069-1-davids@...515...>
	<20170220130341.GB93896@...1296...>
In-Reply-To: <20170220130341.GB93896@...1296...>

--QoJ65RX9rPMGokpr6CoqUE2HUqe9N0fS3
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 20/02/17 14:03, Gert Doering wrote:
> Hi,
>=20
> On Wed, Jan 25, 2017 at 09:53:02PM +0100, David Sommerseth wrote:
>> This tool depends on a cloned upstream LZ4 git repository and a
>> checked out release tag.  Then run the script like this:
>>
>>    $ ./dev-tools/lz4-rebaser.sh /path/to/lz4.git
>>
>> To see the result before committing, use: git diff --cached
>=20
> All willing to give this an ACK, alas, it's penguin-tainted :-) - read,
> won't work with a FreeBSD sed.
>=20
>> +#ifdef NEED_COMPAT_LZ4
>> +EOF
>> +    sed '/"lz4\.h"/s/\(#include "\)lz4\.h\("\+\)/\1compat-lz4.h\2/' "$L=
Z4_C"
>> +cat <<EOF
>=20
> Not sure why this is not working here, but it looks like having too
> much bells and whistles :-9 - I replaced this with
>=20
>        sed 's/\"lz4\.h\"/\"compat-lz4.h"/' "$LZ4_C"
>=20
> and ran it against a local copy of lz4 v131, and that produced the
> expected result - no significant changes to compat-lz4.c/compat-lz4.h
> (the "#ifdef HAVE_CONFIG_H" block moves to the top of the file, but=20
> that is purely cosmetic - the block itself is fine)

I /did/ consider to do some clever sed hacks here too ... but I wasn't
in mood for that complexity, and I actually feared how *BSD would
explode in my face :)  But as it turned out, the BSD explosion trigger
was even lower than that ....... ;-)

> So, any objections against the much simpler sed command there?  "lz4.h"
> with double quotes never shows up elsewhere in the file today - and=20
> when importing, we need to run a compile test anyway, so if it should
> ever garble the .c file, we fix the script...

This is purely my "match a precise as possible" approach I default to.
I have no issues making this simpler if that is what is required.

New patch or fix at commit time?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--QoJ65RX9rPMGokpr6CoqUE2HUqe9N0fS3--

--WJ9G8sOe8fQl0XQMArwRxftrGF57wHDFr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYqut0AAoJEIbPlEyWcf3yX7UQAK9fjA+j5VaU9jzzWhoVtlVb
jdr9KgMCLqMb0In3xWfpxlxYvY1LNw1KaUtdIf4NYg1VmKx4txAi6H+tix2IPCBT
Lb1CHNJurR20k+iMa5nRxyiiQ6dFtNjH664CBBjtbA1wlki8DqzZ0pO2n38M5yn5
A0tJ2okRYd70PaRnIvtCPOt0FPf6I3THQHXwEpwMCtIs1ZcLxVlMaZ1RVXnZj222
7VY0qdTRf7Nkr17pPsz9X0vq9Azdc5PdIy2+2bM9gQ3XTzHWD+efqETrLfNNMojF
EfeWVowak5/5PImQH1SAyMRNwnDz6bBiQReNVOFDUES0143nCheT3WmWMeiPY7VU
9dE36AYPo2PLjzhXIwbzdWpSDMKe3dEK0LvuFxEUNfBX5WyeaB9ZZ0aLVoWLHfhd
cC2Q7hshDubpTyD0Kim6178nV+oTtdIeWAlNZ8R1HA0Ey43TePoESMcl8sJc2Yqn
aXcf2Sy4lQCPysxsjFdl/ZdecCjnUUnIEfKxYm/E2xe+FRCHZxf1RMQSL2KGnOUL
alAMF5F8+du9vk1z4bEshRZxrOthy2uu5Gmo0JtuuzF+5tHy9EoSc1Ho8XM0jzVD
9wlL0WZsCAzW3V63Z09BihVHXQVbRFHgfo7e38CIRqAGryu1WsoL4zx6MN+AUYJI
uNglWRLQSVLNXVHCXayH
=IizT
-----END PGP SIGNATURE-----

--WJ9G8sOe8fQl0XQMArwRxftrGF57wHDFr--

