References: <56C3205A.6050408@...515...>
	<1455629142.4832.121.camel@...1866...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C32CB4.5020705@...515...>
Date: Tue, 16 Feb 2016 16:05:40 +0200
MIME-Version: 1.0
In-Reply-To: <1455629142.4832.121.camel@...1866...>
Subject: Re: [Openvpn-devel] Always including tap-windows6,
 openvpn-gui and easy-rsa in openvpn-build -generated Windows
 installers?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Tue, 2016-02-16 at 15:12 +0200, Samuli Sepp=C3=A4nen wrote:
>> Hi,
>>
>> Currently openvpn-build allows producing installers which do not
>> _contain_ tap-windows6, openvpn-gui or easy-rsa at all. On top of this
>> one can - at install time - select which of the contained components are
>> intalled.
>>
>> Let me know if you have good arguments on why we should have the option
>> to generate installers without the said components. If nobody speaks up,
>> I'll remove the conditional code from openvpn.nsi while preparing for
>> the OpenVPN 2.4 release.
>
> It's nice to have a standalone signed installer for tap-windows6
> without OpenVPN. Not sure if your question really covered that one... ?

Hi,

There is and will be a standalone tap-windows6 installer. I'm just=20
suggesting we remove the option to generate installers which do not=20
include tap-windows6.

So basically we have two layers here:

1) Include tap-windows6 in the installer? (yes/no)
2) Install tap-windows6 _if_ it is included in the installer? (yes/no)

I suggest we remove layer #1 to simplify things.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

