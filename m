From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN source repository migrated to svn
 (subversion)
In-Reply-To: <20050927230203.GA30828@...33...>
Message-ID: <Pine.LNX.4.58.0509272203290.25922@...41...>
References: <Pine.LNX.4.58.0509262203120.25922@...41...> <dhbevm$sk9$1@...165...>
 <20050927230203.GA30828@...33...>
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
Date: Tue Sep 27 21:16:45 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 28 Sep 2005, Matthias Andree wrote:

> I have worked quite a bit with Berkeley DB (which SVN set off with as
> its database backend) in bogofilter, and while lots of things are to be
> said about BDB robustness and corruptions, the most important point of
> criticism is that one needs to take BDB by the hand and guide it, and it
> doesn't tolerate application bugs that cause BDB to be used improperly.
> If used properly, it's fast and solid - but then you've entered the
> realm of transactions, and they're as awful to hack as GTK+ or assembly
> language - it's all raw and low-level.

True, but SVN supports different repository formats, and BDB is just one
option (and rather deprecated at this point).  I'm using an FSFS
repository, which gets away from nearly all of the disadvantages of BDB.

James


