Message-ID: <53455A10.9060909@...1435...>
Date: Wed, 9 Apr 2014 16:32:48 +0200
From: Adriaan de Jong <dejong@...1435...>
MIME-Version: 1.0
References: <5343BCAB.3040102@...1790...>
	<0LikyX-1X9YfO48dR-00d2sy@...1825...>	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>	<5343E392.1010803@...1800...>	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>	<5343FF41.3080406@...1879...>
	<5344111D.3080408@...515...>	<5344145F.3010702@...515...>
	<53442B8A.2030105@...515...>	<CAFHpkQE-6kqi+RT4oF_F+4YULRd=NtJ3rCNK-YR+JrGM47s-sw@...278...>	<53450525.4010704@...1227...>	<CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>	<53450887.5060703@...1227...>
	<CAFHpkQFm3v5G-yZohqE2CFoBK7VOx9TcKttG2akaOOt2m+FHVg@...278...>
In-Reply-To: <CAFHpkQFm3v5G-yZohqE2CFoBK7VOx9TcKttG2akaOOt2m+FHVg@...278...>
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
To: openvpn-devel@lists.sourceforge.net

On 9-4-2014 10:49, =E9=CC=D8=D1 =FB=C9=D0=C9=C3=C9=CE wrote:
> I did not say "nobind protects from everything", but I did mean that
> clients with "nobind" are more protected in case of non patched
> openssl library shipped with (old) openvpn windows installer.
>
>
> if server is patched (what is rather easy thing comparing to hundreds
> windows users), nobody can steal server ssl cert, sniffering traffic
> is useless in that case. mitm type attack is also useless when you
> have no server cert. the only thing you can attack is client, and if
> he uses "nobind", it looks rather good.
>
> 2014-04-09 14:44 GMT+06:00 Arne Schwabe <arne@...1227...>:
>> Am 09.04.14 10:32, schrieb =E9=CC=D8=D1 =FB=C9=D0=C9=C3=C9=CE:
>>> I used to think that client without "nobind" option binds to 1194/udp
>>> (we encountered that issue with multiple openvpn connection on the
>>> same machine), so, "nobind" tells openvpn instance not to bind to
>>> udp/1194, and so, only openvpn server can exploit heartbleed
>>> vulnerability, but not any attacker.
>>>
>> Yes the server can attack you. Or any man in the middle attack including
>> ARP spoofing/DNS spoofing etc.
>>
>> If you see nobind that as protection basically you don't need a VPN.
>>
>> Arne
>>
I don't see the difference between nobind and bind. As soon as you
connect to the server, a MITM attack or an attack by the server is
possible.

Adriaan

