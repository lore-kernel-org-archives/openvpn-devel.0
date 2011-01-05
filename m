Message-ID: <4D247F65.7000601@...515...>
Date: Wed, 05 Jan 2011 16:25:41 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4D24703E.70504@...515...> <4D24763A.1050406@...1114...>
In-Reply-To: <4D24763A.1050406@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Changed snprintf to _snprintf
	in	service-win32/openvpnserv.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

David Sommerseth ha scritto:
> On 05/01/11 14:21, Samuli Sepp=E4nen wrote:
> > This fixes a generic Windows/VC++ issue:
>
> >
> <http://thedailyreviewer.com/dotnet/view/strncasecmp-and-snprintf-functio=
ns-not-available-in-vc-109235975>
>
> > Does this change affect the automake/gcc-based Windows builds?
>
>
> I'm leaning towards a NAK on this one, as it might influence
> non-Visual C builds.  OpenVPN have openvpn_snprintf() which is a
> portable snprintf() function, and this one should be used instead.  It's
> found in buffer.[ch].
>
>
> kind regards,
>
> David Sommerseth
Yep, this is not an optimal solution. Some clarifications based on IRC
discussions.... openvpnserv.c uses it's own snprintf wrapper function
(=3Dmysnprintf) extensively. My modification changed snprintf into
_snprintf inside this wrapper function. I assume mysnprintf is used
instead of openvpn_snprintf (in buffer.c) to avoid dependency to openvpn
at code level. If we want to use openvpn_snprintf instead of mysnprintf,
I think we should change all references to mysnprintf into references to
openvpn_snprintf. This would avoid "double-wrapping" snprintf.

For your convenience, here are mysnprintf (with my _snprintf
modification) and openvpn_snprintf from buffer.c:

http://pastie.org/1431115

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

PS.. I sure learned how to write snprintf when writing this mail :D


