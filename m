Date: Sat, 12 Jul 2014 11:08:46 +0200 (CEST)
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <306985396.19324.1405156126494.JavaMail.zimbra@...1795...>
In-Reply-To: <53C07082.8060906@...1147...>
References: <53BF9998.5020906@...1921...> <53BFAF81.2080705@...1147...>
	<53BFC22C.5010601@...1227...> <53BFF9BE.1090204@...1147...>
	<20140711180758.GJ1118@...1296...>
	<53C02A4E.6040103@...1147...> <53C02E63.9070909@...1856...>
	<53C07082.8060906@...1147...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net


----- Original Message -----
> From: "Jan Just Keijser" <janjust@...1147...>
> To: "Steffan Karger" <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
> Sent: Saturday, 12 July, 2014 1:17:22 AM
> Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server configuration file
> 
> Hi,
> 
> On 11/07/14 20:35, Steffan Karger wrote:
> > Hi,
> >
> > On 11-07-14 20:17, Jan Just Keijser wrote:
> >> on CentOS 5 I get
> >>
> >> checking for SSL_OP_NO_TICKET flag in OpenSSL... no
> >> configure: error: OpenVPN 2.4+ requires SSL_OP_NO_TICKET in OpenSSL
> >>
> >> which is logical as the "stock" openssl lib on CentOS 5 is openssl 0.9.8
> >> ; to me, this breaks CentOS 5 builds, as I have no option nor desire to
> >> build & install openssl 1.0 on them.
> > Hmm, I actually checked that 0.9.8 (the minimum version supported by
> > 2.4) has SSL_OP_NO_TICKET. From the OpenSSL changelog:
> >
> > "Changes between 0.9.8e and 0.9.8f  [11 Oct 2007]
> > [...]
> > If a client or server wishes to disable RFC4507 support then the option
> > SSL_OP_NO_TICKET can be set."
> >
> > I expected distributions had incorporated that by now. Not sure whether
> > to add extra code here, or just declare it ancient and let distros/users
> > either backport newer OpenSSL or use 2.3.
> >
> >
> RHEL5 (on which CentOS 5 is based) includes openssl 0.9.8e + bug fixes
> and apparently no SSL_OP_NO_TICKET ; this will not change for the
> duration of RHEL5 which is a couple of more years, IIRC.
> 
> my question would be : why does openvpn need SSL_OP_NO_TICKET? why not
> #ifdef the code, e.g.
> 
>    SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3
>    #ifdef SSL_OP_NO_TICKET
>       | SSL_OP_NO_TICKET
>    #endif
>    );
> 
> (this is non-openvpn code) ?

I agree, this seems to be the best approach.  I suspect the issues related to 
SSL_OP_NO_TICKET has been resolved by Red Hat on EL5, but the fix may not have
provided that flag.

In addition, EL5 is the oldest distro we support (after we convinced James to
ditch EL4 when that went officially EOL; not counting the extended support
some few customers may pay for).


--
kind regards,

David Sommerseth

