Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
 <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
 <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
 <20170713065907.GZ97029@...1296...>
 <d7604439-f453-bfb7-c9ed-1d627c9ea900@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <99d63076-d474-df90-e5f8-b0d3a2f85797@...2080...>
Date: Wed, 16 Aug 2017 15:58:53 +0200
MIME-Version: 1.0
In-Reply-To: <d7604439-f453-bfb7-c9ed-1d627c9ea900@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iMu8VDuMOAiiLxkbiGCoaH66UWjs98oXq"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>
Cc: ValdikSS <valdikss@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iMu8VDuMOAiiLxkbiGCoaH66UWjs98oXq
Content-Type: multipart/mixed; boundary="I9RQhv8qFt9acnRbSwoKjIAcTp0kOiiQO";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>
Cc: ValdikSS <valdikss@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?=
 <samuli@...515...>, openvpn-devel@lists.sourceforge.net
Message-ID: <99d63076-d474-df90-e5f8-b0d3a2f85797@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
References: <20170713033848.11902-1-a@...2181...>
 <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
 <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
 <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
 <20170713065907.GZ97029@...1296...>
 <d7604439-f453-bfb7-c9ed-1d627c9ea900@...2181...>
In-Reply-To: <d7604439-f453-bfb7-c9ed-1d627c9ea900@...2181...>

--I9RQhv8qFt9acnRbSwoKjIAcTp0kOiiQO
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/08/17 15:05, Antonio Quartulli wrote:
> Hi,
>=20
> On 13/07/17 14:59, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Jul 13, 2017 at 09:16:13AM +0300, Samuli Sepp=E4nen wrote:
>>> There were no bugs reports about --disable-multi in Trac. I say scrap
>>> that option altogether and make the code slightly cleaner and less
>>> entangled.
>>
>> I tend to agree with you here.  There are way too many #ifdef in our
>> code, and while Antonio's patch is technically fine, it adds more #ifdef
>> for a variant that nobody seems to be using - so that's not the way
>> to go.
>=20
> I just went over this again and unfortunately I realized that, even
> though we can get rid of the --disable-multi switch (for which I will
> send a patch in a minute), we can't get rid of the various "#if P2MP"
> because its value depends on ENABLE_CRYPTO, which can still be enabled
> or disabled.
>=20
> Therefore, we have to keep the P2MP define as long we keep the
> ENABLE_CRYPTO logic.

I'm leaning towards removing both ENABLE_CRYPTO and P2MP.  However, we
need to update the buildslave configs too before doing that ...
otherwise quite a few of us will drown in failure reports for a while.

I have also pondered if there is any use cases for keeping them around.
The only one I can imagine now is debugging, to see if something broke
due to crypto or not.  I honestly don't see the benefit of building
OpenVPN in 2017 without crypto support for production environments (but
I may just lack imagination; our users never cease to amaze me).

But in the end, we have way too many #ifdefs around and many of them are
entangled into each other, so for me the vote for code clarity trumps
fine grained debugging in this case.  And this #ifdef entanglement does
not come without a maintenance cost as well.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--I9RQhv8qFt9acnRbSwoKjIAcTp0kOiiQO--

--iMu8VDuMOAiiLxkbiGCoaH66UWjs98oXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZlE+dAAoJEIbPlEyWcf3yJSMQAKfpHwe8x+ccddNUJe2CHvmk
sXP2F1iTuRiUeNwzDdy/VdIaYXQqn8fec5TdFb0Xa7/7cnZTYzQH5gwU6+4LAd8b
hbDTT3BdaG92GLrCEBlX3fwYDP9BtP4S9JEEXQCs3cmym54alhA0h+Acu6LvTD0t
F2UOS1uWitKXsUcT1t22W+YTaj78+MdXavdcUUKPXcGBTBVYggJP3e24hOg39cFm
Zsq0aQu3hMFitKpper8iui7Hb7z2fUP3zuhNNFustH2UMr60nDGWxfY4vMJGTV7l
RSwId8iR6+s2piXfRUaN5p9ayyp1+7Ajvm+c89Ob+VGtTggoUH6ncd+FJgoo7E2p
KZsWPWGsigU6d49I3RjdlIQeRvueGziALeHCYfb+wzpimRERvD8GuzXypcV73XQb
TznbhhSXui/PlgYJPPUhOcjwzw32BPyyShUYZcoS6522tBVd+nyUloAR1pnnStwQ
zPUS8iyfcZSrhlwoFicoHUk1zXmq9Wyc1kucSkGAOVFn5SGpALErum7+zEzFmKBB
F5NyG/EGB0NwNaj6f8SBG8bzNkpeXxXj84XAfbQoRt1LqNMK0MYOBTekY22oSVB/
oKjwXK0S+daawx/Uk2uJLpmS1C+2AvMU2L4a60LOez2o6DrQqyebEneHwo6mP+eg
PEx2WX2EnIgKjKO3qKPt
=/2mp
-----END PGP SIGNATURE-----

--iMu8VDuMOAiiLxkbiGCoaH66UWjs98oXq--

