Date: Fri, 13 Nov 2009 09:54:42 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <20091023142219.GA30874@...1066...>
	<4AE3580C.7080604@...41...> <20091026081943.GA29659@...1066...>
	<4AFC3F83.4090900@...41...> <20091112175924.GA10462@...1066...>
	<4AFC530C.9080303@...1114...>
	<20091113122836.GA6902@...1066...>
In-Reply-To: <20091113122836.GA6902@...1066...> (from vitus@...1066...
	on Fri Nov 13 06:28:36 2009)
Message-Id: <1258127682.5588.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Victor Wagner <vitus@...1066...>
Cc: openvpn-devel@lists.sourceforge.net

On 11/13/2009 06:28:36 AM, Victor Wagner wrote:

> It is possible to add ADDITIONAL configuration directive such as
> --allow-unicode-in-names, which doesn't  have such side-effect as
> no-name-remapping
> does now.
>=20
> But I think that this should be enabled by default. If someone cannot
> handle normal letters, he can disable them.

This makes sense.

But...

I am not very familiar with localization but there surely
must be commonly accepted idioms with respect to defaults
such as this and the locale settings.  Without knowing
anything about it my suggestion would be to enable
multi-byte characters by default _unless_ the locale
is C.  (Perhaps this is exactly what the locale settings
are supposed to be about?)

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


