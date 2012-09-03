Message-ID: <50445D74.9020500@...515...>
Date: Mon, 03 Sep 2012 10:34:12 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20120807093930.GK2535@...1296...>
	<1344333837-22076-1-git-send-email-arne@...1227...>
	<20120902184240.GI18296@...1296...>
In-Reply-To: <20120902184240.GI18296@...1296...>
Subject: Re: [Openvpn-devel] [Version 4] Merge getaddr_multi and getaddr6
 into one function
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> I ACK this, but please remember to tell your editor to use 8-character ta=
bs,
> as that is "what the rest of the code uses" - some of the new code looks
> quite weird with ":set ts=3D8", and there's more diffs in there due to=20
> whitespace changes (4 spaces getting converted into a single tab, like
> before 'hostname =3D "::"').  We do not need a v5 re-spin, as David said
> he'll take care of these.
>
> (Samuli: we need a style guide in the wiki...)
>
> gert
+1.

Anyone who knows what the current "standard" formatting please add
instructions here:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Formatti=
ng>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


