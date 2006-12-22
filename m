Message-ID: <1e6368e80612211726p6d6c88aep5e7c996fe8a7495e@...278...>
Date: Thu, 21 Dec 2006 20:26:22 -0500
From: "Leonard Isham" <leonard.isham@...277...>
In-Reply-To: <200612202344.11798.rob0@...446...>
MIME-Version: 1.0
References: <008701c72471$6f6d58d0$4e480a70$@com>
	<200612202344.11798.rob0@...446...>
Subject: Re: [Openvpn-devel] [Openvpn-users]  Potentially Obscure Bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On 12/21/06, /dev/rob0 <rob0@...446...> wrote:
> [ Crossposted: this address might not be on Openvpn-devel ]
>
> On Wednesday 20 December 2006 14:00, Stephen Gerstacker wrote:
> > I apologize ahead of time, but I've posted this multiple times on the
> > OpenVPN-Users list as well as the forum and no one has said a word to
> > me about fixing my problem.
>
> FWIW I doubt this has anything at all to do with openvpn directly. You
> described a VPN working perfectly, with at least two IP protocols. This
> is almost certainly a Windows issue. I don't support Microsoft, so I
> didn't reply.
>
> > I'm getting desperate and I'm going
> > insane because of this problem.
>
> Come back with hard evidence that openvpn is somehow causing this
> problem. Otherwise, check your SMB/CIFS configuration. At no extra
> charge I'll throw out a WAG: you're using domain authentication, and
> Windows clients not onsite are giving the wrong (or no) domain for
> authentication. As Charles suggested, a packet sniffer will show it.

I have to agree this is a Windows issue not OpenVPN.  if it was
OpenVPN specific there would be a large number of reports on the
mailing list.  Just because you can reach a device via IP doesn't mean
that the Windows configuration is correct.

-- 
Leonard Isham, CISSP
Ostendo non ostento.

