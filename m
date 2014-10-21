Message-ID: <544625E6.9050508@...515...>
Date: Tue, 21 Oct 2014 12:22:46 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
In-Reply-To: <54461F20.5060908@...1147...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi Samuli,
>
> Samuli Sepp=E4nen wrote:
>> New Windows installers with OpenSSL 1.0.1j have been released:
>>
>> <http://openvpn.net/index.php/download/community-downloads.html>
>>
>> Two of the issues fixed in OpenSSL may impact OpenVPN. More details here:
>>
>> <http://thread.gmane.org/gmane.network.openvpn.devel/9133>
>>
>> Let me know if there are any issues with these installers.
>>
>>=20=20=20
> just downloaded the openvpn-install-2.3.4-i004-x86_64.exe file and
installed it; installation seems successful but afterwards the GUI fails
to start:
>
> cannot create HKLM\Software\Openvpn-GUI key
>
> Running the gui with elevated privileges fixes this issue. Shouldn't
the installer have created this registry key?
> This is on Windows 7 Pro 64bit.
>

Hi Jan,

Currently the installer does not currently create or update the
OpenVPN-GUI registry keys. This is primarily for historic reasons -
OpenVPN-GUI has never had it's own installer, so it sets up it's own
environment during first startup (as admin).

I've written a separate NSI installer script for OpenVPN-GUI[*], which
will take care of updating the keys as necessary. The plan is to include
the OpenVPN-GUI installer in OpenVPN 2.4 installers only to avoid
introducing installers bugs in our stable releases.

In my opinion the registry key generation should be removed from
OpenVPN-GUI when the installer is fully functional, tested and
integrated with OpenVPN.

Samuli

[*] The NSI script should be in openvpn-gui Git repository
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRGJeYACgkQwp2X7RmNIqM6MgCeJjolkqW8gzufaZ+Qj84GfJGr
ypgAoJrcJLDQQQ49p/dVSSjWHLd0cNwD
=3DUTHP
-----END PGP SIGNATURE-----



