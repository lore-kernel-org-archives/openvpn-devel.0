From: Pavel Raiskup <praiskup@...1347...>
Date: Sun, 15 Jan 2017 14:52:53 +0100
Message-ID: <10918281.H3KHJINfQl@...2234...>
In-Reply-To: <8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
References: <20170115061718.3218-1-praiskup@...1347...>
	<8e0e7b9b-3f54-88c4-6880-a3736a3a87ea@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
	argument value
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sunday, January 15, 2017 11:08:38 AM CET David Sommerseth wrote:
> On 15/01/17 07:17, Pavel Raiskup wrote:
> > Adding a new --with-ca-bundle configure option.  It's argument is
> > used as default CA file when no --ca option is specified at
> > runtime.
> > 
> > This option is primarily designed for systems where users are
> > allowed to manage trusted authorities for whole system (in one
> > consolidated file; usually implemented in 'ca-certificates'
> > package).
> > 
> > Signed-off-by: Pavel Raiskup <praiskup@...1347...>
> > ---
> >  configure.ac          | 5 +++++
> >  src/openvpn/options.c | 9 +++++++++
> >  2 files changed, 14 insertions(+)
> 
> As this was mentioned on a Red Hat Bugzilla (bz #1413343 [1]) as well,
> I'm reiterating my argument here for closing that bugzilla as notabug.
> 
> I completely agree with Steffan, this is a NAK.  Such a feature would be
> a dreamscenario for The Great Firewall of China and similar national
> routing instances which implements complete network surveillance.  It
> would make it extremely trivial for them to implement a MITM OpenVPN
> server which would affect users not being aware of this issue.
> 
> This feature would elude users configuring OpenVPN it is no problem
> using certificates from public CA issuers.  This is a VERY BAD idea!  We
> should help users configure OpenVPN in a secure way by default.  Not the
> opposite.

Ack, I originally thought about this as tool to solve "packaging issue".
We have corporate-wide authority, and people usually have it stored in
bundle.  But I got the point, and such a shame mistake -- there's too many
trusted CAs.

Thanks for having a look!
Pavel

> 
> 
> [1] <https://bugzilla.redhat.com/show_bug.cgi?id=1413343>
> 
> 



