Message-ID: <20100121181958.14600.qmail@...1287...>
Date: Thu, 21 Jan 2010 19:19:58 +0100
From: Peter Stuge <peter@...1287...>
References: <4B570C63.1050808@...515...>
	<20100120193247.GL857@...1296...>
MIME-Version: 1.0
In-Reply-To: <20100120193247.GL857@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN core development processes?
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
To: openvpn-devel@lists.sourceforge.net

Gert Doering wrote:
> The nice thing about git is that people can very easily do
> "experimental branches" in their own repository, giving access to
> testers, without having to have write access to SVN.

Agree, but the hosting issue aside this is possible also from an SVN
repo thanks to the git svn support. Try:

git svn clone http://svn.openvpn.net/projects/openvpn/trunk/openvpn

(You may want to create and use a gitauthors file for best results.)


//Peter

