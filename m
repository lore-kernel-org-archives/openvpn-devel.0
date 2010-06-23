Message-ID: <4C21B352.1030203@...1147...>
Date: Wed, 23 Jun 2010 09:10:10 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
	<4C20D014.7050802@...1147...>
	<AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...>
In-Reply-To: <AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to access
 Windows XP shares over port 445?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?SGVubm8gVMOkaHQ=?= <henno.taht@...277...>, OpenVPN Users <openvpn-users@lists.sourceforge.net>, openvpn-devel@lists.sourceforge.net

Hi Henno,

Henno T=C3=A4ht wrote:
> Hi
>
> 2010/6/22 Jan Just Keijser <janjust@...1147... <mailto:janjust@...1147...=
>>
>
>     Henno T=C3=A4ht wrote:
>
>         The only thing I can think of is that Windows XP explicitly
>         forbids access to port 445 as a countersecurity measure unless
>         it's coming from an "official" network card.
>
>
> That crossed my mind also.
>
>=20=20
>
>     It seems like OpenVPN is working as it should, it's just that
>     Windows XP (and Vista/7?) does not regard the tap-win32 adapter as
>     an official network card and hence does not allow access.
>
>
> I think it has something to do with the way OpenVPN configures the TAP=20
> adapter while first connecting after boot. Because when I uncheck and=20
> recheck OpenVPN adapter's "File and Printer Sharing service", port 445=20
> starts operating normally also on this adapter. But unfortunately that=20
> fortune only lasts until next computer restart.
>
>     Your best bet is to continue using netbios-over-tcpip for the time
>     being (I always disable port 445 anyways) until a Windows kernel
>     guru can tell us just what the heck is happening here (where would
>     this be logged? my XP firewall is turned off
>
>
> I cannot do that because my W2003 servers stubbornly refuse to use=20
> netbios-over-tcpip. I have triple checked that Enable NetBIOS over=20
> TCP/IP is checked and even restarted the servers but they still only=20
> try to connect to port 445. :(
I think I got it:

- change the media status on the tap-win32 adapter from 'Application=20
Controller' to 'Always Connected'
- add the lines
    dhcp-pre-release
    dhcp-renew
    dhcp-release
  to the openvpn client config file.
- Restart windows, connect to the VPN and try the share.

This worked for my WinXP SP3 installation.

The downside is that the system takes a bit longer to come up, as=20
windows tries to get a DHCP lease for the tap-win32 adapter and finally=20
assigns a 169.254 address. If this works for you as well then maybe the=20
tap-win32 developers can dive deeper into this and find out why windows=20
treats the 'always connected' adapter differently from an 'application=20
controlled' adapter .

And now that I think of it: this *might* also affect the windows=20
2003/2008 server problem that some people have reported here...

HTH,

JJK

