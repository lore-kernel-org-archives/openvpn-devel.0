Date: Wed, 23 Jun 2010 21:48:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100623194825.GA361@...1296...>
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
	<4C20D014.7050802@...1147...>
	<AANLkTim766amj5ebXyzKWKKqjk2ndJiqyu-Drw26Mt1e@...278...>
	<4C21B352.1030203@...1147...>
Mime-Version: 1.0
In-Reply-To: <4C21B352.1030203@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to access
	Windows XP shares over port 445?
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net, Henno =?iso-8859-1?Q?T=E4ht?= <henno.taht@...277...>, OpenVPN Users <openvpn-users@lists.sourceforge.net>

Hi,

On Wed, Jun 23, 2010 at 09:10:10AM +0200, Jan Just Keijser wrote:
> assigns a 169.254 address. If this works for you as well then maybe the 
> tap-win32 developers can dive deeper into this and find out why windows 
> treats the 'always connected' adapter differently from an 'application 
> controlled' adapter .

I'd assume that windows services are not "bound" to "dynamic" interfaces...

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

