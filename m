Date: Wed, 11 Nov 2009 15:15:34 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <20091110161632.GA31301@...1276...>
	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>
	<4AFA9AA7.4030600@...260...> <4AFAAD5C.4070303@...1114...>
In-Reply-To: <4AFAAD5C.4070303@...1114...> (from
	openvpn.list@...1114... on Wed Nov 11 06:26:04 2009)
Message-Id: <1257974134.24141.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
 the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, Mathieu GIANNECCHINI <mat.giann@...260...>

On 11/11/2009 06:26:04 AM, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 11/11/09 12:06, Mathieu GIANNECCHINI wrote:
> > Victor Wagner a =E9crit :

> >> But if entire certificate would be available, it would be possible
> to
> >> extract any information from it (or hash it with any algorithm)
> from the
> >> script using openssl command line utility or some binding or
> OpenSSL
> >> libraries to the choosen script language.

> Indeed!  And you're about to get my vote for this implementation ...
> but
> I have two concerns.

> 2) If an attacker sends a certificate with his certificate and 999 CA
> certificates in a chain, what will happen?  What happens if the disk
> goes full or the certificate cannot be written?

You're a lot less likely to fill the disk than you are to run out
of RAM.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


