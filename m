Subject: Re: [Openvpn-devel] Re: Radius support (Authentification,
	Authorization and Accounting)
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <d6dh8d$g4o$1@...165...>
References: <200504291033.00667.ralfluebben@...68...>
	 <Pine.LNX.4.58.0504300118280.24107@...41...>
	 <Pine.LNX.4.58.0504301334040.25603@...41...>
	 <200505031348.25263.ralfluebben@...68...>
	 <Pine.LNX.4.58.0505031000150.1970@...41...>   <d6dh8d$g4o$1@...165...>
Message-Id: <1116363865.11190.16.camel@...23...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue May 17 14:06:27 2005
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am Dienstag, den 17.05.2005, 23:39 +0400 schrieb Ralf L=C3=BCbben:
>   Or are there great advantages if every user gets his own tun
>   interface?=20

No. This is not really necessary.

>   To Torge Szczepanek: Which radius server do you use?
>         I use freeradius and I think I can only set

I am also using FreeRadius.

>         a static IP addres as "Framed IP Address".

Static IP-Addresses don't need the NAS-Port Parameter to be set.=20

>         I don't know how dynamic ip assigment works
>         on a radius server. But I will implement the=20
>         radius attributes NAS-Port, NAS-IP-Adress, NAS_Identifier

Dynamic IP Pools are implemented using the ippool directive in the
radiusd.conf file (in FreeRadius).

Example from my config:

        ippool mainpool {
                name =3D mainpool
                #  range-start,range-stop: The start and end ip
                #  addresses for the ip pool
                range-start =3D x.y.72.10
                range-stop =3D x.y.79.255

                #  netmask: The network mask used for the ip's
                netmask =3D 255.255.255.255

                #  cache-size: The gdbm cache size for the db
                #  files. Should be equal to the number of ip's
                #  available in the ip pool
                cache-size =3D 2048

                # session-db: The main db file used to allocate ip's to
clients
                session-db =3D ${raddbdir}/db.ippool

                # ip-index: Helper db index file used in multilink
                ip-index =3D ${raddbdir}/db.ipindex

                # override: Will this ippool override a
Framed-IP-Address already set
                override =3D no
        }

In post-auth you then specify mainpool, to let the client receive a IP
through radius.:

post-auth {
        #  Get an address from the IP Pool.
        mainpool
[...]

In the accounting section you can (but must not) define an entry, where
the IP is returned to the pool, when the server is seeing a stop record:

accounting {
[...]
        #  Return an address to the IP Pool when we see a stop record.
        mainpool
}

In the Users File (or somewhere else) you have to specify a Pool-Name
attribute:

DEFAULT Pool-Name :=3D mainpool


I can test the dynamic IP stuff, when you have created the Radius patch

>         and Service-Type=3D"Framed" in the ACCEPT-REQUEST.
>         Are these all attributes?

I think that these are all necessary attributes. If I do a tcpdump on my
PPTP Server setup I see an additional Attribute, which is
Framed_proto{PPP}. But for OpenVPN this is obviously not correct.=20

As one can see in
http://www.freeradius.org/rfc/rfc2865.html#Framed-Protocol there is no
corresponding Framed-Protocol available.

--=20
Torge Szczepanek <openvpn-devel@...239...>


