MIME-Version: 1.0
In-Reply-To: <54461F20.5060908@...1147...>
References: <54450921.30501@...515...>
	<54461F20.5060908@...1147...>
Date: Wed, 22 Oct 2014 00:15:16 +0600
Message-ID: <CAFHpkQH0b6aEqwhXcAyns2DvzDGuX=MizpU5w5Kf+rT=3x5TKg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

this is because Heiko rejected merge request:
http://sourceforge.net/p/openvpn-gui/code/merge-requests/1/

it is easily fixed by openvpn-gui manifest

<requestedExecutionLevel level=3D"requireAdministrator" uiAccess=3D"false"/>

I keep hearing from Heiko about some magic openvpn service for years.
it is just couple of minutes to merge that request though...


2014-10-21 14:53 GMT+06:00 Jan Just Keijser <janjust@...1147...>:
> Hi Samuli,
>
> Samuli Sepp=C3=A4nen wrote:
>> New Windows installers with OpenSSL 1.0.1j have been released:
>>
>> <http://openvpn.net/index.php/download/community-downloads.html>
>>
>> Two of the issues fixed in OpenSSL may impact OpenVPN. More details here:
>>
>> <http://thread.gmane.org/gmane.network.openvpn.devel/9133>
>>
>> Let me know if there are any issues with these installers.
>>
>>
> just downloaded the openvpn-install-2.3.4-i004-x86_64.exe file and
> installed it; installation seems successful but afterwards the GUI fails
> to start:
>
> cannot create HKLM\Software\Openvpn-GUI key
>
> Running the gui with elevated privileges fixes this issue. Shouldn't the
> installer have created this registry key?
> This is on Windows 7 Pro 64bit.
>
>
> JJK
>
>
> -------------------------------------------------------------------------=
-----
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://p.sf.net/sfu/Zoho
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

