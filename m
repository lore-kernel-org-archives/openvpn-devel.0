Message-ID: <532775DD.4050106@...515...>
Date: Mon, 17 Mar 2014 16:23:25 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317202910.GM16637@...1296...>
In-Reply-To: <20140317202910.GM16637@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 17/03/2014 14:29, Gert Doering wrote:
> Hi,
>
> On Sun, Mar 16, 2014 at 06:49:36PM -0600, James Yonan wrote:
>> However, even with the above code, stateless session resumption
>> is still possible unless explicitly disabled with the
>> SSL_OP_NO_TICKET flag.  This patch does this.
>
> This actually raises an interesting question.  My OpenSolaris buildslave
> fails compilation with
>
> gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../src/compat -g -O2 -MT ssl_openssl.o -MD -MP -MF .deps/ssl_openssl.Tpo -c -o ssl_openssl.o ssl_openssl.c
> ssl_openssl.c: In function `tls_ctx_set_options':
> ssl_openssl.c:183: error: `SSL_OP_NO_TICKET' undeclared (first use in this function)
>
> ... while "configure" doesn't flag an error about the OpenSSL version
> installed (0.9.8a-fips).  This is not ideal, if we know we're going to
> fail at compile time due to missing functionality, we should tell the
> user earlier.
>
> Right now, if I read configure.ac correct, we require 0.9.6 or later (and
> check this only if pkg-config is available) - but obviously, SSL_OP_NO_TICKET
> was added later on.
>
> Fix 1: only use SSL_OP_NO_TICKET if available
> Fix 2: require a more recent OpenSSL version

I would think an #ifdef should be fine.

James

