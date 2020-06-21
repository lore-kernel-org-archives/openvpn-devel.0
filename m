MIME-Version: 1.0
References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
In-Reply-To: <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 21 Jun 2020 12:23:55 -0400
Message-ID: <CAEsd45TRKrn945bvQu11fxiUR1ORfcmWvqaQ3tBiPeiW-=UHgg@...278...>
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
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jun 21, 2020 at 11:15 AM Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> On Sun, Jun 21, 2020 at 7:14 AM Gert Doering <gert@...1296...> wrote:
> >
> > Hi,
> >
> > going through OpenVPN threads that went stale - I think this is
> > actually a nice addition (read: other people have already asked
> > me if this can be done).
> >
> > On Thu, Mar 05, 2020 at 01:53:12PM +0100, Jan Just Keijser wrote:
> > > So, for what it's worth, I've dusted off the patch again and rebased =
it
> > > to the current openvpn master tree. See attached. Note that I did only
> > > rudimentary testing, as I don't use Windows 10 a lot and I was testing
> > > using a mingw cross-compile only. In wireshark I *do* see that the
> > > correct DHCP offer is sent to the tap-win adapter.
> > >
> > > Also note that I implemented multiple search domains by separating th=
em
> > > using semi-colons, e.g.
> > >
> > >     --dhcp-option SEARCH example.com;example.org;example.nl;example.de
> > >
> > > etc as that was easier to implement
> >
> > The patch looks okay-ish on quick reading.
>
> Feature wise yes, but some improvements needed..
>
> I do not like that option format
>
> "example.com; example.org" with quotes will parse right and fail later
> on because of the space, for example. And, we support multiple
> statements of dhcp options like DNS, so this is counter-intuitive.
> It's only a little more work to support a more forgiving format.
>
> >
> > > Also note that I did not fully implement the RFC3397 encoding of the
> > > search list, as that requires one to merge domain names that occur mo=
re
> > > than once - that would have made the code far more complicated.
> >
> > Indeed.  I haven't looked at what other DHCP implementations do, but
> > "correct" encoding definitely sounds like quite a bit of extra code just
> > to save a few bytes on the wire - might come handy if you have many
> > subdomains of a long internal DNS domain, though, but this can be
> > added "if needed".
>
> Same as my thoughts, the encoding part could be kept simple as in here
> and possibly improved later. But option format is hard to change or
> deprecate.

I agree.


> > More interesting is the question "which option to use" - it should
> > be synchronized between openvpn platform handlers.  So if systemd-netwo=
rkd
> > uses "SEARCH-DOMAIN" it would make sense to use that for windows
> > as well.
>
> I think we need both --- the current one retained as the connection
> specific suffix which would be just one entry and then this search
> list. As we allow multiple entries for DOMAIN right now, a user
> friendly approach would be to continue doing so but internally treat
> all but the first as a part of --dhcp-option DOMAIN-SEARCH. We could
> also deprecate the use of multiple entries in the dhcp-option DOMAIN
> keyword.

The man page says to use "DOMAIN" to set the"domain suffix", but there
is no documented way to specify the computer's domain. The man page
doesn't indicate that multiple --dhcp-option DOMAIN options are
allowed, but it specifically states that multiple DNS and WINS are
allowed (for example, "Repeat this option to set secondary DNS server
addresses").

(Note that bad formatting on the online version of the man page [1]
makes it hard to see that "DOMAIN" is allowed at all, since it is
merged into the prior paragraph. Also note that the opening paragraph
for the --dhcp-option section of the man page implies it is only for
Windows tap adaptors, which hasn't been true for at least 11 years!)

For many years, Tunnelblick has
 1. Accepted multiple SEARCH-DOMAIN or DOMAIN-SEARCH entries to set
the search domains, which is in keeping with the way multiple DNS and
WINS entries are interpreted.
 2. Ignored all but the last "--dhcp-option DOMAIN=E2=80=A6" entry in $fore=
ign_option_X.
 3. Used that last entry to set the computer's domain.
 4. Under certain conditions, prepended the search domains with that last e=
ntry.

Best regards,

Jon Bullard

[1] https://openvpn.net/community-resources/reference-manual-for-openvpn-2-=
4/#

