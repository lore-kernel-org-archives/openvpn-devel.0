Date: Fri, 19 Feb 2010 15:56:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100219145623.GU9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B7EA05C.5000802@...1114...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
	openvpn-testing tree available)
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

On Fri, Feb 19, 2010 at 03:29:48PM +0100, David Sommerseth wrote:
> I'm fine with whichever path you choose.  But just bear in mind, some
> systems might not have IPv6 support - which breaks portability ... 

On the unixish side, there is no system which has tun/tap today but
does not have IPv6.

On Windows, this might indeed be a killer argument to do some #idef'ing
- what's the oldest version of Windows officially supported by OpenVPN?

(XP and up has IPv6, everything before that does not)

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

