Date: Fri, 13 Nov 2009 10:00:51 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <20091023142219.GA30874@...1066...>
	<4AE3580C.7080604@...41...> <20091026081943.GA29659@...1066...>
	<4AFC3F83.4090900@...41...> <20091112175924.GA10462@...1066...>
	<4AFC530C.9080303@...1114...>
	<20091113122836.GA6902@...1066...>
	<4AFD59A1.2090507@...1114...>
In-Reply-To: <4AFD59A1.2090507@...1114...> (from
	openvpn.list@...1114... on Fri Nov 13 07:05:37 2009)
Message-Id: <1258128051.5588.4@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 11/13/2009 07:05:37 AM, David Sommerseth wrote:

> When a broad part of the users have tested this over time, used it in
> production environment and bugs connected to this is fixed ... then=20
> we
> can consider to change the default behaviour, which normally would be
> done in connection to a new major release.=20=20

I agree that changes that break backwards compatibility should be
what triggers a change in the major release number.  But,
and I may be wrong here, I don't believe that OpenVPN has
adopted the practice -- in which case it makes little sense
to have a change in a major release number be the deciding
factor.

Your argument that the patch is not well enough tested
is enough to make me agree that the default should not
be changed now.=20


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


