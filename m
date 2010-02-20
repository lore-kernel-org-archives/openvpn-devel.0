Date: Fri, 19 Feb 2010 22:46:37 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B7F1AAA.5090103@...1114...> <1266637180.23846.1@...1207...>
In-Reply-To: <1266637180.23846.1@...1207...> (from kop@...1206... on Fri Feb 19
	21:39:40 2010)
Message-Id: <1266641197.32062.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
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
Cc: openvpn-devel@lists.sourceforge.net

On 02/19/2010 09:39:40 PM, Karl O. Pinc wrote:

> If someone who explicitly chooses a functionality
> needs to get a warning about the default they
> should get this warning at ./configure time --
> the time they make the choice.=20

The only time I can think of that a warning should
be delivered to those who explicitly choose
functionality in the process of deprecation
is to, _after_ the default has changed,
deliver a ./configure time warning to those
who explicitly choose the default telling them
that they no longer have to be explicit because
they are choosing what is now the default.

It hardly seems worth it.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


