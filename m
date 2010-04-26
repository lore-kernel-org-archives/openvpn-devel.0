Date: Mon, 26 Apr 2010 09:40:32 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<4BD4CCA3.5030705@...1114...>
	<201004260956.16533.dave_br@...1278...>
In-Reply-To: <201004260956.16533.dave_br@...1278...> (from dave_br@...1278... on
	Mon Apr 26 03:56:16 2010)
Message-Id: <1272292832.28330.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/26/2010 03:56:16 AM, Davide Brini wrote:
> On Monday 26 Apr 2010 00:13:39 David Sommerseth wrote:

> > > +# OCSP responder URL (mandatory)
> > > +ocsp_url=3D"http://some.ocsp.server/"
> > > +#ocsp_url=3D"https://some.secure.ocsp.server/"
> >=20
> > Wouldn't it be better to use a more valid URL?
>=20
> And what could it be? I can put in the OCSP URL of some well-known=20
> CA,
> but=20
> then if the user is using their own server, that would be meaningless
> anyway.=20
> But I'm open to suggestions.

I would suggest example.com, which would be compliant with
RFC 2606 "Reserved Top Level DNS Names".



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


