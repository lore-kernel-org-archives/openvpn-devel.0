Date: Sat, 12 Jul 2014 14:55:21 +0200 (CEST)
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <1555229996.19407.1405169721263.JavaMail.zimbra@...1795...>
In-Reply-To: <20140712113109.GQ1118@...1296...>
References: <53BF9998.5020906@...1921...> <53C02A4E.6040103@...1147...>
	<53C02E63.9070909@...1856...> <53C07082.8060906@...1147...>
	<306985396.19324.1405156126494.JavaMail.zimbra@...1795...>
	<20140712094130.GM1118@...1296...>
	<63900614.19358.1405161674053.JavaMail.zimbra@...1795...>
	<20140712113109.GQ1118@...1296...>
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
> Cc: "Gert Doering" <gert@...1296...>, "Jan Just Keijser" <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
> Sent: Saturday, 12 July, 2014 1:31:09 PM
> Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server configuration file
> 
> Hi,
> 
> On Sat, Jul 12, 2014 at 12:41:14PM +0200, David Sommerseth wrote:
> > IIRC, the guy overseeing the Secure Response Team in RH is Mark Cox, which
> > again
> > is also an upstream OpenSSL maintainer.  So I'm quite sure all RH releases
> > have
> > fixed this issue.
> 
> Well, OpenSSL considers this a "feature", not an "issue"... and being
> able to turn off session resumption is also considered a "feature"...

Ahh, right!

I thought this was related to a CVE, but it seems not, according the
OpenSSL changelog I found on the net [1].  SSL_OP_NO_TICKET comes with the 
implementation of RFC4507, which was introduced in 0.9.8f.  I just double
checked EL5, and it uses 0.9.8e as the base version.  According to the 
RPM changelog, I don't see that RFC4507 has ever been backported.

From what I can grasp out of the OpenSSL changelog, RFC4507 is enabled by
default *if* compiled into OpenSSL.  And if it is compiled into OpenSSL, it can
be disabled by setting the SSL_OP_NO_TICKET flag.  Which would means 0.9.8e
should be safe in this aspect and EL5 is not vulnerable at all.

But it would be good if others can double this and see if I've understood this
correctly, just so I don't say anything wrong.

[1] <https://www.openssl.org/news/openssl-0.9.8-notes.html>


--
kind regards,

David Sommerseth

