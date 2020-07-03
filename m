MIME-Version: 1.0
References: <c4628c37-0c3b-a402-ee9d-68ee7062e1f3@...2080...>
In-Reply-To: <c4628c37-0c3b-a402-ee9d-68ee7062e1f3@...2080...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 3 Jul 2020 06:47:03 -0400
Message-ID: <CAEsd45QSuFgHU7WD2+W7HgckRSiPMmPOHvQnVWdmCkteCPY1Qw@...278...>
Subject: Re: [Openvpn-devel] [RFC] Challenges with OpenVPN and configuring
 DNS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn@...2080...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Jonathan Wright <jon@...2563...>, Arne Schwabe <arne@...515...>

Hi. There's a lot here and I haven't digested all of it, but have a
couple of comments about macOS and Tunnelblick, below.

On Tue, Jun 23, 2020 at 6:57 PM David Sommerseth
<openvpn@...2080...> wrote:
>
>
> Hi,
>
> Arne and I have discussed the challenge of DNS configuration and we have =
paid
> attention to a recent discussion here on the mailing list as well [1].  We
> have tried to consider various platforms and have a few proposals for uni=
fying
> and documenting DNS configuration as much as possible.
>
> [1]
> <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1951=
2.html>
>     Message-Id: <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
>
>
> DNS configuration has become fairly advanced in the later OS releases,
> compared to the traditional "send all requests to this DNS server" we're
> all very well used to.
>
> Scenarios we have considered:
>
>  * Exclusive DNS resolver
>    All DNS lookup requests should go to a specified DNS server regardless
>    of the host configuration prior to the VPN connection.
>
>  * Split-DNS
>    Only selected "route domains" should use the provided DNS server
>
>  * Windows has it's own DOMAIN setting which may impact how it handles
>    DNS and NetBios configurations
>
>  * Some platforms differentiates between "search domains" (which is the
>    typical 'search' option in /etc/resolv.conf)  and "route domains" (whi=
ch
>    domains should use a specific DNS resolver)

Tunnelblick implements "search domains" by setting a list of macOS
"SearchDomains". It isn't well documented, but as I understand it, a
name that doesn't resolve is suffixed with the first "search domain"
in the list and the result is looked up. If that doesn't resolve, the
name is suffixed with the next "search domain" in the list, and the
process is repeated. Is that what "the typical 'search' option in
/etc/resolv.conf" does?

Currently Tunnelblick on macOS does not implement "route domains" =E2=80=94
but they are "on my list".


<snip>
> For platform implementations we have considered the following:
>
> * macOS
>   Tunnelblick uses external scripts which are well tested and seems to
>   work fine.  Will it make sense to implement native DNS configuration
>   support into OpenVPN on macOS?  This might mean we need to link OpenVPN
>   against some Objective-C code to communicate directly with the network
>   configuration APIs.  It could also be possible to implement this as an
>   external plug-in, which extends OpenVPN's current behavior.

Building support for macOS network changes into OpenVPN would be a
challenge to maintain.

The combination of

 * Supporting Apple's annual release of a new version of macOS which
often changes the way changes to the network setup are done (probably
four times in the past ten years); and

 * Apple's terrible or nonexistent documentation; and

 * Supporting multiple versions of macOS that each use a different mechanism

means there's a lot of work to do. (I know, because I'm doing it : )

That said, it would be cleaner/nicer to implement it within OpenVPN or
as a plug-in, instead of having it happen in the "up", "down", and
"reconnect" scripts. I can't commit to being involved in working on
that, though I might provide comments or advice occasionally.

(As an aside, Apple tends to throw away stuff that works in favor of
new, shiny stuff and they do that all the time. They've been pushing
developers to use Swift, not Objective-C for a while now. Tunnelblick
has stuck with Objective-C, but it isn't clear how long Apple will
keep supporting it.  Even so, I agree that code for macOS is
integrated into OpenVPN, the code should be written in Objective-C.)

Best regards,

Jon

