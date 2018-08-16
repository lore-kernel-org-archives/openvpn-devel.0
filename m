Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
 <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
 <20180816113743.GV74536@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1ae7f2ea-acf6-39ed-db8a-bc4c7d8c943b@...2080...>
Date: Thu, 16 Aug 2018 22:28:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180816113743.GV74536@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="szMCVcTDy6C6rnilPyGnlpQeZEJlGtL9U"
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--szMCVcTDy6C6rnilPyGnlpQeZEJlGtL9U
Content-Type: multipart/mixed; boundary="hnoH3h3XyhhkZSPm7Urh3bE5o2Qi9msjh";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <1ae7f2ea-acf6-39ed-db8a-bc4c7d8c943b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
 <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
 <20180816113743.GV74536@...1296...>
In-Reply-To: <20180816113743.GV74536@...1296...>

--hnoH3h3XyhhkZSPm7Urh3bE5o2Qi9msjh
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/08/18 13:37, Gert Doering wrote:
[...snip...]

I do see the arguments on both sides here.  And in particular where these
warnings halts the compilation (which I think I read some where that newer =
GCC
compilers would do by default).  But ... Gert asks a few reasonable questio=
ns

> Anyway.  Trying to understand the logic here - PLUGIN_DEF_AUTH is always
> defined if ENABLE_DEF_AUTH is set, which seems to be the default setting.
>=20
> So, questions
>=20=20
>  - is there actually some benefit in --disable-def-auth?  code size,=20
>    performance, platform compatibility?
>
>  - why do we have it in the first place?

I tend to say no.  ENABLE_DEF_AUTH is about deferred authentication.  This =
has
been enabled by default for so long, that I hardly think it would be an iss=
ue
killing the possibility to turn off this feature.  All it essentially does =
is
to allow plug-ins to return OPENVPN_PLUGIN_FUNC_DEFERRED instead of
OPENVPN_PLUGIN_FUNC_ERROR or OPENVPN_PLUGIN_FUNC_SUCCESS.

This feature will also improve the authentication performance by not locking
up other connected clients if the authentication backend is slow *and*
implements support for deferred authentication.  So there is a performance
gain for authentication plugins making use of this feature.  Otherwise, I do
not expect much performance difference.

>  - can we get rid of it?

I am definitely leaning towards "Yes!".  This does grow the resulting binary
by some bytes (I don't know how much; haven't checked), as it adds code whi=
ch
prepares a file the plug-in will use to write the final verdict of the
authentication; plus the code paths related to polling this file the core
OpenVPN process.  If the  If the code grows enough to validate the need for
this macro, I am not so sure of.

The only users I would expect might do builds with --disable-def-auth are t=
he
builds for embedded devices.  But I don't know how much of a concern this is
any more; this feature shouldn't double or half the size of the resulting c=
ode.


There is also a related ./configure option: --enable-async-push.  This adds
inotify support, which reworks the polling model to be a notification based
push model instead (iirc).  But this I think makes sense to have as it is
today for the time being.  We might want to consider flipping it to be enab=
led
by default, though.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--hnoH3h3XyhhkZSPm7Urh3bE5o2Qi9msjh--

--szMCVcTDy6C6rnilPyGnlpQeZEJlGtL9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbdd5bAAoJEIbPlEyWcf3ySsEQAIbQWe2adz4k6Vqgele7zKSR
3x64f7rEcVhF3sSdKqbVzXrXP0Zz/8v8vyn8IayTGxXzsNukKwtZMpZy/AMOUyO6
okKFI397uFYaRozjcjiepDfZ8baYsndy4fcE6eyJitVFlKmc4sVoiu0EQ1ad5+9/
qBohnQg8oqNfQdCMWF4h/ofvcr555QCdLrscBLwwoPz25Tm6qre2uN3tWLcGE6gt
eQd2Qhr8B4B9I2AdfuXgULz5LiFwkGKMBYFANcXkkDSkCQvvvzG75PoZPe49WGhE
9pAs/GV3cKprt2VSCyfpVAOLyXIcTRjbKUSJ6xX4Gucr3MVN3Ho1etvQM4FUZu/U
GrcAbnYOpya2vn8MnnUvOkFcRR7OOBeWpIib3/8MQFu+n78QK42HzSoDH3C8XzvD
iEKJMaWsYOWB7NK1yv2tcZv+r7Rs85cN2TDbM9mpbQBlaGeYymXlw4xiN0EB3Y6Q
mzbIYw/ej3UHGT6Xiqc1mhFCgtgKt36q+vvkvAhKVN04nL0lI2OULhr5d8KdTNMp
wWj/mPHLnQ2abMO5pP5klkb5jRskfveOO0CKQGYuWPRb9h7Fv3hGNobcCt9TS9S9
CvnFmhxkZDpuXL0D7LxF1Kboh62dLsuqyC9evmP+r6RsWqYolDDoy3WU1RtlI2FM
IwSVaki+58GL6hjqZZCC
=o1Bb
-----END PGP SIGNATURE-----

--szMCVcTDy6C6rnilPyGnlpQeZEJlGtL9U--

