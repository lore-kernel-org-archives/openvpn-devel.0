From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5605377D.9040401@...515...>
Date: Fri, 25 Sep 2015 15:01:01 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Help with build-testing a patched OpenVPN tree with
 Cygwin and Visual Studio?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

We'd need some help build-testing a patched[*] OpenVPN version with=20
Cygwin and Visual Studio:

<http://build.openvpn.net/downloads/temp/openvpn-2.3_git.tar.gz>

This tree already builds fine on mingw_w64 which is enough for doing the=20
official builds.

So please test these sources using Cygwin and/or Visual Studio and=20
report back how it went. If we do not get any "does not work reports"=20
within a week or so we'll have to merge the patch as-is and fix build=20
breakages later.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[*] The relevant patches are these:

<http://article.gmane.org/gmane.network.openvpn.devel/10165>
<http://article.gmane.org/gmane.network.openvpn.devel/10085>

