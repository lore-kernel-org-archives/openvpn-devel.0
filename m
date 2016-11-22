References: <35b9d93f-0682-9457-49f6-cf96507fc59f@...515...>
	<8dff9a3b-003b-4a48-3ff6-21f0663ba712@...277...>
	<13724284-0709-d43e-a1ab-f6abea65362f@...277...>
	<0b890451-25c5-5a34-37f5-84b2fe2a3319@...515...>
	<102609f5-719f-0ce5-05fa-ceaafefa680e@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0a6d70b7-cac2-6f87-e426-168ccc3a021e@...515...>
Date: Tue, 22 Nov 2016 08:52:55 +0200
MIME-Version: 1.0
In-Reply-To: <102609f5-719f-0ce5-05fa-ceaafefa680e@...277...>
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

Il 21/11/2016 19:00, debbie10t ha scritto:
>
>
> On 21/11/16 13:28, Samuli Sepp=E4nen wrote:
>> Il 20/11/2016 23:16, debbie10t ha scritto:
>
>>>
>>> Provided that the previous install is fully removed (including registry)
>>> then the install is successful. Otherwise it fails in a non-standard dir
>
>>
>> Hi,
>>
>> How and at which point does it fail if previous OpenVPN version is not
>> uninstalled first?
>
> In fact, if any previous version is *not Fully Uninstalled* first (Which
> means cleaning the registry by manually removing entire registry key
> HKLocalMach_SW_Openvpn) .. And then this version is installed to any
> *other* directory than the one it was previously installed to .. The
> resulting installation will not work.
>
> Please see attached

Hi,

Yes, I actually noticed that myself when testing the combined installer=20
patch[1] myself:

<https://github.com/OpenVPN/openvpn-build/issues/49>

That problem is also present in official 2.4_beta1 installers also and=20
does not seem related to silent or interactive installations.

Samuli

[1] <https://github.com/OpenVPN/openvpn-build/pull/44>


