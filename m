Message-ID: <4D2594F7.8000602@...68...>
Date: Thu, 06 Jan 2011 11:09:59 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D24703E.70504@...515...>
In-Reply-To: <4D24703E.70504@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Changed snprintf to _snprintf in
	service-win32/openvpnserv.c
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
To: openvpn-devel@lists.sourceforge.net

Am 05.01.2011 14:21, schrieb Samuli Sepp=E4nen:
> This fixes a generic Windows/VC++ issue:
>
> <http://thedailyreviewer.com/dotnet/view/strncasecmp-and-snprintf-functio=
ns-not-available-in-vc-109235975>
>
> Does this change affect the automake/gcc-based Windows builds?

NAK. Do not mess with the namespaces.

The whole mysnprintf macro looks suspicious and should be removed, as it
only works on static buffers. If you ever use it on dynamic buffers
(char *foo =3D malloc(4711); style), you're in for nasty surprises with
truncated strings -- and surprise means "prone to give maintenance head
aches".


If you must do it, use #ifdefs so it's only visible on Windows. The
canonical solution is to use AC_REPLACE([somefunction]) in
configure.{ac,in} and provide somefunction.c to contain a replacement
based on such boilerplate code:

#ifdef HAVE_CONFIG_H
#include "config.h"

#ifndef HAVE_SOMEFUNCTION
returntype somefunction( ...prototype... )
{
/* implementation */
}
#endif
#endif


The implementation can then be something along the lines of
arke_snprintf on
<http://social.msdn.microsoft.com/forums/en-US/vcgeneral/thread/2b339bdf-7a=
b1-4a08-bf7e-e9293801455b/>
but I'm not so sure about the license.

HTH

