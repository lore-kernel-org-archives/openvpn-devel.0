Mime-Version: 1.0 (Apple Message framework v1244.3)
From: Davide Guerri <d.guerri@...1502...>
In-Reply-To: <20111008205754.GI8496@...1296...>
Date: Sun, 9 Oct 2011 10:31:35 +0200
Message-Id: <B671C011-D5FD-4CE6-B599-F33BCE462177@...1502...>
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
	<B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
	<49806E1A-9928-4272-8EF5-55943866941D@...1502...>
	<4E8587EC.1020201@...1114...>
	<20111008103117.GG8496@...1296...>
	<5AB7CBF4-64C6-4EF1-A8A1-A902095F14A1@...1502...>
	<20111008205754.GI8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Client's routes ageing timer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,
compiled _with default flags_ (i.e. autoreconf -v -i; ./configure; make) an=
d tested w/ and w/o stale-routes-check option on Ubuntu 10.10 x86_64 and on=
 Ubuntu 8.04.4 LTS x86_64.

So, I formally ACK your patched patch :)

D.


On 08/ott/2011, at 22:57, Gert Doering wrote:

> Hi,
>=20
> On Sat, Oct 08, 2011 at 05:50:13PM +0200, Davide Guerri wrote:
>> sorry for that.
>>=20
>> I've just double checked the patch and there is no other code outside an=
 #ifdef P2MP_SERVER=20
>=20
> Could you test and formally ACK my patch to your patch? :-)
>=20
> Thanks,
>=20
> gert
>=20
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...



--
dott. Davide Guerri - C.A.S.P.U.R. Interuniversity Consortium
Lead R&D Eng. OpenWISP (http://openwisp.caspur.it)
CTO CASPUR per Provinciawifi, Pratowifi, FreeWiFiGenova,=20
Maremmawifi, ProvinciaGoriziaWiFi, IX-WiFi

e-mail: d.guerri@...1502...
phone: +39 06.44486.404
www: http://openwisp.caspur.it/projects/ow/wiki/Davide_Guerri


