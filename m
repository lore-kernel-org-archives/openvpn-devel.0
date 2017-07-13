References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
Date: Thu, 13 Jul 2017 09:16:13 +0300
MIME-Version: 1.0
In-Reply-To: <a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: ValdikSS <valdikss@...277...>, openvpn-devel@lists.sourceforge.net

On 13/07/2017 09:05, Antonio Quartulli wrote:
> On 13/07/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> Should we add --disable-multi to some travis-ci build ?
>=20
> Might be a good idea. It was actually broken since 2013, therefore it
> seems like not many people are using it....either we drop it or yes, we
> should have some automated test.

There were no bugs reports about --disable-multi in Trac. I say scrap
that option altogether and make the code slightly cleaner and less
entangled.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

