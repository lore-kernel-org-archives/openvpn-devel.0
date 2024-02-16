Date: Fri, 16 Feb 2024 15:20:25 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zc9vKS0P2eUMswyM@...2685...>
References: <Zczam85nBDgD74kE@...2685...>
 <kiuEvfPhyMr8TQIYBbooBK7BOnaHm4Bi18X2pO0ujjEIrGEPSONav0DnpYy97JLoHgDW5vfjaD4amWbxlodG75qHQqtzjjAfFzRci4gbCh4=@protonmail.com>
MIME-Version: 1.0
In-Reply-To: <kiuEvfPhyMr8TQIYBbooBK7BOnaHm4Bi18X2pO0ujjEIrGEPSONav0DnpYy97JLoHgDW5vfjaD4amWbxlodG75qHQqtzjjAfFzRci4gbCh4=@protonmail.com>
Subject: Re: [Openvpn-devel] IRC community meeting summary (Feb 14th)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Feb 14, 2024 at 05:18:21PM +0000, tincantech wrote:
> On Wednesday, 14 February 2024 at 15:22, Frank Lichtenheld <frank@...2641...> wrote:
> 
> > Meeting summary for 14 February 2024:
> 
> <snip>
> 
> > * New: Easy-rsa in Windows installers
> > easy-rsa has included pre-built Windows binaries for a long time. But with
> > Windows 11 they do not seem to work correctly anymore in some cases.
> 
> Just to clarify:
> Easy-RSA works perfectly as-is on W10 & W11 but requires Windows Admin access.
> Without Windows Admin Access, Easy-RSA on W11 does not work with the now 10 year
> old MKSH:sh.exe

Either way, I think everyone agrees that the current situation of
shipping a ten-year old executable that causes some problems on
the latest version of Windows isn't ideal.

> This is annoying but it isn't a complete deal-breaker.

Understood.

The question about removing easy-rsa isn't so much about whether it is
unusable in the current release. But we do not want to leave it in the
current state.

So, if we need to invest time and effort now anyway to update this to
a modern standard (e.g. in terms of supply chain security), we want to
use the opportunity to ask ourselves whether bundling easy-rsa with
openvpn actually provides a value for the openvpn project and its
users. It definitely has a cost. Most openvpn developers do not see a
corresponding value in it (or they did not mention it so far). When
using openvpn as a client, easy-rsa is not useful. If setting up a
p2p connection, peer fingerprint can be used which requires openssl
but not easy-rsa.

So are there people that actually use openvpn as a server on Windows
and do not have their own separate PKI and so use the bundled
easy-rsa? That is something we would like to learn more about.

Note that none of this negates the usefulness of easy-rsa. This
is specifically about the usefulness of easy-rsa bundled in the
openvpn Windows installer.

Regards,
-- 
  Frank Lichtenheld

