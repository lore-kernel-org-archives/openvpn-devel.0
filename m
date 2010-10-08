Message-ID: <4CAED593.7040309@...515...>
Date: Fri, 08 Oct 2010 11:25:55 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20101007142817.GU7437@...1152...> <4CADE70D.8070307@...1147...>
	<20101007154740.GL10703@...1296...>
In-Reply-To: <20101007154740.GL10703@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] TAP installation
 Problem	(2.1.3) on Windows 2000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "Katja.Stange@...1152..." <Katja.Stange@...1152...>


> Hi,
>
> On Thu, Oct 07, 2010 at 05:28:13PM +0200, Jan Just Keijser wrote:
>=20=20=20
>>> WHy is that?
>>>=20=20=20=20=20=20=20
>> it's a (minor) mistake in how openvpn 2.1.3 is packaged:
>>=20=20=20=20=20
>
> This is not a mistake (as in "oops, we didn't know"), but was unavoidable=
=20
> since the latest WDK is needed to properly support signed drivers for=20
> Win7, and that version does not support Win2k anymore.
>
> OTOH, there *should* be a Windows 2000 install.exe, but right now=20
> I cannot find it on the download page either - James did build it,
> with the old WDK/DDK, but somewhere in the release process it must=20
> have fallen through the cracks.
>
> Samuli: can you find it on the internal build servers?
>
> gert
>=20=20=20
It's here:

<http://secure.openvpn.net/win>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


