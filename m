References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<CAFHpkQEQq8sbEfMDXwMBNUi4-qt81drpQETKTWmHKAxfwpmdyw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <caae589a-7710-2d22-0add-95d450e96a79@...515...>
Date: Wed, 29 Jun 2016 13:14:21 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEQq8sbEfMDXwMBNUi4-qt81drpQETKTWmHKAxfwpmdyw@...278...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This seems like a reasonable approach. We already provide static links=20
to "latest" releases:

<http://build.openvpn.net/downloads/releases/latest/>

Right now all of the links point to OpenVPN 2.3.x, but there is already=20
support for "latest testing version" and "latest stable version", so the=20
2.3/2.4 split is easy to do. Once 2.4 goes "stable" we could either drop=20
2.3 support _or_ add another variant such as "oldstable".

Samuli

> my colleguae suggested that
>
> 1) installer should detect "running on windows xp"
> 2) installer should suggest to install previous version of openvpn and
> provide a link to it.
> 3) after that installer should refuse to install
>
> looks good
>
> 2016-06-29 14:00 GMT+05:00 Gert Doering <gert@...1296...
> <mailto:gert@...1296...>>:
>
>     Hi,
>
>     On Wed, Jun 29, 2016 at 01:57:14PM +0500, ???????? ?????????????? wro=
te:
>     > ok, if so, we need to modify installer to detect that.
>
>     Right, "master" installers should refuse cooperation on XP.
>
>     Samuli, you're listening? ;-)
>
>     gert
>
>     --
>     USENET is *not* the non-clickable part of WWW!
>
>      //www.muc.de/~gert/ <http://www.muc.de/~gert/>
>     Gert Doering - Munich, Germany
>      gert@...1296... <mailto:gert@...1296...>
>     fax: +49-89-35655025
>     gert@...1297...
>     <mailto:gert@...1297...>
>
>
>
>
> -------------------------------------------------------------------------=
-----
> Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
> Francisco, CA to explore cutting-edge tech and listen to tech luminaries
> present their vision of the future. This family event has something for
> everyone, including kids. Get more information and register today.
> http://sdm.link/attshape
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

