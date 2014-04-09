MIME-Version: 1.0
In-Reply-To: <53450525.4010704@...1227...>
References: <5343BCAB.3040102@...1790...> <0LikyX-1X9YfO48dR-00d2sy@...1825...>
	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
	<5343FF41.3080406@...1879...> <5344111D.3080408@...515...>
	<5344145F.3010702@...515...> <53442B8A.2030105@...515...>
	<CAFHpkQE-6kqi+RT4oF_F+4YULRd=NtJ3rCNK-YR+JrGM47s-sw@...278...>
	<53450525.4010704@...1227...>
Date: Wed, 9 Apr 2014 14:32:42 +0600
Message-ID: <CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Heartbleed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="KOI8-R"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I used to think that client without "nobind" option binds to 1194/udp
(we encountered that issue with multiple openvpn connection on the
same machine), so, "nobind" tells openvpn instance not to bind to
udp/1194, and so, only openvpn server can exploit heartbleed
vulnerability, but not any attacker.

2014-04-09 14:30 GMT+06:00 Arne Schwabe <arne@...1227...>:
> Am 09.04.14 10:25, schrieb =E9=CC=D8=D1 =FB=C9=D0=C9=C3=C9=CE:
>> am I right that "nobind" option gives some protection to windows
>> openvpn client ?
>>
> No. Nobind gives no protection.
>
> Arne

