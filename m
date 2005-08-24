From: James Yonan <jim@...41...>
In-Reply-To: <20050817171707.GA39058@...440...>
Message-ID: <Pine.LNX.4.58.0508240336520.28422@...41...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...> <ddtt8m$41j$1@...165...>
 <Pine.LNX.4.58.0508170649000.15439@...41...> <20050817171707.GA39058@...440...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: portable pkitool shell script [was OpenVPN 2.0.1 released --
 note security fixes]
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
Date: Wed Aug 24 02:41:03 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Johnny C. Lam" <jlam@...438...>
Cc: openvpn-devel@lists.sourceforge.net


On Wed, 17 Aug 2005, Johnny C. Lam wrote:

> On Wed, Aug 17, 2005 at 06:52:50AM -0600, James Yonan wrote:
> > On Tue, 16 Aug 2005, Johnny Lam wrote:
> > 
> > > James Yonan wrote:
> > > >
> > > > * Added easy-rsa 2.0 scripts to the tarball in easy-rsa/2.0
> > > 
> > > I am maintaining OpenVPN in the NetBSD Packages Collection and was in 
> > > the process of updating our package to 2.0.1 when I noticed that the 
> > > pkitool script uses bash.  If I provide them, will patches be accepted 
> > > into the OpenVPN sources to use Bourne shell syntax instead so as to 
> > > relax the requirement on bash?
> > 
> > Yes, that's probably okay.  Hopefully we can get bash/sh portability 
> > without complexifying the code too much.
> 
> I've attached a patch that does the following things:
> 
>     (1) Bourne shell fix: function foo {...}  ->  foo() {...}
> 
>     (2) Bourne shell fix: avoid use of bash's substring selection
> 	${foo:M:N} by replacing with an equivalent options-processing
> 	loop.
> 
>     (3) Solaris /bin/sh fix: don't set and export in one command;
> 	rather, export all the variables after setting them.
> 
>     (4) Solaris /bin/sh fix: "if ! cmd ; then ... fi" isn't understood,
> 	so change it to "if cmd; then :; else ... fi".
> 
>     (5) Don't require GNU grep -- -E isn't needed since we're matching
> 	a basic RE, and -q can be avoided by attaching stdout to
> 	/dev/null.
> 
>     (6) Use GREP and OPENSSL variables instead of "grep" and "openssl"
> 	so that it's easier to hard-code the full paths to the two
> 	utilities in the pkitool script by setting them at the top of
> 	the script.
> 
> I've tested this script on both NetBSD 2.0.2 and Solaris 8.

Thanks, I've merged your patch with 2.0.2-rc1.

James

