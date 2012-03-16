Message-ID: <4F63679F.1050108@...1114...>
Date: Fri, 16 Mar 2012 17:17:35 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-31-git-send-email-alon.barlev@...277...>
	<4F632BEB.80504@...515...>
In-Reply-To: <4F632BEB.80504@...515...>
Subject: Re: [Openvpn-devel] [PATCH 30/52] build: add libtool + windows
 resources for executables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/03/12 13:02, Samuli Sepp=C3=A4nen wrote:
> Hi,
>=20
> This patch was ACKed in the IRC meeting on 15th Mar 2012:
>=20
> <http://thread.gmane.org/gmane.network.openvpn.devel/5992>
>=20
> However some of the lines in "src/openvpn/openvpn_win32_resources.rc"=20
> may need to be fixed:
>=20
> VALUE "CompanyName", "OpenVPN.net" VALUE "LegalCopyright", "Copyright
> =EF=BF=BD OpenVPN Project"
>=20
> Quoting=20
> http://msdn.microsoft.com/en-us/library/windows/desktop/aa381058%28v=3Dvs=
.85%29.aspx
>
>  "CompanyName    Company that produced the file, for example,
> "Microsoft Corporation" or "Standard Microsystems Corporation, Inc."
> This string is required."
>=20
> "LegalCopyright    Copyright notices that apply to the file. This
> should include the full text of all notices, legal symbols, copyright
> dates, and so on. This string is optional."
>=20
> I think we could use the same entity name (e.g. "OpenVPN project") in=20
> both fields. I also think that the choice of wording revolves around=20
> copyright ownership... in 2.1.x series James Yonan/OpenVPN
> Technologies, Inc. owned _most_ of the copyrights to the codebase.
> However, in this post-2.3-alpha1 age, copyrights to very large parts
> of the codebase belong to community developers. So, attributing
> copyright to "OpenVPN Technologies, Inc. and contributors" would
> probably not be proper.
>=20
> So, what should we call this "entity" that owns the copyrights to the=20
> codebase?

I would even go back to OpenVPN 2.2-beta1.  Which includes over 150
patches from the community.  But that's nit-picking.

I really think attributing the *project* is the better.  The company
itself does not really own the copyright to the contributed code.
However the community and the company are both heavily involved in the
project.

Just an idea ... what about to see how other open source projects solve
this in Windows builds?  Not sure about anything concrete, but maybe
virtio drivers for Windows is a place worth checking out?  (virtio
drivers in Windows are used for paravirt enabling when running as guest
on a KVM host; I believe these drivers are developed with a community
project these days)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9jZ5wACgkQDC186MBRfrogqgCeMA+4shPIDUvIMpHw2uYsSi3H
lLAAnAsqw5C4+Hli+PwqejYHkaGoavcN
=3D+TP5
-----END PGP SIGNATURE-----

