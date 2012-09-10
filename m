Mime-Version: 1.0 (Apple Message framework v1278)
From: Andrea Bonomi <a.bonomi@...1028...>
In-Reply-To: <504DFDE7.3030405@...1114...>
Date: Mon, 10 Sep 2012 17:24:04 +0200
Message-Id: <3158B8BB-F0EB-40BD-A66C-10E6C37DA57A@...1028...>
References: <29D21832-CC91-4783-A015-D8AE7C7D0E9D@...1028...>
	<504DFDE7.3030405@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Add 1:1 network mapping option
	(--netmap)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

There no difference, it's exactly the same feature.
The next time I promise to check better before implementing something that =
already exist.
Sorry,
Andrea Bonomi
:: e n d i a n
:: security with passion

:: andrea bonomi
:: http://www.endian.com  :: a.bonomi@...1028...

On 10/set/2012, at 16:49, David Sommerseth wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 10/09/12 15:38, Andrea Bonomi wrote:
>> Dear Developers, I developed a patch for implementing 1:1 NAT
>> (something similar to the iptables NETMAP target). This is useful
>> in situations when you have the same (private) network address
>> behind clients. For example, consider the following scenario:
>>=20
>> -lan1--192.168.0.0/24--      -lan2--192.168.0.0/24-- |
>> | gw1 192.168.0.1              gw2 192.168.0.1 |
>> | [tunnel]-----OpenVPN server---[tunnel] | [tunnel] | clients=85
>>=20
>> The clients have to access to both the machines in lan1 and lan2,=20
>> This patch allow to map all the address of a network, e.g. [to g1]
>> push "netmap 172.16.1.0/24 192.168.0.0/24" [to g2] push "netmap
>> 172.16.2.0/24 192.168.0.0/24" The clients can access to, e.g.
>> 192.168.0.79 on lan1 using the IP 172.16.1.79.
>=20
> Hi Andrea,
>=20
> First of all, thanks a lot for your efforts here!  I just have one
> question ... how does this differ from the --client-nat feature in the
> code base for OpenVPN v2.3?  (git master or alpha releases)
>=20
> - From the man page:
>=20
>       --client-nat snat|dnat network netmask alias
>              This pushable client option sets up  a  stateless
>              one-to-one  NAT  rule  on  packet  addresses (not
>              ports), and is useful in cases  where  routes  or
>              ifconfig settings pushed to the client would cre?
>              ate an IP numbering conflict.
>=20
>              network/netmask           (for            example
>              192.168.0.0/255.255.0.0)  defines  the local view
>              of a resource from the client perspective,  while
>              alias/netmask (for example 10.64.0.0/255.255.0.0)
>              defines the remote view from the server  perspec?
>              tive.
>=20
>              Use  snat (source NAT) for resources owned by the
>              client and  dnat  (destination  NAT)  for  remote
>              resources.
>=20
>              Set  --verb  6  for  debugging  info  showing the
>              transformation of src/dest addresses in packets.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAlBN/eUACgkQDC186MBRfrqGzACfWvH91GXH6+Jc0EQ42conCEhZ
> IqQAoKojc8X/H0kn4wyFQtIKzhyzND9f
> =3DBrY7
> -----END PGP SIGNATURE-----


