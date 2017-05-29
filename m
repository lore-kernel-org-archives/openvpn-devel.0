References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
	<6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
	<ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
	<36e89683-6f8f-7595-d140-64d64f71b0f0@...277...>
	<2720741f-5df5-96ba-b253-5b84a9c5ad00@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <effc76b2-1e80-bf9d-1f24-71390398a0a0@...515...>
Date: Mon, 29 May 2017 15:56:54 +0300
MIME-Version: 1.0
In-Reply-To: <2720741f-5df5-96ba-b253-5b84a9c5ad00@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
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
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, debbie10t <debbie10t@...277...>

On 29/05/2017 15:51, David Sommerseth wrote:
> On 29/05/17 14:26, debbie10t wrote:
>>
>> It turns out pkg-config is not installed
>> After installing all worked as expected.
>=20
> Great!
>=20
> I was too lazy to check ... but do we have some documentation on build
> requirements anywhere?  Should probably be checked into the main openvpn
> git repository.  And we should ensure pkg-config is listed there, at
> least for Linux builds.  Not sure if we depend on that on the various
> *BSD distros.
>=20

There is some documentation here:

<https://community.openvpn.net/openvpn/wiki/TesterDocumentation>

The documentation in README and INSTALL seems rather outdated, even
though mostly correct. Those files should definitely be revised.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

