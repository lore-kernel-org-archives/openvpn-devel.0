References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
	<20170613192559.GX97029@...1296...>
	<CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
	<20170613193756.GY97029@...1296...>
	<864bbbd2-09d7-718b-ca99-4f428ed0ba95@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <34f8b3af-225c-f3dc-19c1-2acf4fc840b6@...277...>
Date: Thu, 15 Jun 2017 15:26:46 +0100
MIME-Version: 1.0
In-Reply-To: <864bbbd2-09d7-718b-ca99-4f428ed0ba95@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net



On 13/06/17 20:50, Samuli Sepp=E4nen wrote:

> Hi,
>=20
> If I'm not mistaken, this is the same or related problem to the one I
> reported early on in 2.4.x release cycle. There might actually be a Trac
> ticket for it.
>=20
> I encountered the issue with the Powershell test suite
> (openvpn-windows-test) which ran through a bunch of t_client test
> configs and forcibly killed the OpenVPN process at the end of each test.
> All ping6 tests except the first one would then fail, because adding a
> default IPv6 route failed as one existed already.
>=20
> If you want I can dig up the Trac ticket number later.
>=20

Looks like this one:
https://community.openvpn.net/openvpn/ticket/771


