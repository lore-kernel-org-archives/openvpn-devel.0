MIME-Version: 1.0
References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
In-Reply-To: <20200621111403.GP1431@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 21 Jun 2020 10:03:54 -0400
Message-ID: <CAEsd45QLKNA7eO_tkeyHqdXDroGqmopWKh9PGrArX_LH7xiQew@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Selva Nair <selva.nair@...277...>

Hi!

On Sun, Jun 21, 2020 at 7:15 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> going through OpenVPN threads that went stale - I think this is
> actually a nice addition (read: other people have already asked
> me if this can be done).
>
> On Thu, Mar 05, 2020 at 01:53:12PM +0100, Jan Just Keijser wrote:
> > So, for what it's worth, I've dusted off the patch again and rebased it
> > to the current openvpn master tree. See attached. Note that I did only
> > rudimentary testing, as I don't use Windows 10 a lot and I was testing
> > using a mingw cross-compile only. In wireshark I *do* see that the
> > correct DHCP offer is sent to the tap-win adapter.
> >
> > Also note that I implemented multiple search domains by separating them
> > using semi-colons, e.g.
> >
> >     --dhcp-option SEARCH example.com;example.org;example.nl;example.de
> >
> > etc as that was easier to implement
>
> The patch looks okay-ish on quick reading.
>
> > Also note that I did not fully implement the RFC3397 encoding of the
> > search list, as that requires one to merge domain names that occur more
> > than once - that would have made the code far more complicated.
>
> Indeed.  I haven't looked at what other DHCP implementations do, but
> "correct" encoding definitly sounds like quite a bit of extra code just
> to save a few bytes on the wire - might come handy if you have many
> subdomains of a long internal DNS domain, though, but this can be
> added "if needed".
>
>
> More interesting is the question "which option to use" - it should
> be synchronized between openvpn platform handlers.  So if systemd-networkd
> uses "SEARCH-DOMAIN" it would make sense to use that for windows
> as well.
>
> Is there an option in Tunnelblick to set MacOS DNS and search list?  If
> yes, what option do they use?

I apologize for not noticing this earlier. Two points to consider:

1. Tunnelblick does not accept "--dhcp-option SEARCH". Tunnelblick
accepted DOMAIN-SEARCH starting in 2013, but users kept trying to use
SEARCH-DOMAIN and then complaining when it didn't work, so in 2017
Tunnelblick started accepting also SEARCH-DOMAIN. If Windows starts
using "SEARCH" I suppose we can add that, too. (**Sigh**.)

2. As is the case with using --dhcp-option to set DNS and WINS
servers, Tunnelblick was designed to accept only one search domain per
option, so one would use "--dhcp-option SEARCH-DOMAIN example.com
--dhcp-option SEARCH-DOMAIN example.org --dhcp-option SEARCH-DOMAIN
example.de" to set those three search domains. Our "up" script accepts
multiple $foreign_option_X options and constructs appropriate
instructions to have macOS use all of them. Parsing multiple search
domains contained in one $foreign_option_X could be added but I'd
rather avoid that if possible. (We'd probably have to do that if
Windows does it. **Sigh**, again.)


 > Does anyone know about commercial VPN providers basing their clients
> on OpenVPN?

I don't think commercial VPN providers would use search domains. I
think search domains would be used more by universities, corporations,
etc. that want an easy way for their users to access their internal
servers.

