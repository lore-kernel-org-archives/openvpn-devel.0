From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN Licensing Issues
In-Reply-To: <20040917190341.GA5394@...85...>
Message-ID: <Pine.LNX.4.58.0409171334190.32738@...269...>
References: <twig.1095190172.87806@...41...> <20040917190341.GA5394@...85...>
MIME-Version: 1.0
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
Date: Fri Sep 17 13:21:08 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Christof Meerwald <cmeerw@...83...>
Cc: openvpn-devel@lists.sourceforge.net


On Fri, 17 Sep 2004, Christof Meerwald wrote:

> On Tue, 14 Sep 2004 19:29:33 -0000, James Yonan wrote:
> > I've been considering various ways that the OpenVPN project might become
> > financially self-sustaining.  While this has been discussed in the past, the
> > discussion usually centered around donations.  I'd like to propose and invite
> > discussion on another potential fundraising method.
> [...]
> > Being able to sell commercial licenses would bring badly needed funding into
> 
> I wonder who would be willing to buy a commercial license of OpenVPN. Unlike
> ReiserFS, OpenVPN is a standalone application and commercial vendors that
> like to distribute OpenVPN can already use the GPL licensed version (they
> only have to also offer the source code of OpenVPN).
> 
> Buying a commercial license instead of using the GPL'd version only seems to
> make sense if you want to extend OpenVPN (but don't want to share the source
> code of your extensions).

I think that the companies which are interested in buying a commercial
license see OpenVPN as being a "network security-layer and tunneling
library" of sorts that they can integrate (i.e. link) with their
own proprietary applications.

True, they could try to package it in such a way that their distribution
model complies with the GPL, but in practice that may introduce 
constraints which they don't want to deal with.

As as example, suppose a company sells VoIP services and wants to use 
OpenVPN as the security layer to tunnel through firewalls and NAT.  But 
now they realize they need to patch OpenVPN so that it integrates 
seamlessly with their authentication and billing systems.

Another example: a firm shops around for a VPN to use as a security layer
for their proprietary app.  They decide they like OpenVPN, but the board
of directors is intimidated by the GPL.  Perhaps they are concerned about
the concepts of "linkage" and what constitutes a derived work, and how
that might apply to their own IP.  Because of this uncertainty, they opt 
for a commercial license.

Overall, I'm not terribly worried about the fact that a commercial
licensee doesn't need to return source code modifications to the
community, because I believe that most of the kind of changes a commercial
licensee is likely to make is of an integration nature with other
proprietary code.

James


