Date: Fri, 23 Apr 2010 13:56:47 +0300
From: Heikki Kallasjoki <heikki.kallasjoki@...124...>
Message-ID: <20100423105647.GG9696@...1355...>
References: <20100422111337.7ABB521DCF7@...1353...>
	<201004222237.31646.dave_br@...1278...>
	<4BD172C1.5090604@...1114...>
	<201004231135.05402.dave_br@...1278...>
MIME-Version: 1.0
In-Reply-To: <201004231135.05402.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH-fixed] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

A minor nitpick, but...

On Fri, Apr 23, 2010 at 11:35:05AM +0100, Davide Brini wrote:
> On Friday 23 Apr 2010 11:13:21 David Sommerseth wrote:
> > On 22/04/10 23:37, Davide Brini wrote:
> > > --- openvpn-2.1.1/ssl.c	2010-02-28 22:17:45.000000000 +0000
> > > +++ openvpn-2.1.1-a/ssl.c	2010-04-22 22:33:40.000000000 +0100
> > > @@ -788,9 +788,28 @@ verify_callback (int preverify_ok, X509_
> > >
> > >    /* export serial number as environmental variable */
> > >    {
> > > -    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber
> > > (ctx->current_cert)); +    BIO *bio = NULL;
> > > +    char serial[1024] = {0};
[...]
> > The initialisation is also rather bogus, as it will only put \0 in the
> > first byte, not the complete string.  It's better to instead use
> > CLEAR (serial) afterwards (which is a wrapper for memset()).
> 
> Ok, will do that. But anyway, since it's meant to be a string, I thought that 
> initializing it to '\0' would mean "empty string".

The initialization will, in fact, set all bytes of "serial" to zero.
Quoting the C standard (well, C89 draft is the closest I have):

"If there are fewer initializers in a list than there are members of
an aggregate, the remainder of the aggregate shall be initialized
implicitly the same as objects that have static storage duration."

Which means filling with zeroes:

"If an object that has static storage duration is not initialized
explicitly, it is initialized implicitly as if every member that has
arithmetic type were assigned 0 and [--]"

I.e. you cannot "partially" initialize an object: the array elements not
mentioned in the initializer are implicitly initialized to zero.  You
only get indeterminate values by omitting the initializer completely.
I guess it's concievable some compiler could get this wrong, though...

-- 
Heikki Kallasjoki
heikki.kallasjoki@...124...

