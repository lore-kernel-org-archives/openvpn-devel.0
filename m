MIME-Version: 1.0
In-Reply-To: <20100828024617.942.qmail@...1287...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
Date: Sat, 28 Aug 2010 07:34:09 +0300
Message-ID: <AANLkTinftXxDOX4J=njhby1oEKRtZUZGb57EgPdMiGsz@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
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
To: openvpn-devel@lists.sourceforge.net

On Sat, Aug 28, 2010 at 5:46 AM, Peter Stuge <peter@...1287...> wrote:
>
> Samuli Sepp=C3=A4nen wrote:
> > Discussed the "Some way of supporting static compilation" issue:
> >
> > <https://community.openvpn.net/openvpn/ticket/46>
> >
> > Did some testing to see if creating a static binary would be
> > trivial. As it was not,
>
> Why wasn't it? Please share details from the testing.

I guess the modules, pkcs11 and other components that uses dlopen
should be disabled in openvpn.

