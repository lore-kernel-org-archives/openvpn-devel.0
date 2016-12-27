References: <28845a1e-10a6-6f31-4a90-e3e66bf61b43@...515...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <de2c5fe8-9de5-6d0a-35c6-87a889efcd83@...68...>
Date: Wed, 28 Dec 2016 00:24:03 +0100
MIME-Version: 1.0
In-Reply-To: <28845a1e-10a6-6f31-4a90-e3e66bf61b43@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.0 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 27.12.2016 15:16, Samuli Sepp=E4nen wrote:
> The OpenVPN community project team is proud to release OpenVPN 2.4.0. It =

> can be downloaded from here:
>=20
> <http://openvpn.net/index.php/open-source/downloads.html>
>=20
> Compared to OpenVPN 2.3 this is a major update with a large number of=20
> new features, improvements and fixes. Changes compared to the previous=20
> OpenVPN 2.4 release are very minor. A summary of these changes is=20
> available here:

I've uploaded 2.4.0 to FreeBSD, the mbedTLS-based build is now called
openvpn-mbedtls (no longer -polarssl), and I have preserved - for three
months - the older version v2.3.14 as openvpn23[-polarssl], so if we
don't get showstoppers reported, we should see these four packages in
the "quarterly" stable ports branch and binary packages.


