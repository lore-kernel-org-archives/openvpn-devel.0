Message-ID: <4D27CBA1.8080808@...68...>
Date: Sat, 08 Jan 2011 03:27:45 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D2714C1.6040000@...515...>
In-Reply-To: <4D2714C1.6040000@...515...>
Subject: Re: [Openvpn-devel] further mysnprintf discussion (was: Summary of
 the IRC meeting (6th Jan 2011))
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

Am 07.01.2011 14:27, schrieb Samuli Sepp=E4nen:

> Discussed the snprintf issue in service-win32/openvpnserv.c:
>=20
> <http://thread.gmane.org/gmane.network.openvpn.devel/4325>
>=20
> Apparently the least bad solution is to replace the mysnprintf function
> in openvpnserv.c with a copy of openvpn_snprintf function in buffer.c.
> Although this results in some duplicate code, it avoids creating a
> dependency from openvpnserv code to openvpn code: currently these
> codebases are completely separate. Also, including only one function
> ("openvpn_snprintf") from buffer.c object file is probably not possible.

Hi,

if you can include only one function from buffer.o depends on platform,
compilation environment, and thereabouts - and it requires that the program=
mer
puts up with changed semantics.  If that's all given, and if the build plat=
form
supports gcc's -ffunction-sections, it's possible, and I've been doing it o=
n a
MSP430-based embedded system for a different project for three years or so =
(and
with gcc4 you can use -fdata-sections) -- these options allow the linker to=
 take
out individual functions or data items out of an object file, without linki=
ng
the whole .o file -- but note that it can have minor ill side effects if you
play with dynamic linking, weak symbols, and possibly in other situations, =
for
instance, ID strings might go missing.

No idea if VC++ can do something similar, or Intel C++, or clang, or tcc, or
Codewarrior, or whatever else people use to compile

The alternative is to split out openvpn_snprintf plus its dependencies from
buffer.c to a separate source file. That would work everywhere and slice do=
wn
the ballast you're pulling in.

As a last resort, the openvpn_snprintf can become a separate file that gets
#include "..."-d by buffer.c and by service-win32/openvpnserv.c, then at le=
ast
you don't have the headaches to remember to change two places when fixing a=
 bug.

HTH & best regards

--=20
Matthias Andree

