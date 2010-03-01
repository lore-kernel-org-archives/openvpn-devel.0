Date: Sun, 28 Feb 2010 23:52:56 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <20100301042436.20377.qmail@...1287...> <1267421566.30675.5@...1207...>
	<20100301053911.10864.qmail@...1287...>
In-Reply-To: <20100301053911.10864.qmail@...1287...> (from peter@...1287... on
	Sun Feb 28 23:39:11 2010)
Message-Id: <1267422776.30675.7@...1207...>
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
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/28/2010 11:39:11 PM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > > > +  "--tls-export-cert [directory] : Get peer cert in PEM format
> and
> >=20
> > There is no man page.  It's in sample-scripts/.
>=20
> It's a new option, right?

The sample script has a new option, yes.  But the
--tls-verify option/config file directive used
to invoke the script is unchanged.

The sample script has never had a man page.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


