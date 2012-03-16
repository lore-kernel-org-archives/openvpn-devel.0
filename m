MIME-Version: 1.0
In-Reply-To: <4F633670.1000807@...1114...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
Date: Fri, 16 Mar 2012 14:56:06 +0200
Message-ID: <CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Mar 16, 2012 at 2:47 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> The impact on this change mainly hits packagers on the Linux, *BSD and
> Solaris packagers platforms - and those who do their own Windows builds.
> =C2=A0The official Windows builds we control and can make sure this featu=
re is
> enabled.

Please keep in mind that this is not the only change packager will
need to do when this is released.
I rewrote the Gentoo ebuild, in preparation for this.
I rewrote the spec file within the openvpn tree.
When release of beta, a large note should be written for other
packagers to update their packages for this version.

Alon.

