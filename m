Date: Sun, 28 Feb 2010 23:14:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228221425.GT9556@...1296...>
References: <20100228150546.GO9556@...1296...>
	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>
	<4B8A8DC9.3020502@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B8A8DC9.3020502@...1114...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
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
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 28, 2010 at 04:37:45PM +0100, David Sommerseth wrote:
> On 28/02/10 16:10, Eric F Crist wrote:
> > ACK,
> > 
> > It's not you, that's duplicate code.
> 
> ACK.  I this is indeed duplicated.

Thanks.  I have committed this to my branch (because I'm too tired right 
now to get branching right) as dd66b12647852e3f1267be70b0fb3b11deedf377

David, could you please pull my branch from Berni, and move that patch
to wherever bugfixes/code cleanups go?  It should merge easily into 
all branches.

(As a side note: there is new IPv6 related code in my branch, of course,
so please pull that to feat_ipv6_payload as well :-) - mostly code cleanups,
and Win32 preparations)

thanks,

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

