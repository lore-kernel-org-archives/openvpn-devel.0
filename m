References: <20161108124506.32559-1-gert@...1296...>
	<201611092014.uA9KErZf048132@...2054...>
	<8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
	<20161111221004.GC28918@...1296...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <b998265c-5220-d5ce-596c-fe400a422de2@...68...>
Date: Sat, 12 Nov 2016 05:43:56 +0100
MIME-Version: 1.0
In-Reply-To: <20161111221004.GC28918@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Repair topology subnet on
 FreeBSD 11
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 11.11.2016 um 23:10 schrieb Gert Doering:
> I might be tempted to do a quick 2.3.14 release in between - there's two
> important platform fixes in that branch now (FreeBSD and OpenBSD topology
> subnet :-) ) and Lev's recursive routing patch.  Add to that the windows
> block-outside-dns patch that I hope to be testing this weekend, and it's
> worth a minor bugfix release...  at least "before January".

Well, for me to update the FreeBSD port, mid December 2016 would be cool
for anything (2.3.14, or 2.4.0, or both) due to the before-xmas-madness
and to have like two weeks for smoke testing.

On the other hand, we're not Debian or Ubuntu, and the FreeBSD
ports-secteam (who own the stable "quarterly" ports branch) take a
rather pragmatic or management approach than drive their principles and
policies home...

Also, since the FreeBSD stable ports branches follow a
three-months-lifetime scheme, anything we miss in December will go in in
April 2017 rather than January, and it's also easy enough to update
OpenVPN to the ports HEAD branch if needed ahead of time by some user.
While not formally supported, it works for OpenVPN.

Bottom line, give Debian the priority, and while it would be nice to
have for FreeBSD, no need to rush.



