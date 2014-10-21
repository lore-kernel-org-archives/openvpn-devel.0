Message-ID: <54461F20.5060908@...1147...>
Date: Tue, 21 Oct 2014 10:53:52 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <54450921.30501@...515...>
In-Reply-To: <54450921.30501@...515...>
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
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi Samuli,

Samuli Sepp=E4nen wrote:
> New Windows installers with OpenSSL 1.0.1j have been released:
>
> <http://openvpn.net/index.php/download/community-downloads.html>
>
> Two of the issues fixed in OpenSSL may impact OpenVPN. More details here:
>
> <http://thread.gmane.org/gmane.network.openvpn.devel/9133>
>
> Let me know if there are any issues with these installers.
>
>=20=20=20
just downloaded the openvpn-install-2.3.4-i004-x86_64.exe file and=20
installed it; installation seems successful but afterwards the GUI fails=20
to start:

cannot create HKLM\Software\Openvpn-GUI key

Running the gui with elevated privileges fixes this issue. Shouldn't the=20
installer have created this registry key?
This is on Windows 7 Pro 64bit.


JJK


