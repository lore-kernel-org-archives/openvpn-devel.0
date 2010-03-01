Date: Mon, 01 Mar 2010 07:10:49 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <1267421566.30675.5@...1207...> <4B8B954C.6000600@...1114...>
In-Reply-To: <4B8B954C.6000600@...1114...> (from
	openvpn.list@...1114... on Mon Mar  1 04:22:04 2010)
Message-Id: <1267449049.30675.11@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On 03/01/2010 04:22:04 AM, David Sommerseth wrote:
> On 01/03/10 06:32, Karl O. Pinc wrote:
> > On 02/28/2010 10:24:36 PM, Peter Stuge wrote:
> >> David Sommerseth wrote:
> >>> +++ b/options.c
> >>> @@ -529,6 +529,9 @@ static const char usage_message[] =3D
> >>>    "                  tests of certification.  cmd should return=20
> 0
> >> to allow\n"
> >>>    "                  TLS handshake to proceed, or 1 to fail.=20
> (cmd
> >> is\n"
> >>>    "                  executed as 'cmd certificate_depth
> >> X509_NAME_oneline')\n"
> >>> +  "--tls-export-cert [directory] : Get peer cert in PEM format
> and
> >> store it \n"
> >>> +  "                  in an openvpn temporary file in=20
> [directory].
> >> Peer cert is \n"
> >>> +  "                  stored before tls-verify script execution
> and
> >> deleted after.\n"
> >>
> >> Please update the man page too
> >
> > There is no man page.  It's in sample-scripts/.
> >
> > However, the openvpn(8) --tls-verify section of the man page
> > is poor.  I just sent another patch that clarifies it.
> > Perhaps this is what you're looking for?  If not then
> > just ignore my man page patch.
>=20
> I don't mean to be harsh ... but this patch updates options.c and
> introduces a new argument to OpenVPN.  So I agree, Peter, a man page
> update is needed!

Whoops.  I was thinking of an entirely different patch
and have been sending multiple responses that are entirely
off-topic.  *facepalm*

I agree.  Man page update is needed.


Anyhow, having written a patch to the --tls-verify
man page patch(s) someone might want to look at it
and see if the wording is better.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


