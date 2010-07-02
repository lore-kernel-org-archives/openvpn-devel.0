Message-ID: <4C2E6D0B.8060407@...1147...>
Date: Sat, 03 Jul 2010 00:49:47 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTima8VCnIP08BwlXrwvbtZRcRM-ZLeOM6FPty5Jc@...278...>
	<4C2E2652.8000607@...1114...>
	<AANLkTintkNT0hY8cRHz-MEbfAFdd25mfMNOH-r3FTbE0@...278...>
In-Reply-To: <AANLkTintkNT0hY8cRHz-MEbfAFdd25mfMNOH-r3FTbE0@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN server listening both
 on udp and tcp?
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
To: =?UTF-8?B?SGVubm8gVMOkaHQ=?= <henno.taht@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi Henno,

Henno T=C3=A4ht wrote:
> Hello!
>
> 2010/7/2 David Sommerseth <openvpn.list@...1114...=20
> <mailto:openvpn.list@...1114...>>
>
>     On 02/07/10 19:38, Henno T=C3=A4ht wrote:
>     > Hello!
>     >
>     > Can anyone experienced and helpful scribble a little guide how
>     to have
>     > the same OpenVPN server listening both on 1194 UDP (reason: fast,
>     > preferable) and 443 TCP (reason: always works, fallback)?
>
>     That is not possible.  OpenVPN can only listen to TCP or UDP, not
>     both.
>      To do this, you will need two independent OpenVPN configurations and
>     run two separate OpenVPN daemons
>
>     Having that said, this is a common question and a feature which is
>     under
>     evaluation for the next generation OpenVPN.
>
>
> Great news!
>
> A client config file should also support this. Something like this:
> remote 198.51.100.15:1194 <http://198.51.100.15:1194> proto udp wait 10
> remote 203.0.113.234:443 <http://203.0.113.234:443> proto tcp  wait 1
> remote 192.168.0.1:8080->203.0.113.234:443 <http://203.0.113.234:443>=20
> proto tcp wait 1
>
> Explanation:
> First try direct connection to udp port 1194, wait 10 seconds (should=20
> be enough to survive OpenVPN server restarts after config change).
> If that fails (timeout of 10 seconds is past and no answer), try=20
> another ip with tcp 443 and wait 1 second for reply (443 tcp is=20
> usually left open for https).
> If that too fails, assume that the user is again visiting NSA-like=20
> institution but which luckily has a local proxy (which allows only for=20
> tcp port 80 and 443 connections for that matter).
>
> This is just some thoughts of me how OpenVPN should treat the --remote=20
> option in the future.=20
> I'm hoping that someone picks this up to start a discussion.
the client side already supports this (with a drawback): if you read the=20
openvpn 2.1 manual page , section 'connection profiles' you'll see

<connection>
  remote host:1194
  proto udp
</connection>

<connection>
  remote host:443
  proto tcp
</connection>

<connection>
  remote host:443
  proto tcp
  http-proxy host:port
</connection>

etc. The drawback is that  you can no longer tweak some settings , such=20
as fragment/tcp timeouts etc. This is an open bug which hopefully will=20
be addressed in openvpn 2.2 ; the redesign of openvpn to allow multiple=20
listeners on the server side is further off.

HTH,

JJK



