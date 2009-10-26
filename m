Date: Mon, 26 Oct 2009 09:58:41 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4AE35940.9060604@...41...> (from jim@...41... on Sat Oct 24
	14:45:04 2009)
Message-Id: <1256569121.5662.4@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] FQDN for routes should expand to all IPs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/24/2009 02:45:04 PM, James Yonan wrote:

> Having said that, your bug report seems more like a feature request=20
> since routing commands/APIs generally do not support DNS A-record=20
> expansion as a standard feature.

My favorite firewall/packet redirector, pf, does.  (It runs on the
BSDS.)  I find that using DNS names makes configuration files
very, very, much more readable.

Of course care is required to ensure that the names
will resolve whenever required.  The basic trick is to run
a slave nameserver for those zones you care about on the
firewall/router, be sure that the slave server expiration=20
is "long enough", and never use dns names that are not
resolvable by the local namserver.   So long as your
nameserver is working you have config files that are
human readable -- a trade off I find well worth it.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


