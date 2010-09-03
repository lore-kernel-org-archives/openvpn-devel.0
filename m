From: Heiko Hund <hhund@...194...>
Date: Fri, 3 Sep 2010 13:15:23 +0200
References: <4C7EEF40.1050100@...1299...>
In-Reply-To: <4C7EEF40.1050100@...1299...>
MIME-Version: 1.0
Message-Id: <201009031315.23680.hhund@...194...>
Subject: Re: [Openvpn-devel] openvpn and dll hijacking?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On Thursday 02 September 2010 02:26:40 Jason Haar wrote:
>  While we're on the topic of Windows compiles, has there being an audit
> of DLL-dependencies in openvpn?

OpenVPN-GUI is not affected. I just checked with the instruction from=20
http://msdn.microsoft.com/en-us/library/ff919712%28VS.85%29.aspx.

It dynamically loads two libraries with the WIN32 API LoadLibrary function=
=20
during startup, shell32.dll and riched20.dll. shell32.dll is listed below t=
he=20
HKLM/System/CurrentControlSet/Control/Session Manager/KnownDLLs registry ke=
y=20
and therefore save. riched20.dll is part of any sane Windows installation a=
nd=20
located in the system32 folder. However, both are loaded without specifying=
=20
the complete path. I'll fix that soon, just for the sake of best practise.

If you use Dependency Walker on the binary with an up to date Windows XP,=20
you'll see that two .dlls can not be found, ieshims.dll and wer.dll. Both a=
re=20
a 5th level dependency coming from shell32.dll. Procmon didn't show any=20
unsuccessful attempts to load them, though. They are part of Windows starti=
ng=20
from Vista.

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

