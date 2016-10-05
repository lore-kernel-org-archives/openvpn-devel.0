From: Daniel Hunsaker <dan@...515...>
Date: Wed, 5 Oct 2016 19:03:13 +0000
Message-ID: <1475694192252.9683@...515...>
References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
	<842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
	<20161005123444.GS78279@...1296...>
	<CAGyAFMUvHvgFTH4=M2OrcpnZFKuXq3r6Rb4DcL4KHXS353wcGg@...278...>
	<b27f550d-4bd1-1362-897e-1f10a4a6b576@...2080...>
	<CAA1AbxLU2_qqatxncB=ksJsUq8xFOpZraQsbzxNapk9uyjoWdw@...278...>,
	<7af55196-b32a-4bca-7a07-982de94fe49a@...2080...>
In-Reply-To: <7af55196-b32a-4bca-7a07-982de94fe49a@...2080...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2.3] Fix compilation in pedantic mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wednesday, October 5, 2016 12:43, David Sommerseth wrote:
    On 05/10/16 20:34, Steffan Karger wrote:
    > On 5 October 2016 at 20:25, David Sommerseth
    > <openvpn@...2080...> wrote:
    >> The Hackathon in Munich 2014 [1] decided on the the Allmann style
    >> [2]. The only thing I'm not sure we agreed upon is the indent
    >> size (4 or 8 spaces), in addition to the line length which is not
    >> that explicitly agreed upon.
    >
    > I seem to remember we agreed on 4 spaces.  (8 would really not
    > work with the current code and a 80-chars-per-line limit.)
=20=20=20=20
    Fair point!  I remember we discussed both, but as we never truly
    documented any result here I have forgotten it.  And it is aligned
    what Gert claims too.

Also, 8 spaces is a terrible idea anyway.  Even the most ancient printing p=
resses (after indentation was initially used) only went as far as (the equi=
valent of) 5 - and their fonts were proportional.

That said, I will always prefer \t over \x20*.

Daniel Hunsaker
QA / Automation
OpenVPN Technologies, Inc

irc://irc.freenode.net: danhunsaker
