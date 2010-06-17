Message-ID: <4C1A0941.5000808@...515...>
Date: Thu, 17 Jun 2010 14:38:41 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4C19ED93.50202@...1380...>
In-Reply-To: <4C19ED93.50202@...1380...>
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to be
 username
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can't
> use "CN" to be username (few people can have the same "CN"). In our
> case, we only use the UID.
>
> With my patch, you can choose another field to be username with a new
> option called "x509-username-field", the default value is "CN".
>
> Best regards
>
> --=20
> Emilien Mantel
Hi Emilien,

Thanks for the patch! Could somebody with better C skills take a look
and see if it needs modifications?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


