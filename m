MIME-Version: 1.0
In-Reply-To: <4F632647.30603@...515...>
References: <4F632647.30603@...515...>
Date: Fri, 16 Mar 2012 13:52:23 +0200
Message-ID: <CAOazyz1+mcBLnt7Uqd5_h75VmcLvWjXz1==u_-FW6wNOzcW+mQ@...278...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

Part of the reasoning was discussed here[1].

If we do not want to do auto detection, enabling optional components
may lead to configure failure, and force the user to explicitly
disable this feature.

It is possible, and I don't mind so much, however, I prefer configure
to use the minimum absolutely needed components by default, and in
majority of valid cases succeed.

Disabling by default does not effect users nor building via build
script nor building via package management (rpmbuild, deb). It only
effects people who build manually from sources. These people should
not only consider the lzo enable/disable but many more configure
options so lzo is no exception.

Alon.

[1] http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=3D5811

2012/3/16 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi all,
>
> In yesterday's meeting we reviewed this patch
>
> PATCH 39/52 build: proper lzo detection and usage
> =C2=A0URL: http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=
=3D5811
>
> The patch was ACKed, but there was disagreement whether LZO should be ena=
bled or disabled by default. Whichever the case, it will only affect people=
 building OpenVPN, not the end-users. Official builds will continue to have=
 LZO support.
>
> Opinions?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

