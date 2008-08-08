Message-ID: <35f70db10808080726s42b672eja344ef7557bf0e24@...278...>
Date: Fri, 8 Aug 2008 16:26:47 +0200
From: "Ross Cameron" <ross.cameron@...1049...>
Sender: abalour@...277...
In-Reply-To: <200808081133.m78BXp4S030182@...1119...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_35903_26649181.1218205607917"
References: <200808081133.m78BXp4S030182@...1119...>
Subject: Re: [Openvpn-devel] OpenVPN and OpenSSL compatibility
Reply-To: ross.cameron@...1049...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jos Vos <jos@...1120...>
Cc: openvpn-devel@lists.sourceforge.net

------=_Part_35903_26649181.1218205607917
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

What Linux kernel and Glibc version's are you running on this box?

Why not statically compile the latest version of OpenVPN+OpenSSL
together????

Regards,...
Ross Cameron

On Fri, Aug 8, 2008 at 1:33 PM, Jos Vos <jos@...1120...> wrote:

> Hi,
>
> I'm trying to "port" OpenVPN to a rather old Linux system (for
> certain reasons...).  I tried both 2.0.9 and 2.1_rc9.  What I found:
>
> Compiling works ok for both versions (after a few trivial compiler
> compatibility fixes).
>
> But when testing a loopback connection with the loopback-{client,server}
> sample config files, this works ok for 2.0.9, but it fails for 2.1rc9 and
> the error I get is "could not extract Common Name from X509 subject":
>
> Fri Aug  8 10:33:40 2008 TLS: Initial packet from 127.0.0.1:56975,
> sid=2ca3e519 1141a566
> Fri Aug  8 10:33:40 2008 TLS: Initial packet from 127.0.0.1:56974,
> sid=ec182881 010bc533
> Fri Aug  8 10:33:40 2008 VERIFY OK: depth=1,
> /C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/Email=me@...430...
> Fri Aug  8 10:33:40 2008 VERIFY ERROR: could not extract Common Name from
> X509 subject string
> ('/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server/Email=me@...430...') --
> note that the Common Name length is limited to 64 characters
> Fri Aug  8 10:33:40 2008 TLS_ERROR: BIO read tls_read_plaintext error:
> error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify
> failed
> Fri Aug  8 10:33:40 2008 TLS Error: TLS object -> incoming plaintext read
> error
> Fri Aug  8 10:33:40 2008 TLS Error: TLS handshake failed
> Fri Aug  8 10:33:40 2008 TCP/UDP: Closing socket
> Fri Aug  8 10:33:40 2008 Closing TUN/TAP interface
>
> Looking at the code (ssl.c, verify_callback()) I see that in the 2.0.9
> version the code is somewhat different and that no error checking is
> done after the extract_x509_field() call.
>
> The OpenSSL version used on the old system is 0.9.6b.  Does this mean
> that OpenVPN is not compatible with OpenSSL 0.9.6b and that I also
> should not use 2.0.9 with that version (although at first sight the
> test does not show any problems)?  Or should I look somewhere else?
>
> Thanks for any suggestion to solve this,
>
> --
> --    Jos Vos <jos@...1120...>
> --    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
> --    Amsterdam, The Netherlands        |     Fax: +31 20 6948204
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

------=_Part_35903_26649181.1218205607917
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">What Linux kernel and Glibc version&#39;s are you running on this box?<br><br>Why not statically compile the latest version of OpenVPN+OpenSSL together????<br><br>Regards,...<br>Ross Cameron<br><br><div class="gmail_quote">
On Fri, Aug 8, 2008 at 1:33 PM, Jos Vos <span dir="ltr">&lt;<a href="mailto:jos@...1120...">jos@...1120...</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<br>
I&#39;m trying to &quot;port&quot; OpenVPN to a rather old Linux system (for<br>
certain reasons...). &nbsp;I tried both 2.0.9 and 2.1_rc9. &nbsp;What I found:<br>
<br>
Compiling works ok for both versions (after a few trivial compiler<br>
compatibility fixes).<br>
<br>
But when testing a loopback connection with the loopback-{client,server}<br>
sample config files, this works ok for 2.0.9, but it fails for 2.1rc9 and<br>
the error I get is &quot;could not extract Common Name from X509 subject&quot;:<br>
<br>
Fri Aug &nbsp;8 10:33:40 2008 TLS: Initial packet from <a href="http://127.0.0.1:56975" target="_blank">127.0.0.1:56975</a>, sid=2ca3e519 1141a566<br>
Fri Aug &nbsp;8 10:33:40 2008 TLS: Initial packet from <a href="http://127.0.0.1:56974" target="_blank">127.0.0.1:56974</a>, sid=ec182881 010bc533<br>
Fri Aug &nbsp;8 10:33:40 2008 VERIFY OK: depth=1, /C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/Email=me@...430...<br>
Fri Aug &nbsp;8 10:33:40 2008 VERIFY ERROR: could not extract Common Name from X509 subject string (&#39;/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server/Email=me@...430...&#39;) -- note that the Common Name length is limited to 64 characters<br>

Fri Aug &nbsp;8 10:33:40 2008 TLS_ERROR: BIO read tls_read_plaintext error: error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed<br>
Fri Aug &nbsp;8 10:33:40 2008 TLS Error: TLS object -&gt; incoming plaintext read error<br>
Fri Aug &nbsp;8 10:33:40 2008 TLS Error: TLS handshake failed<br>
Fri Aug &nbsp;8 10:33:40 2008 TCP/UDP: Closing socket<br>
Fri Aug &nbsp;8 10:33:40 2008 Closing TUN/TAP interface<br>
<br>
Looking at the code (ssl.c, verify_callback()) I see that in the 2.0.9<br>
version the code is somewhat different and that no error checking is<br>
done after the extract_x509_field() call.<br>
<br>
The OpenSSL version used on the old system is 0.9.6b. &nbsp;Does this mean<br>
that OpenVPN is not compatible with OpenSSL 0.9.6b and that I also<br>
should not use 2.0.9 with that version (although at first sight the<br>
test does not show any problems)? &nbsp;Or should I look somewhere else?<br>
<br>
Thanks for any suggestion to solve this,<br>
<br>
--<br>
-- &nbsp; &nbsp;Jos Vos &lt;<a href="mailto:jos@...1120...">jos@...1120...</a>&gt;<br>
-- &nbsp; &nbsp;X/OS Experts in Open Systems BV &nbsp; | &nbsp; Phone: +31 20 6938364<br>
-- &nbsp; &nbsp;Amsterdam, The Netherlands &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; Fax: +31 20 6948204<br>
<br>
-------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world<br>
<a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br>
</blockquote></div><br></div>

------=_Part_35903_26649181.1218205607917--

