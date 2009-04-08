Date: Wed, 08 Apr 2009 10:10:09 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239152310l.18482l.7l@...1207...>
In-Reply-To: <1239152310l.18482l.7l@...1207...> (from kop@...1206... on Tue Apr  7
	19:58:30 2009)
Message-Id: <1239203409l.18482l.12l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net


On 04/07/2009 07:58:30 PM, Karl O. Pinc wrote:
>=20
> One issue is that cryptoapi.c works around a
> problem where CryptAcquireCertificatePrivateKey
> is missing from MinGW.  However, I've installed
> the latest stable MinGW, 5.1.4, and the function
> is now in MinGW.  So, I tried commenting out the
> #ifdef __MINGW32_VERSION hacks in cryptoapi.c.
> This seems to have worked.  (So far)

FYI, it does work.

FWIW, I'm thinking myself through the problem and
it occurs to me that the right way to do this
is somewhere in the autoconf related tools.
That way you can test and set a different
variable than __MINGW32_VERSION for the
#ifdefs to use, based on the value of __MINGW32_VERSION
and when the needed components were added.

I'm not competent enough in autoconf to make a patch.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

