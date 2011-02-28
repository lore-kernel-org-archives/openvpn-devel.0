Message-ID: <4D6B6CA2.3050002@...1147...>
Date: Mon, 28 Feb 2011 10:36:34 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTikHd0G_8-JAkXTojetsG7-w5TV3j9fdUwx309A+@mail.gmail.com>	<20110226104526.GT9835@...1296...>	<AANLkTik-vCrO=yQW7FNiUXyrXfKjNe-3Dq4aGUkHsfT5@...278...>	<20110226112534.GV9835@...1296...>
	<4D68E86D.7000203@...1114...>
In-Reply-To: <4D68E86D.7000203@...1114...>
Subject: Re: [Openvpn-devel] sctp in openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 26/02/11 12:25, Gert Doering wrote:
> | Hi,
> |
> | On Sat, Feb 26, 2011 at 11:19:19AM +0000, Olivier Van Acker wrote:
> |>> The code parts in question inside OpenVPN (socket.c) are somewhat
> |>> complicated due to lots of existing options and lots of existing
> |>> operating systems being supported, so this will not be a trivial
> |>> task.
> |>
> |> Would it be a good idea to limit the scope of this project by concentrating
> |> on one OS first? I was thinking FreeBSD first since that contains the
> |> reference implementation of SCTP.
> |
> | Well, you'd certainly start with one OS, but in the long run, you'd want
> | the mainstream OSes (Linux and Windows) as well...
>
> I second this.  SCTP is really interesting for OpenVPN in my perspective, but
> we should rather quickly after having "something which works" support other
> OSes as well.  When we reach that point, merging SCTP support into 'allmerged'
> for broader testing gets interesting.  If Linux gets support quickly, I'm able
> to test this out pretty soonish in a limited prod environment.
>
> Some practical details.  General info about the development process can be
> found here:
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>, including
> git repositories.
>
> For the git branch to look at, JJO's IPv6 transport patches is called
> feat_ipv6_transport.  *But* as soon as we manage to get the OpenVPN 2.2
> release out the door (I'm hope I'll be able to finalise the beta2.2 branch
> today for the RC release), we're going to merge stuff, including JJO's branch
> and Gert's feat_ipv6_payload branches officially and get started with the
> OpenVPN 2.3 cycle.  So what I'm saying, please base your stuff on JJO's branch
> now, but be sure your changes can be merged against the feat_ipv6_payload
> branch too.  As I'm the one going to do the merges, I'm going to be noisy if
> it doesn't go smooth ;-)
>
> And just let me state that, if someone got time to do a real overhaul of
> socket.c, that would really be beneficial.  That source file is confusing at
> best to read.  However, we do have some source documentation patches is the
> wild somewhere, waiting to go in soonish too - which I'd like to see go into
> the 2.3 cycle.  So - there's a little coordination needed to be done here with
> such an overhaul too.
>
>   
there seems to be a freely available SCTP implementation for Windows 
XP/Vista/7:
  http://www.bluestop.org/SctpDrv/

Sources for an older version of this driver are available, but I am not 
sure under what conditions/license is released.

As for adding SCTP support: if I read the 'socat' sources it should be 
dead-easy: just open the socket using the protocol IPP_SCTP4 and that's 
about it.
The real question is whether we'd want to support some of the niftier 
features that SCTP has to offer (e.g. opening multiple channels via a 
single connections).

cheers,

JJK


