From: Jan Just Keijser <janjust@...1147...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
	<41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
	<689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
	<da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
Message-ID: <82ec1478-ec53-3980-05b1-4529a74aa789@...1147...>
Date: Mon, 17 Jul 2017 14:10:11 +0200
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
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Follow-up:

this problem is NOT present in OpenVPN 2.3.17; the same warning appears (ro=
ute gateway is ambiguous) but the route is added=20
anyway. This seems to be a regression in 2.4.

JJK


On 17/07/17 14:01, Jan Just Keijser wrote:
> Hi all,
>
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
>
> good news and bad news:
>
> + the pkcs11 stuff works as expected, no problems there
> - with openvpn 2.4.3 my existing setup using "redirect-gateway def1"  sto=
pped working!
>
> I'll downgrade OpenVPN to see if this problem was already there in 2.3.XX=
 ; what happens is this:
> - openvpn wants to add a direct route to the VPN server
> - there happen to be TWO gateways to that server with the SAME IP address=
, one via wired ethernet, one via wireless
> - openvpn gets confused and says "route gateway is ambiguous" and refuses=
 to add it
> - after that, all traffic is jammed, as there is no direct route to the V=
PN server itself, and thus all encrypted traffic is=20
> fed back into the tunnel, where it is encrypted again, etc etc ("biting y=
our own tail").
>
> Disconnecting either wired or wireless solves the issue AFTER restarting =
OpenVPN. Annoying.
> It looks like a (minor) patch is needed to deal with this special case
>
> cheers,
>
> JJK
>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


