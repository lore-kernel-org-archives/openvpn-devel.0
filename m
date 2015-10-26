From: Gmail <volleynbike@...277...>
References: <562DF8BA.1090406@...515...>
	<071C5EF6-E94A-422D-9456-0E6015C10F8D@...277...>
	<SN1PR08MB13914050228AC2BFB44EE972B9230@...2065...>
Mime-Version: 1.0 (1.0)
In-Reply-To: <SN1PR08MB13914050228AC2BFB44EE972B9230@...2065...>
Message-Id: <FCD949AD-BE9F-4CD5-B8FF-7D71FC737574@...277...>
Date: Mon, 26 Oct 2015 08:41:38 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Yes. Maybe an option that defaults the ping to the tunnel gateway with a sw=
itch to choose some other IP?

Sent from my iPhone

> On Oct 26, 2015, at 8:20 AM, Morris, Russell <rmorris@...1315...> wrote:
>=20
> Agreed! This is what I have done locally also - enter a machine on the se=
rver side, and ping it at some interval.
>=20
> FYI, this doesn't have to be only the server itself. I use a different ma=
chine, to make sure my routes get set up properly also.
>=20
> Thanks,
> ... Russell
>=20
>=20
>=20
> -----Original Message-----
> From: Gmail [mailto:volleynbike@...277...]=20
> Sent: Monday, October 26, 2015 10:18 AM
> To: Samuli Sepp=C3=A4nen <samuli@...515...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Topics for today's (Monday, 26th Oct 2015) c=
ommunity meeting
>=20
> Regarding the instability of connection in the windows version:  I overca=
me this long ago (and works well to this date) by building a tiny script th=
at periodically pings the the ovpn gateway (server). If no ping reply then =
restart the service. Very simple. Perhaps this could be built into the code=
 as an option?
>=20
> Best,
> Marvin Adeff
>=20
> Sent from my iPhone
>=20
>> On Oct 26, 2015, at 2:56 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>>=20
>> Hi,
>>=20
>> We're going to have an IRC meeting today starting at 20:00 CET (19:00=20
>> UTC) on #openvpn-devel <at> irc.freenode.net. Current topic list along=20
>> with basic information is here:
>>=20
>> <https://community.openvpn.net/openvpn/wiki/Topics-2015-10-26>
>>=20
>> If you have any other things you'd like to bring up, respond to this=20
>> mail, send me mail privately or add them to the list yourself.
>>=20
>> In case you can't attend the meeting, please feel free to make comments=
=20
>> on the topics by responding to this email or to the summary email sent=20
>> after the meeting. Whenever possible, we'll also respond to existing,=20
>> related email threads.
>>=20
>> NOTE: It's required to use a registered Freenode IRC nickname to join=20
>> #openvpn-devel - look here for details:
>>=20
>> <https://community.openvpn.net/openvpn/wiki/GettingHelp#DeveloperIRCchan=
nel>
>>=20
>> --=20
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>=20
>> irc freenode net: mattock
>>=20
>> ------------------------------------------------------------------------=
------
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

