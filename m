Date: Mon, 01 Mar 2010 06:45:15 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <20100301042436.20377.qmail@...1287...> <1267421566.30675.5@...1207...>
	<20100301053911.10864.qmail@...1287...> <1267422776.30675.7@...1207...>
In-Reply-To: <1267422776.30675.7@...1207...> (from kop@...1206... on Sun Feb 28
	23:52:56 2010)
Message-Id: <1267447515.30675.8@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] enhance tls-verify possibility
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On 02/28/2010 11:52:56 PM, Karl O. Pinc wrote:
> On 02/28/2010 11:39:11 PM, Peter Stuge wrote:
> > Karl O. Pinc wrote:
> > > > > +  "--tls-export-cert [directory] : Get peer cert in PEM
> format
> > and
> > >=20
> > > There is no man page.  It's in sample-scripts/.
> >=20
> > It's a new option, right?
>=20
> The sample script has a new option, yes.=20

Come to think of it, this is wrong.  I changed
the meaning of an existing (positional) argument.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


