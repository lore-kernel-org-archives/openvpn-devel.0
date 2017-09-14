References: <59B26C92.1040105@...1147...>
 <61c0c096-14e8-1e8d-cfc5-7726d667a31f@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <5f8ed7e5-7a0a-7019-0b25-265a92004a62@...1147...>
Date: Thu, 14 Sep 2017 17:16:05 +0200
MIME-Version: 1.0
In-Reply-To: <61c0c096-14e8-1e8d-cfc5-7726d667a31f@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] how to roll your own OpenVPN Windows installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Hi all,

On 11/09/17 09:06, Samuli Sepp=E4nen wrote:
> Il 08/09/2017 13:10, Jan Just Keijser ha scritto:
>> hi dev list,
>>
>> someone asked me this question: how can one roll their own Windows OpenV=
PN installer, including a signed TAP driver? There's=20
>> no need to rebuild OpenVPN or the TAP driver, but they do need to includ=
e other things, such as certificates, config files etc.
>> Is there a way to repackage the existing TAP driver?=A0 are there instru=
ctions for that?
>>
>> TIA,
>>
>> JJK
>>
> Hi,
>
> I meant to answer this earlier, but then apparently forgot. The tap-windo=
ws installer is simply embedded into the main OpenVPN=20
> installer, so the pre-existing, signed tap-windows6 driver can be reused =
as-is. An OpenVPN installer can be generated in the=20
> openvpn-build cross-compile environment:
>
> <https://github.com/OpenVPN/openvpn-build>
>
> Usage of openvpn-build is pretty well documented on Trac:
>
> <https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyst=
em>
>
> On this page you can find automated cross-compile environment setup scrip=
ts which work for Ubuntu 14.04 and 16.04:
>
> <https://community.openvpn.net/openvpn/wiki/SettingUpGenericBuildsystem>
>
> It is also possible to generate a new installer without actually building=
 anything. The challenge is that the NSI install=20
> script (openvpn.nsi) in openvpn-build depends on a number of variables se=
t during the build process, and on a certain=20
> directory structure. So it is generally easier just to rebuild everything.
>
thanks all for the feedback, this is exactly what my colleague was looking =
for!
He's now convinced that he no longer wants to rebuild openvpn or the tap dr=
iver :)

cheers,

JJK



