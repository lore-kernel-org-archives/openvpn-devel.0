Message-ID: <4433F61D.3060006@...602...>
From: Michael Kaufmann <michael@...602...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Maybe a bug using password protected private
 keys
References: <4433E342.3060103@...602...>
In-Reply-To: <4433E342.3060103@...602...>
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
Date: Wed Apr  5 09:39:01 2006
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Kaufmann <michael@...602...>
Cc: openvpn-devel@lists.sourceforge.net

Hi again,

It seems like OpenVPN simly ignores =E4=F6=FC & Co. I can add them at the e=
nd
of a "normal" Password and it's still valid.

Bye,
    Michael

Michael Kaufmann wrote:
> Hi,
>
> I'm currently testing some cases for password input and how passwords
> could look like. I use the management interface to do so.
>
> Two cases went wrong:
> 1. Input a password with german umlaute, e.g.
> password "Private Key" "=E4=F6=FC=DF"
> 2. Input empty password
> password "Private Key" ""
> 3. Input "normal" password works as expected.
>
> In both cases OpenVPN is in the "Connecting" state, but nothing else
> happens. Management Interface is otherwise still working as expected.
>
>  =20
>> INFO:OpenVPN Management Interface Version 1 -- type 'help' for more info
>> HOLD:Waiting for hold release
>>    =20
> hold release
> SUCCESS: hold release succeeded
>  =20
>> PASSWORD:Need 'Private Key' password
>>    =20
> password "Private Key" ""
> SUCCESS: 'Private Key' password entered, but not yet verified
>
> This appears in the syslog:
>
> Apr  5 17:21:13 [openvpn] PO_WAIT[0,0] fd=3D4 rev=3D0x00000001
> rwflags=3D0x0001 arg=3D0x00000000
> Apr  5 17:21:13 [openvpn] MANAGEMENT: Client connected from 127.0.0.1:111=
95
> Apr  5 17:21:13 [openvpn] PO_CTL rwflags=3D0x0001 ev=3D5 arg=3D0x00000000
>                 - Last output repeated 8 times -
> Apr  5 17:21:21 [openvpn] PO_WAIT[0,0] fd=3D5 rev=3D0x00000001
> rwflags=3D0x0001 arg=3D0x00000000
> Apr  5 17:21:21 [openvpn] MANAGEMENT: CMD 'password [...]'
> Apr  5 17:21:21 [openvpn] PO_CTL rwflags=3D0x0001 ev=3D5 arg=3D0x00000000
>                 - Last output repeated 39 times -
> Apr  5 17:22:01 [cron] (root) CMD (/usr/local/sbin/copytorrent.sh)
> Apr  5 17:22:01 [openvpn] PO_CTL rwflags=3D0x0001 ev=3D5 arg=3D0x00000000
>                 - Last output repeated 59 times -
> Apr  5 17:23:01 [cron] (root) CMD (/usr/local/sbin/copytorrent.sh)
> Apr  5 17:23:02 [openvpn] PO_CTL rwflags=3D0x0001 ev=3D5 arg=3D0x00000000
>
>
> I don't know if I do something wrong - may be. How can I work around
> this problem? Is it a bug? I use openvpn-2.0.5/2.0.6 compiled with
> gcc-4.1.0.
>
> Bye,
>     Michael
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>  =20


