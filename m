From: Heiko Hund <hhund@...194...>
Date: Mon, 23 Aug 2010 14:25:30 +0200
References: <201008132145.25557.hhund@...194...> <4C725A31.6000205@...1395...>
In-Reply-To: <4C725A31.6000205@...1395...>
MIME-Version: 1.0
Message-Id: <201008231428.26078.hhund@...194...>
Subject: Re: [Openvpn-devel] New openvpn-gui snapshot
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

On Monday 23 August 2010 13:23:29 Morten Christensen wrote:
> I want to work on a danish translation of the GUI. Is that possible /
> how can I start ?

Such contributions are very welcome. Unfortunately translation is a bit=20
cryptic as it's done with Windows resource files.

It's best you start with the English resource file [1] rename it openvpn-gu=
i-
res-dk.rc and translate the strings into Danish. You should leave the strin=
gs=20
with a IDS_ERR_* identifier in English as those will be removed in the near=
=20
future anyways. That will save you a lot of work. You can also look at the=
=20
other .rc files to see how it was done for other languages. If you have any=
=20
questions don't be afraid to ask.

When you're done just send me the .rc file and I'll integrate it.

Heiko

[1] http://openvpn-gui.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn-
gui/openvpn-gui;a=3Dblob;f=3Dopenvpn-gui-res-en.rc;hb=3DHEAD
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

