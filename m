From: "Morris, Russell" <rmorris@...1315...>
Date: Wed, 28 Oct 2015 12:39:33 +0000
Message-ID: <BY2PR08MB13808E465DF30E92364A69C3B9210@...2086...>
References: <562DF8BA.1090406@...515...>
	<071C5EF6-E94A-422D-9456-0E6015C10F8D@...277...>
	<CAKuzo_if_4L81xNZKDPJhek_FicxM-c2ZvWkYcZq1tMjGpXXvw@...278...>
	<E8664D21-2E83-4E50-AB23-B0B36533F7E0@...277...>
	<5630AE4D.8040401@...2080...>
In-Reply-To: <5630AE4D.8040401@...2080...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 26th Oct 2015) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Gmail <volleynbike@...277...>, Selva Nair <selva.nair@...277...>

Hi,

Agreed! Fix the underlying problem, don't put a band-aid on it ... ;-). So =
do we start from the TAP adapter, which seems to "fail" first, then there i=
s a ripple effect? Or look at OpenVPN - should it really exit, or just repo=
rt TAP not present, and keep trying to reconnect (would address standby / r=
esume)?

Thoughts?

Thanks,
... Russell


-----Original Message-----
From: David Sommerseth [mailto:openvpn@...2080...]=20
Sent: Wednesday, October 28, 2015 6:15 AM
To: Gmail <volleynbike@...277...>; Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Topics for today's (Monday, 26th Oct 2015) com=
munity meeting

On 27/10/15 07:07, Gmail wrote:
> On Oct 26, 2015, at 8:41 AM, Selva Nair <selva.nair@...277...
> <mailto:selva.nair@...277...>> wrote:
>=20
>>
>> On Mon, Oct 26, 2015 at 11:17 AM, Gmail <volleynbike@...277...
>> <mailto:volleynbike@...277...>> wrote:
>>
>>     Regarding the instability of connection in the windows version:  I
>>     overcame this long ago (and works well to this date) by building a
>>     tiny script that periodically pings the the ovpn gateway (server).
>>     If no ping reply then restart the service. Very simple. Perhaps
>>     this could be built into the code as an option?
>>
>>
>> Oh, please, no... If the TAP driver has stability woes it needs to be
>> fixed. True loss of network connectivity is already handled by
>> internal pings and ping-restarts. It would be a grave mistake to add
>> such options to hide any stability issues.=20
>>
>> Cheers,
>>
>> Selva
>>
> Your concern is understood and acknowledged. Perhaps the ping-restart
> idea is useful in the interim until the cause is located?

This will work in regards to ensure that openvpn client and server will
have a working connection.  Configuring OpenVPN with
--ping/--ping-restart (or the --keepalive "macro", which does it even
better), is generally recommended and is the best way to provide a more
"stable" VPN experience.

If anything happens with the TAP driver, OpenVPN will not re-initialize
the TAP adapter - thus OpenVPN should stop running.  When the TAP driver
have an issue, it is just like your Ethernet or WIFI driver have an
issue.  If the TAP adapter "disappears", it's just like unplugging your
network adapter in your computer, in these situations OpenVPN should
really stop.

So I do agree with Selva, if there are stability issues with the TAP
driver, those issues should be fixed in the driver.  If there are things
outside of OpenVPN or the TAP driver which does funky stuff, that should
as far as possible be fixed there.


--=20
kind regards,

David Sommerseth


