References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<20170505182851.GJ97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <81644640-b057-f177-e7ba-eb3957370109@...2080...>
Date: Fri, 5 May 2017 21:01:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170505182851.GJ97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DtvMUowNllDulMu1spcVA0VHxSMANCwLa"
Subject: Re: [Openvpn-devel] [PATCH 1/2] In auth-pam plugin clear the
 password after use
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DtvMUowNllDulMu1spcVA0VHxSMANCwLa
Content-Type: multipart/mixed; boundary="2V6In4AOein6Hg3D8RdCO4eAwVbTVOJlj";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <81644640-b057-f177-e7ba-eb3957370109@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] In auth-pam plugin clear the password
	after use
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<20170505182851.GJ97029@...1296...>
In-Reply-To: <20170505182851.GJ97029@...1296...>

--2V6In4AOein6Hg3D8RdCO4eAwVbTVOJlj
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/05/17 20:28, Gert Doering wrote:
> Hi,
>=20
> On Fri, May 05, 2017 at 02:24:01PM -0400, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> This adds a minimal secure_memzero()
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>=20
> Feature-ACK, Code-NAK, but just because David is planning to export
> secure_memzero() to plugins from OpenVPN proper - mentioned just today
> on IRC
>=20
> 17:09 <@dazo> syzzer: just thinking aloud (remembered our discussion on w=
iping=20
>               passwords securely in plug-ins) ... what do you think about=
=20
>               exposing secure_memzero() to plug-ins, similar to what we d=
o with=20
>               plugin_{log,vlog}()?
> 17:09 <@dazo> to avoid each plug-in needing to re-implement this
> 17:09 <@syzzer> yeah, sounds useful
> 17:10 <@dazo> I'll send a patch doing that too (should be quick to solve)
>=20
>=20
> So I'd postpone this until David's patch plus instructions for plugin
> authors show up.
>=20
> Good timing :-)

Indeed :)

So the patch exporting secure_memzero() is on the way to the mailing
list now.

To use this, you need to switch the openvpn_plugin_open_v1() to
openvpn_plugin_open_v3().  The API on this function is quite different,
but you shouldn't need to tweak too much.  All the pointers are
available in the new struct pointers the _v3 function uses.

Then you basically can declare a global variable like this:

  plugin_secure_memzero_t ovpn_secure_memzero =3D NULL;

And in the the openvpn_plugin_open_v3() function, you should add an API
check:

    if (v3structver < 4)
    {
         /* printf() some noise to the log */
         return OPENVPN_PLUGIN_FUNC_ERROR;
    }

This ensures that the OpenVPN version is new enough to export the
secure_memzero() function.

Then you just assign the ovpn_secure_memzero pointer:

     /* Hook into exported plug-in functions */
     ovpn_secure_memzero =3D args->callbacks->plugin_secure_memzero;
--2V6In4AOein6Hg3D8RdCO4eAwVbTVOJlj--

--DtvMUowNllDulMu1spcVA0VHxSMANCwLa--
