From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 27 Apr 2012 11:18:54 +0200
Message-ID: <2620278.PZKTmmtf1E@...1526...>
In-Reply-To: <4F9A5EB7.902@...515...>
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
	<4F9A5EB7.902@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2
	to UTF-8) at earliest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Friday 27 April 2012 09:54:15 Samuli Sepp=E4nen wrote:
> Anyways, I cross-compiled latest "master" with this patch applied and
> "bin" and "lib" directories on top of an existing openvpn-2.3-alpha1
> install. The old "bin" directory was renamed to make sure none of it was
> used. I then renamed "openvpn.ovpn" to "=E4=E4li=F6.ovpn" and "ta.key" to
> "=E4=E4li=F6.key" using Windows Explorer. Then I updated the configuration
> file to point to these files using Notepad (and later Wordpad).

Notepad saves UTF-8 files with BOM, which is very uncommon. Maybe that was =
the=20
problem. I ran into that when I was testing my patch. You might want to try=
=20
using Notepad++ and save it as UTF-8 without BOM.

HTH
Heiko
--=20
Heiko Hund | Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


