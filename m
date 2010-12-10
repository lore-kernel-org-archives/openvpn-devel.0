Message-ID: <20101210084436.7399.qmail@...1287...>
Date: Fri, 10 Dec 2010 09:44:36 +0100
From: Peter Stuge <peter@...1287...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>
	<20101210062512.17827.qmail@...1287...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EF3@...1436...>
	<4D01DD1C.5010506@...1114...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EFD@...1436...>
	<20101210081613.3086.qmail@...1287...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3F13@...1436...>
MIME-Version: 1.0
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3F13@...1436...>
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview [7/8]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Adriaan de Jong wrote:
> > I'd use git for the patches right away anyway,
> 
> I'm afraid that we started off development based on checked out
> sources (quite a long time ago). I'll start rebasing to git as soon
> as I've heard that the git tree is stable.

By git I don't mean the very latest contents of the tree, but the
tool. I would branch off the commit that corresponds to your starting
state, apply the patches, and then rebase that branch forward at some
later time.

Having the branch in git allows iterating over the commits with great
ease.

Thanks for these contributions! I think it's a significant improvement!

(I'd like to be able to reuse some of your work or at least learn
from it, for the purpose of libssh2.)


//Peter

