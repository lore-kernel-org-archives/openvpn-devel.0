Date: Wed, 29 Feb 2012 11:50:17 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1599777492.20120229115017@...449...>
In-Reply-To: <1671265.SLJ8CLno3T@...1526...>
References: <4F4CE4FE.3010009@...515...> <4F4D1C29.5060606@...1114...>
	<CAOazyz1Wcj8ap9niXMs5pPW=3TvfG75NW7L_eHV_9aGQNcWP6g@...278...>
	<1671265.SLJ8CLno3T@...1526...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
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
To: openvpn-devel@lists.sourceforge.net

Hello Heiko,

> The idea to have the service do the privileged operations instead of just
> starting openvpn as "Local System" (or whatever) came from the fear of
> privilege escalation in the scripts that are run by openvpn.

Scripting is a point, but as long as the administrator installs
openvpn + config + script to a folder that is non writeable for users there
should be no problem.
