Subject: Re: [Openvpn-devel] OpenVPN 1.4.2 release candidate, please test
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1058070590.66582@...41...>
In-Reply-To: <20030712144359.GA14464@...33...>
References: <twig.1057855711.85674@...41...>, <twig.1057855711.85674@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jul 12 21:31:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Thu, 10 Jul 2003, James Yonan wrote:
> 
> > 
> > This is a maintenance release which (a) fixes the previously discussed ISO C99
> > vararg efficiency bug, and (b) further stabilizes the experimental
> > --mtu-dynamic option which causes OpenVPN to perform internal datagram
> > fragmentation in cases where native IP fragmentation is broken.
> > 
> > Testing will be helpful at this point, especially for non-x86-linux
platforms.    
> 
> I am only compile testing, not testing runtime; these are Sun Workshop
> warnings:
> 
> "crypto.c", line 838: warning: argument #3 is incompatible with prototype:
>         prototype: pointer to unsigned int :
"/usr/local/ssl/include//openssl/evp.h", line 551
>         argument : pointer to int
> "ssl.c", line 310: warning: argument #2 is incompatible with prototype:
>         prototype: pointer to unsigned char : "buffer.h", line 80
>         argument : pointer to char
> "ssl.c", line 1523: warning: argument #1 is incompatible with prototype:
>         prototype: pointer to const char : "options.h", line 191
>         argument : pointer to unsigned char

These look like the kind of warnings you get with the gcc -Wconversion flag --
though Sun Workshop must be using a different warning algorithm because gcc
-Wconversion generates pages of warnings about similar things -- basically
function prototypes causing an implicit type conversion.  Most of these are
pretty harmless.

Anyway, I've fixed them.

James


James


