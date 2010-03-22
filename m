Date: Mon, 22 Mar 2010 22:39:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100322213947.GA25238@...1296...>
References: <4BA77760.6050801@...515...>
Mime-Version: 1.0
In-Reply-To: <4BA77760.6050801@...515...>
Subject: Re: [Openvpn-devel] [Fwd: Re: Clarifications to "OpenVPN will not
	connect through certain HTTP proxies" bug report]
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
Content-Disposition: inline
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Mar 22, 2010 at 03:57:52PM +0200, Samuli Sepp=E4nen wrote:
> I encountered this with T-mobile's t-zones web proxy. I haven't
> needed to use it lately, so I can't verify that the patch is still
> necessary. I don't know of any proxy servers that won't accept the
> http:// prefix, especially if the port number is 443.

As tested: this syntax neither works with Squid nor Apache.

So I'd tend to agree with David: if a single user had a problem with
a T-Home proxy in 2007, I'd tend to blaim the proxy.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

