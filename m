Message-ID: <514055A3.5070808@...1227...>
Date: Wed, 13 Mar 2013 11:32:03 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <437RBuq1U8032S07.1361465626@...1810...>
In-Reply-To: <437RBuq1U8032S07.1361465626@...1810...>
Subject: Re: [Openvpn-devel] [PATCH] Fix parameter listing in non-debug
 builds at verb 4
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
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

Am 21.02.13 17:53, schrieb Josh Cepek:
> The patch is attached; a summary, and mitigating build suggestion follows:
>
> The current official Windows builds of 2.3.0 up to I004 are built
> enable_debug=3Dno; I'm not sure about the repo builds since I build from =
source
> on my non-Windows systems, but the same issue is present when lacking deb=
ug
> support on Linux/Unix. This causes such builds to lack parameter printing=
 at
> --verb 4 which conflicts with the help output and configure text for
> enable_small. This is a particular issue for binary installations (Window=
s, or
> binary *nix distros.)
>
> Until this change makes its way into the release repo branches, I'd sugge=
st
> all official builds be built with enable_debug=3Dyes. Without this build =
option,
> end-users will be unable to make use of increased verbosity/troubleshooti=
ng
> provided at verb 4.
>
>
> Commit/code reasoning for the patch: (also present in attached patch for
> convenience.) This patch applies to either the v2.3.0 tag, or current HEA=
D.
>
> When built with enable_debug=3Dno, the parameter output expected at --ver=
b 4 is
> not printed due to use of #ifdef ENABLE_DEBUG in the responsible code
> sections. This appears to be a mistake when looking at the configure help=
 text
> for enable_small and enable_debug.
>
> This change keys the relevant code off of enable_small instead, including=
 the
> parameter listing when enale_small=3Dno (the configure-script default.) M=
ost of
> this code is in options.c, with some callers present in plugin.c/h and
> route.c/h. No function code is changed, just the #ifdef values to use the
> small feature instead of debug.
>
> This means builds no longer need enable_debug=3Dyes in order to get the e=
xpected
> log output at verb 4.
>
Ack to the patch. I think it is reseanable to show the parameters in
higher debug output but enable_debug also enables *a lot* of other
output. Can you add a second patch or modify this patch to print a
warning at verb 7 (after a quick look all dmsg output are >=3D verb 7)
that debug is not enabled and messages from the output might be missing?

Arne


