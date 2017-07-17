References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
	<41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
	<689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
	<da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <708a613e-e4e0-93ea-895a-bf99bce520cb@...515...>
Date: Mon, 17 Jul 2017 15:04:27 +0300
MIME-Version: 1.0
In-Reply-To: <da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 17/07/2017 15:01, Jan Just Keijser wrote:
> Hi all,
>=20
> On 17/07/17 12:34, Samuli Sepp=C3=A4nen wrote:
>> On 15/07/2017 00:43, Jan Just Keijser wrote:
>>> Hi Samuli,
>>>
>>> On 14/07/17 16:07, Samuli Sepp=C3=A4nen wrote:
>>>> Hi all,
>>>>
>>>> Those of you who use pkcs11 on Windows: could you please test this new
>>>> Windows installer:
>>>>
>>>> <http://build.openvpn.net/downloads/releases/openvpn-install-2.4.3-I60=
2.exe>
>>>>
>>>>
>>>>
>>>> The previous installer(s) had pkcs11-helper 1.11. This one has 1.22, so
>>>> some regression testing would be good to have.
>>>>
>>>> I'd like to push the updated installer out early next week, preferably
>>>> on Monday.
>>>>
>>> nice to see that pkcs11 support is still included in the Windows
>>> version; I can test the installer on monday morning(no Windows laptop in
>>> my house ;))  I will let you know my findings.
>>>
>>> cheers,
>>>
>>> JJK
>>>
>> Hi JJK,
>>
>> Excellent, thanks! I will push out the new installer if everything looks
>> good at your end.
>>
>=20
> good news and bad news:
>=20
> + the pkcs11 stuff works as expected, no problems there
> - with openvpn 2.4.3 my existing setup using "redirect-gateway def1"=20
> stopped working!
>=20
> I'll downgrade OpenVPN to see if this problem was already there in
> 2.3.XX ; what happens is this:
> - openvpn wants to add a direct route to the VPN server
> - there happen to be TWO gateways to that server with the SAME IP
> address, one via wired ethernet, one via wireless
> - openvpn gets confused and says "route gateway is ambiguous" and
> refuses to add it
> - after that, all traffic is jammed, as there is no direct route to the
> VPN server itself, and thus all encrypted traffic is fed back into the
> tunnel, where it is encrypted again, etc etc ("biting your own tail").
>=20
> Disconnecting either wired or wireless solves the issue AFTER restarting
> OpenVPN. Annoying.
> It looks like a (minor) patch is needed to deal with this special case
>=20
> cheers,
>=20
> JJK
>=20

Hi,

Thanks for testing! I will push out the new installer tomorrow,
hopefully in the morning (EEST).

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

