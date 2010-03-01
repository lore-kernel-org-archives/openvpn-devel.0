Date: Mon, 1 Mar 2010 11:58:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100301105856.GY9556@...1296...>
References: <4B8ADF36.3050201@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B8ADF36.3050201@...1114...>
Subject: Re: [Openvpn-devel]
	=?iso-8859-1?q?=5BFeedback_needed=5D=A0Fix_cross_?=
	=?iso-8859-1?q?compile_support?=
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 28, 2010 at 10:25:10PM +0100, David Sommerseth wrote:
> I'm reviewing this patch in the patch tracker, and cannot make up my
> mind if this is correct or not.  Can someone please advise if this is
> something we should include or not?
> 
> <https://sourceforge.net/tracker/?func=detail&aid=2491190&group_id=48978&atid=454721>

I don't really understand the subtleties of autoconf and friends, but
I can attest that the current source tree cross-compiles just fine
(e.g. "configure --prefix=/usr --host=armv5tel-unknown-linux-gnueabi").

Something to keep in mind: changing all TARGET_* #ifdef's in the actual
code (as opposed to just changing the configure magic) *will* generate
lots of merge problems with the new feature branches.  Especially the
IPv6 payload branch has lots of system dependent changes, so this part
of the change would have to be done in parallel on multiple branches,
causing the payload branch then to no longer apply to "base 2.1.1".


For this reason, I would NOT apply this patch right now - wait for the
development tree to stabilize, before applying a mostly-religious change
that affects 58 (!) places in the source.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

