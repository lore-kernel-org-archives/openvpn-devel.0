References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
	<CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
	<531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
	<CAKuzo_jrNwhGHSFkXW4MiaoZyNFV8Jne1tU8eHyqUTECbzm74g@...278...>
	<34caff62-dcb8-235f-7875-20e58197e1a0@...2150...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <9abfa7a3-73f9-d932-d3e8-c105676f0c9d@...515...>
Date: Wed, 13 Jul 2016 12:59:52 +0300
MIME-Version: 1.0
In-Reply-To: <34caff62-dcb8-235f-7875-20e58197e1a0@...2150...>
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to
 disable source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Noel Kuntze <noel@...2150...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> On 10.07.2016 19:58, Selva Nair wrote:
>> Hi,
>>
>>     The instructions in Selva's link weren't enough to convince windows =
to trust the driver. I had to also enable debug mode and I signed it with o=
ne of my own certificates.
>>
>>
>> You have to sign the driver even in test-signing mode -- only the requir=
ement for verified signature is not imposed so that the developer can use a=
 self-signed certificate. This is explained in the test-signing docs on MSD=
N.
>>
>> Selva
> Hello Selva,
>
> That's what I did, but Windows did not accept the signed driver and displ=
ayed an error in the device manager. My application could not open a handle=
 on the TAP device. Therefore it did not work correctly.

Hi,

Just in case you managed to miss these:

<https://community.openvpn.net/openvpn/wiki/BuildingTapWindows6>
<https://github.com/mattock/sign-tap6/>

I spent lots of time getting Authenticode signatures for official=20
tap-windows6 release just right. I assume that even in test mode the=20
only relaxed requirement is that the certificate chain does not need to=20
lead to a known-good CA. The other parameters still need to be just=20
right (e.g. hash algorithm).

When you get to the point where you want to distribute the driver to=20
users, you will (for the time being) need two different signatures for=20
the driver to work properly on all (supported) Windows versions. The=20
"sign-tap6" tool I wrote (above) can help you automate that.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

