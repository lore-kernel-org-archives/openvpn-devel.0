Message-ID: <4BA738E2.1060709@...515...>
Date: Mon, 22 Mar 2010 11:31:14 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4BA34355.5020300@...515...> <4BA395E5.8010607@...1147...>
In-Reply-To: <4BA395E5.8010607@...1147...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (18th Mar 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi Samuli,
>
> (I'd prefer to be referred to as JJK in minutes ;-) )
>
>=20=20=20
I'll try to remember that next time, JJK ;)

>=20=20=20
>> Discussed potential problems with disfunctional proxy servers:
>>
>> <http://sourceforge.net/tracker/?func=3Ddetail&atid=3D454722&aid=3D18400=
41&group_id=3D48978>
>>
>> RFC2817 clearly states that proxies need to use this syntax:
>>
>>  CONNECT host:port/
>>
>>=20=20=20
>>=20=20=20=20=20
> that is not entirely correct:
>
> 5.2 Requesting a Tunnel with CONNECT
>
>    A CONNECT method requests that a proxy establish a tunnel connection
>    on its behalf. The Request-URI portion of the Request-Line is always
>    an 'authority' as defined by URI Generic Syntax [2], which is to say
>    the host name and port number destination of the requested connection
>    separated by a colon:
>
>       CONNECT server.example.com:80 HTTP/1.1
>       Host: server.example.com:80
>
>    Other HTTP mechanisms can be used normally with the CONNECT method --
>    except end-to-end protocol Upgrade requests, of course, since the
>    tunnel must be established first.
>
>
> the "other HTTP mechanisms" seems to be implemented by some (reverse?)=20
> proxy servers ; there are numerous hits in google if you look closely.=20
> Still don't know how relevant they are, however
>=20=20=20
I sent mail to the bug author - so far no response.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


