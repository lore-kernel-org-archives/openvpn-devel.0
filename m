References: <35b9d93f-0682-9457-49f6-cf96507fc59f@...515...>
	<8dff9a3b-003b-4a48-3ff6-21f0663ba712@...277...>
	<13724284-0709-d43e-a1ab-f6abea65362f@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0b890451-25c5-5a34-37f5-84b2fe2a3319@...515...>
Date: Mon, 21 Nov 2016 15:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <13724284-0709-d43e-a1ab-f6abea65362f@...277...>
Subject: Re: [Openvpn-devel] Combined 32/64-bit OpenVPN 2.4_beta1 installer
 available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

Il 20/11/2016 23:16, debbie10t ha scritto:
>
>
> On 18/11/16 20:14, debbie10t wrote:
>> Hi,
>>
>> On 18/11/16 13:29, Samuli Sepp=E4nen wrote:
>>> Hi,
>>>
>>> OpenVPN 2.4_rc1[1] will be bundled as a combined installer[2] that works
>>> on both 32-bit and 64-bit Windows versions (Vista and above). A preview
>>> installer based on 2.4_beta1 is available here:
>>>
>>> <https://build.openvpn.net/downloads/snapshots/openvpn-install-2.4_beta=
1-I901.exe>
>>>
>>>
>>> The installer also contains an updated openvpnserv2 (OpenVPNService),
>>> which attempts to shut down OpenVPN instances cleanly instead of just
>>> killing them on service stop or restart[3].
>>>
>>> I already ran the Powershells tests[4] on it, and chipitsine has done
>>> independent testing. However, more testing would be welcome. In
>>> particular:
>>>
>>> - Ensure that by default the files are places to correct directory, that
>>> is, C:\Program Files\OpenVPN on both 32-bit and 64-bit Windows
>>
>>
>> I have tested the basic install plus adding a 2nd TAP adapter
>> Running my Server (with multiple clients) works (Will leave over night)
>> plus running a client all work as per the label :-)
>>
>>
>>
>>
>>> - Test silent install with default settings
>>> - Test silent install to a non-standard directory
>>> - Ensure that registry keys go to the correct (32-bit or 64-bit) regist=
ry
>>> - Test that uninstall works as expected
>>
>
> After some initial problems *uninstalling* snapshot versions, I finally
> managed to install this successfully into a non-standard dir
> C:\#Tools\Openvpn
>
>
> Provided that the previous install is fully removed (including registry)
> then the install is successful. Otherwise it fails in a non-standard dir


Hi,

How and at which point does it fail if previous OpenVPN version is not=20
uninstalled first?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

