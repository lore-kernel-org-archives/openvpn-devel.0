From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN samples and rpm requirements - subpackage?
In-Reply-To: <200412141748.01332@...187...>
Message-ID: <Pine.LNX.4.58.0412150511100.29338@...41...>
References: <200412141748.01332@...187...>
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
Date: Wed Dec 15 04:17:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Doncho N. Gunchev" <mr700@...184...>
Cc: openvpn-devel@lists.sourceforge.net

>     Also, for Fedora/Red Hat the right group is not Networking/Tunnels
> but maybe Applications/Internet (/usr/share/doc/rpm-*/GROUPS is refered
> as source for groups in fedora), but this is not a big problem... Maybe
> I'm too pedantic and there's another %if is not needed?

Applications/Internet looks like the best match on SuSE as well.  I'd 
rather be consistent across distros if possible, and therefore not use 
another %if.

James

