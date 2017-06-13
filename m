References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
	<20170613192559.GX97029@...1296...>
	<CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
	<20170613193756.GY97029@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <864bbbd2-09d7-718b-ca99-4f428ed0ba95@...515...>
Date: Tue, 13 Jun 2017 22:50:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170613193756.GY97029@...1296...>
Content-Language: en-US
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 13/06/2017 22:37, Gert Doering wrote:
> Hi,
>=20
> On Tue, Jun 13, 2017 at 03:33:35PM -0400, Selva Nair wrote:
>> Right :)  But we could probably do better using Set instead of Add while
>> the address is set using the service. I'm not that familiar with ipapi, =
but
>> looks like SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntry
>> may be the right thing.
>>
>> The netsh command used when service is not in use does correctly do a set
>> not add.
>=20
> Good point.  Wouldn't solve the first problem, but at least a subsequent
> run would "magically fix it", provided the same tap interface is used
> (which, I think, is the case in the great majority of windows installatio=
ns)
>=20
> gert
>=20

Hi,

If I'm not mistaken, this is the same or related problem to the one I
reported early on in 2.4.x release cycle. There might actually be a Trac
ticket for it.

I encountered the issue with the Powershell test suite
(openvpn-windows-test) which ran through a bunch of t_client test
configs and forcibly killed the OpenVPN process at the end of each test.
All ping6 tests except the first one would then fail, because adding a
default IPv6 route failed as one existed already.

If you want I can dig up the Trac ticket number later.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

