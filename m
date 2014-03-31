From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 31 Mar 2014 16:13:08 +0200
Message-ID: <1443881.kcztAJWLkP@...1526...>
In-Reply-To: <CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140323122624.GD16637@...1296...>
	<CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
	context for OpenSSL builds,
	to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sunday 23 March 2014 14:27:43 Steffan Karger wrote:
> +    AC_EGREP_CPP(have_ssl_op_no_ticket, [
> +    #include <openssl/ssl.h>

We just found that this breaks if the openssl headers are in a non-standard 
place. The test above sets the -I option in CFLAGS, but not in CPPFLAGS. So, 
maybe we should generally set -I in CPPFLAGS instead.

Heiko

