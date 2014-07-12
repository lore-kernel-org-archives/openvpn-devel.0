Date: Sat, 12 Jul 2014 12:41:14 +0200 (CEST)
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <63900614.19358.1405161674053.JavaMail.zimbra@...1795...>
In-Reply-To: <20140712094130.GM1118@...1296...>
References: <53BF9998.5020906@...1921...> <53BFF9BE.1090204@...1147...>
	<20140711180758.GJ1118@...1296...>
	<53C02A4E.6040103@...1147...> <53C02E63.9070909@...1856...>
	<53C07082.8060906@...1147...>
	<306985396.19324.1405156126494.JavaMail.zimbra@...1795...>
	<20140712094130.GM1118@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

----- Original Message -----
> From: "Gert Doering" <gert@...1296...>
> To: "David Sommerseth" <openvpn.list@...1114...>
> Cc: "Jan Just Keijser" <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
> Sent: Saturday, 12 July, 2014 11:41:30 AM
> Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server configuration file
>
> > In addition, EL5 is the oldest distro we support (after we convinced James
> > to
> > ditch EL4 when that went officially EOL; not counting the extended support
> > some few customers may pay for).
> 
> Any way to convince RH to pick up this security-relevant fix?

I haven't had time to check the changelog for openssl on EL5 (not close to /my/ 
computers).  But it wouldn't surprise me if they have already fixed this.  But as
SSL_OP_NO_TICKET was introduced in a newer base release than EL5 uses, they have
most likely solved it in another way.  Maybe by always adding this flag implicit?
(Which would have the benefit of not needing to recompile all OpenSSL
applications with this flaw).

IIRC, the guy overseeing the Secure Response Team in RH is Mark Cox, which again
is also an upstream OpenSSL maintainer.  So I'm quite sure all RH releases have
fixed this issue.


--
kind regards,

David Sommerseth

