Date: Sun, 28 Feb 2010 23:32:46 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100301042436.20377.qmail@...1287...> (from peter@...1287... on
	Sun Feb 28 22:24:36 2010)
Message-Id: <1267421566.30675.5@...1207...>
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

On 02/28/2010 10:24:36 PM, Peter Stuge wrote:
> David Sommerseth wrote:
> > +++ b/options.c
> > @@ -529,6 +529,9 @@ static const char usage_message[] =3D
> >    "                  tests of certification.  cmd should return 0
> to allow\n"
> >    "                  TLS handshake to proceed, or 1 to fail.  (cmd
> is\n"
> >    "                  executed as 'cmd certificate_depth
> X509_NAME_oneline')\n"
> > +  "--tls-export-cert [directory] : Get peer cert in PEM format and
> store it \n"
> > +  "                  in an openvpn temporary file in [directory].
> Peer cert is \n"
> > +  "                  stored before tls-verify script execution and
> deleted after.\n"
>=20
> Please update the man page too

There is no man page.  It's in sample-scripts/.

However, the openvpn(8) --tls-verify section of the man page
is poor.  I just sent another patch that clarifies it.
Perhaps this is what you're looking for?  If not then
just ignore my man page patch.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


