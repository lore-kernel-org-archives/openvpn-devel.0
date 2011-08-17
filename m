Message-ID: <4E4B873F.6080009@...515...>
Date: Wed, 17 Aug 2011 12:17:51 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CANdUpHPLMwTJRD69vo+ZUQi=wFQEX=s-5Lt72Xhvn+dW+1WtwA@...278...>
In-Reply-To: <CANdUpHPLMwTJRD69vo+ZUQi=wFQEX=s-5Lt72Xhvn+dW+1WtwA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Make easy-rsa/2.0/vars handle paths
 with whitespaces
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
To: Tanel Rebane <tanel@...1495...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hello,
>
> Line 29 of vars, export KEY_CONFIG=3D`$EASY_RSA/whichopensslcnf
> $EASY_RSA`, cannot handle whitespaces contained in $EASY_RSA. This
> line could be changed - depending on preference - to either of:
> a) export KEY_CONFIG=3D"`"${EASY_RSA}"/whichopensslcnf "${EASY_RSA}"`"
> b) export KEY_CONFIG=3D$("${EASY_RSA}"/whichopensslcnf "${EASY_RSA}")
>
> Regards,
> Tanel Rebane
>
> -------------------------------------------------------------------------=
-----
> FREE DOWNLOAD - uberSVN with Social Coding for Subversion.
> Subversion made easy with a complete admin console. Easy=20
> to use, easy to manage, easy to install, easy to extend.=20
> Get a Free download of the new open ALM Subversion platform now.
> http://p.sf.net/sfu/wandisco-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
Hi Tanel,

Both approaches seem POSIX-compliant. I'll do some tests and send in a
proper patch.

Btw. I noted that some of the easy-rsa scripts lack the customary
interpreter line (e.g. #!/bin/sh). We should probably fix that, too.

--=20

Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




