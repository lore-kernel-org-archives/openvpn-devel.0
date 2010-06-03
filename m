Mime-Version: 1.0 (Apple Message framework v1078)
From: Eric F Crist <ecrist@...1286...>
In-Reply-To: <loom.20100603T180754-260@...171...>
Date: Thu, 3 Jun 2010 12:47:47 -0500
Message-Id: <173DB246-2AFC-45C6-A61B-DC970220BB2D@...1286...>
References: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
	<1275576515.23148.829.camel@...1259...>
	<20100603154619.GD26982@...1296...>
	<loom.20100603T180754-260@...171...>
Subject: Re: [Openvpn-devel] [PATCH] Re: Handling of subnets grammar
	in	Packet filter file
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
To: chantra <chantra@...1258...>
Cc: openvpn-devel@lists.sourceforge.net

On Jun 3, 2010, at 12:38:19, chantra wrote:

> Gert Doering <gert <at> greenie.muc.de> writes:
>=20
>=20
>> Both have merits, your fix is somewhat less code then adding an extra in=
put
>> validation check=20
>>=20
>>  if ((network.s_addr & netmask) !=3D network.s_addr )=20=20
>>    { complain; }
>>=20
>> - so: ACK from me.
>>=20
>> (Since OpenVPN likes to print warnings, we *could* add code to print a=20
>> warning in this case - "warning: subnet address changed to match /%d,
>> new value is %s/%d").
>>=20
>> gert
>=20
> Gert,
>=20
> As discussed on IRC, it make sense to "warn" the admin,=20
> but it seems it is all that can be done as this is=20
> being going on at runtime.
>=20
> I upated the patch and it will now display something like:
> WARNING: PF: /dev/shm/openvpn_pf_ff18e7030fd03ce91bd0432563e4eb1a.tmp/5:=
=20
> incorrect subnet 192.168.100.8/28 changed to 192.168.100.0/28

This seems rather pedantic to me...

---
Eric Crist





