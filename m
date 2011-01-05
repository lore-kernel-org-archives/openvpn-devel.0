Message-ID: <4D244FA8.8030909@...1114...>
Date: Wed, 05 Jan 2011 12:02:00 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D243F7C.5030202@...515...>
In-Reply-To: <4D243F7C.5030202@...515...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added automated configure.h
 creation to Python-based build system.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/01/11 10:53, Samuli Sepp=E4nen wrote:
> Hi all,
>=20
> Here's the first of a set of six patches that fix various issues with
> the Python-based build system. Also, some clarifying comments have been
> added to the existing code. After this patchset is merged it's possible
> to build openvpnserv.exe in addition to openvpn.exe and the TAP drivers.
> NSI installer integration is still mostly missing, but is coming up.
>=20
> This patch could be simplified by removing the #ifdef / #ifndef "depth"
> detection code. That code is a leftover from earlier implementation
> where all defines - not just #define ENABLE_SOMETHING - were parsed. The
> idea was to skip any defines inside an #ifdef block as there is no
> (easy) way to detect if they're enabled or not.
>=20
> Samuli

A few comments ...

+'''Generate a fake configure.h dynamically'''
+def build_configure_h(kv, configure_h_out, head_comment):

These two lines should be swapped.  Python places the
function/method/class documentation as a part of the block it describes.
 In addition, it is not a fake configure.h which is generated.  This is
the proper creation of configure.h, as that file should only contain
configuration information, no matter build system.

So a proper way would be:

def build_configure_h(kv, configure_h_out, head_comment):
        '''Generate a fake configure.h dynamically'''

Then you can do pydoc on the python file, or use the help() function in
python to get the documentation of a function/method/class/etc.

I suggest cleaning up these comments as a separate patch on top of this
patch.

Except of that, PATCH 1/6 gets an ACK from me.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0kT6QACgkQDC186MBRfroVVwCfcn3fsl6q1hCacpFd3rIYGomd
BHkAoJDPL6IGoD2k/AFwmoOpGP+TSLdp
=3DkDXE
-----END PGP SIGNATURE-----

